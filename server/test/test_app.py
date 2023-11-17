import sys
import json
import logging
import unittest
import requests
import random
from datetime import datetime
from typing import Dict, Tuple, Any

log = logging.getLogger(__name__)
# TODO: Add a flag if logging must be displayed in the terminal
#       flag can either be an env variable or from a file.
#       another option is for this to be in the unit test file.
log.setLevel(logging.DEBUG)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.DEBUG)
handler.setFormatter(logging.Formatter("%(levelname)s: %(asctime)-15s : %(message)s"))
log.addHandler(handler)

IP_ADDRESS = "192.168.1.10:8080"
USER_ID = random.randint(0, 100)


class _Helpers:
    """Baseclass that contains all helper functions.
    A TestCase child class must inherit this class."""

    def setUp(self):
        self.client = requests.Session()

    def tearDown(self):
        self.client.close()

    def helper_login_routine(self) -> Tuple[Dict[str, Any], Dict[str, Any]]:
        """Helper function for logging in.

        Returns:
            Tuple[Dict[str, str]]: Returns two things,
                the access token and the user profile.
        """
        headers = {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
        }
        data = {
            "grant_type": "password",
            "code": "1",
            "username": f"johndoe{USER_ID}@gmail.com",
            "password": "testpassword",
        }
        token = self.client.post(f"http://{IP_ADDRESS}/token", headers=headers, data=data).json()
        access_token = token["access_token"]
        token_type = token["token_type"]
        headers = {"Authorization": f"{token_type} {access_token}"}
        user = self.client.get(f"http://{IP_ADDRESS}/login", headers=headers)
        return headers, user.json()


class TestFeature1AccountFeature(_Helpers, unittest.TestCase):
    """Feature 1: Account Features.

      Requirements
    ----------------
        1. As a user I must be able to sign up and create an account.
            > email must be a valid email
            > must provide firstname and lastname
        2. As a user I must be able to login.
    """

    def test_account_feature_1p1_signup_create_an_account(self) -> None:
        """Test Creating a new user profile.

        Given: Server is running
         When: Client POST new user profile
          And: User profile does net yet exist and email is available
         Then: Server must respond with OK
         When: Client attempt to create user profile using the same email
         Then: Servier must respond with 409 Conflict.
        """
        headers = {"accept": "application/json", "Content-Type": "application/json"}
        new_user_req = {
            "email": f"johndoe{USER_ID}@gmail.com",
            "password": "testpassword",
            "firstname": "John",
            "lastname": "Doe",
        }
        response = self.client.post(f"http://{IP_ADDRESS}/signup", headers=headers, json=new_user_req)
        self.assertEqual(response.status_code, 200)

    def test_account_feature_1p2_user_login(self) -> None:
        headers = {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
        }
        data = {
            "grant_type": "password",
            "code": "1",
            "username": f"johndoe{USER_ID}@gmail.com",
            "password": "testpassword",
        }
        response = self.client.post(f"http://{IP_ADDRESS}/token", headers=headers, data=data)
        token = response.json()
        self.assertEqual(response.status_code, 200)
        self.assertIn("access_token", token)
        self.assertIn("token_type", token)
        access_token = token["access_token"]
        token_type = token["token_type"]
        headers = {"Authorization": f"{token_type} {access_token}"}
        response = self.client.get(f"http://{IP_ADDRESS}/login", headers=headers)
        self.assertEqual(response.status_code, 200)

        log.info("Succesfully login...")


class TestFeature2MoodLoggingFeature(_Helpers, unittest.TestCase):
    """Feature 2: Mood Logging.

      Requirements
    ----------------
        2.1. As a user I must be able to log my mood every day.
            > Must contain mood score
                HAPPY(1), SAD(2), CONFUSED(3), SCARED(4), ANGRY(5)
        2.2. As a user I must be able to GET all mood logs within a month.
            > With percentage statistics for each mood scores.
    """

    def __init__(self, methodName: str = "runTest") -> None:
        super().__init__(methodName)
        # test vars, this will be used consistently while testing the
        # mood logging feature.
        self.test_year = 2023
        self.test_month = 10

    def test_mood_logging_2p1_random_log_month(self) -> None:
        """Test Logging Mood today.

        Given: User is logged in
         When: Attempt to log mood for entire month
         Then: Server response must be ok
        """
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"
        notes = [
            "Feeling Happy!",
            "Feeling Sad",
            "Feeling Confused",
            "Feeling Scared",
            "Feeling Angry",
        ]
        for day in range(1, 24):
            # NOTE: This simulates logging mood thru out a month.
            # for each day, a random mood will be logged.
            rand_mood = 1 + int(random.random() * 4)
            new_mood = {
                "mood": rand_mood,
                "note": notes[rand_mood],
                "date": datetime(2023, 10, day).isoformat(),
            }
            log.info("Random mood logging %s", new_mood)
            # first time setting mood today
            response = self.client.post(f"http://{IP_ADDRESS}/user/mood/log/", headers=headers, json=new_mood)
            log.info("Returned response: %s", response)
            self.assertTrue(response.ok)

    def test_mood_logging_2p2_get_all_moods_this_month(self) -> None:
        """Test Requesting list of log moods for a given month.

        Given: Logged in
         When: Mood log list is requested with a given date
         Then: Server response must be ok
          And: Data must be returned.
        """
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"
        test_params = {"month": "2023-10-11"}

        log.info("Get Moods in %s-%s", self.test_year, self.test_month)
        test_response = self.client.get(
            f"http://{IP_ADDRESS}/user/mood/{self.test_year}/{self.test_month}/",
            headers=headers,
            params=test_params,
        )
        log.debug("Mood logs %s", test_response.json())
        self.assertTrue(test_response.ok)


class TestFeature3AppointmentScheduleFeature(_Helpers, unittest.TestCase):
    """Feature 3: appointment scheduling.

      Requirements:
    -------------------
        3.1. As a user I must be able to schedule an appointment.
        3.2. As a user I must be able to GET all blocked schedule.
        3.3. As a user I must be able to CANCEL appointment.
        3.4. As a user I must be able to GET UPCOMING appointments.
        3.5. As a user I must be able to GET PREVIOUS appointment.
        3.6. As a user I must be able to RESCHEDULE appointment.
    """

    def __init__(self, methodName: str = "runTest") -> None:
        super().__init__(methodName)
        self.test_month = 11
        self.test_year = 2023

    def test_appointment_schedule_3p1_schedule_appointment(self) -> None:
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"

        test_hour = 9
        test_duration = 1
        # rand must not repeat
        test_day_occured = []
        for test_day in range(1, 28):
            test_day_occured.append(test_day)
            test_json = {
                "start_time": datetime(self.test_year, self.test_month, test_day, test_hour, 0).isoformat(),
                "end_time": datetime(
                    self.test_year,
                    self.test_month,
                    test_day,
                    test_hour + test_duration,
                    0,
                ).isoformat(),
                "service": "PSYCHIATRIC_CONSULTATION",
                "concerns": "No Concerns.",
            }
            test_response = self.client.post(
                f"http://{IP_ADDRESS}/user/appointment/new/",
                headers=headers,
                json=test_json,
            )
            self.assertTrue(test_response.ok)
            log.info("scheduling: %s", test_json)

    def test_appointment_schedule_3p2_get_blocked_schedules(self) -> None:
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"

        test_day = int(random.random() * 30)
        test_hour = 9
        test_duration = 1
        test_json = {
            "start_time": datetime(self.test_year, self.test_month, test_day, test_hour, 0).isoformat(),
            "end_time": datetime(self.test_year, self.test_month, test_day, test_hour + test_duration, 0).isoformat(),
            "service": "COUNSELING",
            "concerns": "No Concerns.",
        }
        test_response = self.client.get(
            f"http://{IP_ADDRESS}/user/appointment/schedule/{self.test_year}/{self.test_month}/",
            headers=headers,
            json=test_json,
        )
        self.assertTrue(test_response.ok)

        for i in test_response.json():
            log.info("Block Schedule: %s", i)

    def test_appointment_schedule_3p3_cancel_appointment(self) -> None:
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"

        test_appointment_id = 1
        test_response = self.client.post(
            f"http://{IP_ADDRESS}/user/appointment/myschedule/{test_appointment_id}/cancel/",
            headers=headers,
        )
        test_response = self.client.get(
            f"http://{IP_ADDRESS}/user/appointment/myschedule/{test_appointment_id}",
            headers=headers,
        )
        self.assertTrue(test_response.ok)
        self.assertEqual("CANCELLED", test_response.json()["status"])
        log.debug("Appointment: %s", test_response.json())

    def test_appointment_schedule_3p4_get_upcoming_appointment(self) -> None:
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"
        test_response = self.client.get(
            f"http://{IP_ADDRESS}/user/appointment/myschedule/upcoming/",
            headers=headers,
        )
        self.assertTrue(test_response.ok)
        log.debug("Upcoming Appointment: %s", test_response.json())

    def test_appointment_schedule_3p5_get_previous_appointment(self) -> None:
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"
        test_response = self.client.get(
            f"http://{IP_ADDRESS}/user/appointment/myschedule/previous/",
            headers=headers,
            params={
                "limit": 5,
            },
        )
        self.assertTrue(test_response.ok)
        log.debug("Previous Appointment: %s", test_response.json())

    def test_appointment_schedule_3p6_reschedule_appointment(self) -> None:
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"

        # ---- 1. Get list of upcoming reschedule, pick the first one and reschedule
        test_response = self.client.get(
            f"http://{IP_ADDRESS}/user/appointment/myschedule/upcoming/",
            headers=headers,
        )
        test_upcoming_appointment = test_response.json()[0]
        test_appointment_id = test_upcoming_appointment["id"]
        log.info("upcoming appointment: %s", test_upcoming_appointment)

        # ---- 2. choose a random day
        test_day = int(random.random() * 30)
        test_hour = 9
        test_duration = 1
        test_new_appointment_json = {
            "start_time": datetime(self.test_year, self.test_month, test_day, test_hour, 0).isoformat(),
            "end_time": datetime(self.test_year, self.test_month, test_day, test_hour + test_duration, 0).isoformat(),
            "service": "COUNSELING",
            "concerns": "No Concerns.",
        }

        log.info("reschedule new appointment: %s", test_new_appointment_json)
        test_response = self.client.post(
            f"http://{IP_ADDRESS}/user/appointment/myschedule/{test_appointment_id}/reschedule/",
            headers=headers,
            json=test_new_appointment_json,
        )
        self.assertTrue(test_response.ok)
        self.assertEqual("PENDING", test_response.json()["status"])


class TestFeature4ThreadFeature(_Helpers, unittest.TestCase):
    """Feature 4: Community Thread scheduling.

      Requirements:
    -------------------
        4.1. As a user I must be able post in community thread.
            > Thread must contain:
                4.1.1. Subject
                4.1.2. Content
                4.1.3. Alias
        4.2. As a user I must be able to GET and see all thread in a front page.
            > must be able to GET and see number of likes a thread has.
            > As a user I must be able to GET and see the thread creator.
            > must be able to GET and see all comments in a thread.
        4.3. As a user I must be able to like a thread I find I like.
        4.4. As a user I must be able to POST a comment in a thread.
    """

    def __init__(self, methodName: str = "runTest") -> None:
        super().__init__(methodName)

    def test_thread_feature_4p1_user_post_thread(self) -> None:
        headers, _ = self.helper_login_routine()
        for thread_id in range(0, 10):
            thread_api = {
                "topic": f"My Test Topic {thread_id}",
                "content": f"My Test Content {thread_id}",
                "creator": "anoncreator",
            }
            test_response = self.client.post(
                f"http://{IP_ADDRESS}/user/thread/submit",
                headers=headers,
                json=thread_api,
            )
            self.assertTrue(test_response.ok)

    def test_thread_feature_4p2_GET_all_threads(self) -> None:
        """Test GET thread list.

        Given: User is logged in
         When: User GET all thread
         With: given limit
         Then: Server must respond with list of threads
          And: Length of list must be within limit given
          And: Server must respond with 200 OK
        """
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"

        test_limit = 5
        test_response = self.client.get(
            f"http://{IP_ADDRESS}/user/thread/page/0/?limit={test_limit}",
            headers=headers,
        )
        self.assertTrue(test_response.ok)
        self.assertLessEqual(len(test_response.json()), test_limit)
        for res in test_response.json():
            log.info("%s", res)

    def test_thread_feature_4p3_like_a_thread(self) -> None:
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"

        test_thread_id = 1

        test_response = self.client.get(f"http://{IP_ADDRESS}/user/thread/{test_thread_id}/", headers=headers)
        print("------------############------", test_response.json())
        expect_num_likes = test_response.json()["num_likes"] + 1

        test_like_rest_json = {"like": True}
        test_response = self.client.post(
            f"http://{IP_ADDRESS}/user/thread/{test_thread_id}/like/",
            headers=headers,
            json=test_like_rest_json,
        )
        self.assertTrue(test_response.ok)

        test_response = self.client.get(f"http://{IP_ADDRESS}/user/thread/{test_thread_id}/", headers=headers)
        self.assertTrue(test_response.ok)
        self.assertEqual(expect_num_likes, test_response.json()["num_likes"])

    def test_thread_feature_4p4_post_a_comment_in_thread(self) -> None:
        """Test POST thread comment.

        Given: User is logged in
         When: A user POST a comment to a thread
         Then: Server must respond with 200 OK

        But:
         When: User POST a comment to a thread that does not exist
         Then: Server must respond with 404 NOT FOUND

        """
        headers, _ = self.helper_login_routine()
        headers["accept"]: "application/json"

        test_data = {"content": "Test Comment"}

        test_response = self.client.post(
            f"http://{IP_ADDRESS}/user/thread/3/comment/",
            headers=headers,
            json=test_data,
        )
        self.assertTrue(test_response.ok)
        test_response = self.client.post(
            f"http://{IP_ADDRESS}/user/thread/99/comment/",
            headers=headers,
            json=test_data,
        )
        self.assertEqual(test_response.status_code, 404)


class TestFeature5AdminFeature(_Helpers, unittest.TestCase):
    """Feature 4:  AAdmin Features.

      Requirements:
    ----------------
        [4.1. Appointments]
            4.1.1. As an Admin I must be able to view all appointments.
            4.1.2. As an Admin I must be able to approve/decline/ignore appointment schedule.
    """


if __name__ == "__main__":
    unittest.main()
