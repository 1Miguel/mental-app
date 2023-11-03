import sys
import json
import logging
import unittest
import requests
import random
import datetime
from typing import Dict, Tuple

# logger module
log = logging.getLogger("requests_oauthlib")
# TODO: Add a flag if logging must be displayed in the terminal
#       flag can either be an env variable or from a file.
#       another option is for this to be in the unit test file.
log.setLevel(logging.DEBUG)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.DEBUG)
handler.setFormatter(logging.Formatter("%(levelname)s: %(asctime)-15s : %(message)s"))
log.addHandler(handler)


class TestServer(unittest.TestCase):
    client: requests.Session

    def setUp(self):
        self.client = requests.Session()

    def tearDown(self):
        self.client.close()

    def test_log_mood_today(self) -> None:
        """Test Logging Mood today.

        Given: Today is a new day
         When: Attempt to log mood
         Then: Server response must be ok
         When: Attempt to log mood again
         Then: Server response must be
        """
        headers, _ = self.login_routine()
        headers["accept"]: "application/json"
        new_mood = {"mood": 0, "note": "Feeling happy!"}
        # first time setting mood today
        response = self.client.post(
            f"http://127.0.0.1:8000/user/mood", headers=headers, json=new_mood
        )
        self.assertTrue(response.ok)

    def test_log_mood_rand_a_month(self) -> None:
        """Test Logging Mood today.

        Given: User is logged in
         When: Attempt to log mood for entire month
         Then: Server response must be ok
        """
        headers, _ = self.login_routine()
        headers["accept"]: "application/json"

        notes = [
            "Feeling Happy!",
            "Feeling Sad",
            "Feeling Confused",
            "Feeling Scared",
            "Feeling Angry",
        ]

        for day in range(1, 24):
            today = datetime.datetime(2023, 10, day)
            rand_mood = int(random.random() * 4)
            new_mood = {"mood": rand_mood, "note": notes[rand_mood], "date": today.isoformat()}
            # first time setting mood today
            response = self.client.post(
                f"http://127.0.0.1:8000/user/mood", headers=headers, json=new_mood
            )
        self.assertTrue(response.ok)

    def test_get_log_mood_this_month(self) -> None:
        """Test Requesting list of log moods for a given month.

        Given: Logged in
         When: Mood log list is requested with a given date
         Then: Server response must be ok
          And: Data must be returned.
        """
        headers, _ = self.login_routine()
        headers["accept"]: "application/json"
        test_params = {"month": "2023-10-11"}

        test_response = self.client.get(
            "http://127.0.0.1:8000/user/mood/", headers=headers, params=test_params
        )
        self.assertTrue(test_response.ok)

    def test_set_scheduling_appointment_month(self) -> None:
        """Test Scheduling appointments for a given month.

        Given: Logged in
         When: Mood log list is requested with a given date
         Then: Server response must be ok
          And: Data must be returned.
        """
        headers, _ = self.login_routine()
        headers["accept"]: "application/json"
        test_params = {"month": "2023-10-11"}

        test_response = self.client.get(
            "http://127.0.0.1:8000/user/mood/", headers=headers, params=test_params
        )
        self.assertTrue(test_response.ok)

    def test_user_logout(self) -> None:
        """Test User logout.

        Given: User is login and user has token
         When: User logout
         Then: Server must return unauthorize access to all API request.
        """

    def test_membership_registration(self) -> None:
        """Test User Membership Registration"""
        headers, _ = self.login_routine()
        headers["accept"]: "application/json"
        with open("./test_file.txt", "rb") as file, open("./test_file_2.txt", "rb") as file_2:
            test_response = self.client.post(
                "http://127.0.0.1:8000/user/membership/register",
                headers=headers,
                # [('files', open('images/1.png', 'rb')), ('files', open('images/2.png', 'rb'))]
                files=[("files", file), ("files", file_2)],
                data={
                    "membership_api": json.dumps({"membership_type": 0}),
                },
            )
            self.assertTrue(test_response.ok)

    def test_submit_new_thread(self) -> None:
        """Test Submitting a new threads.

        Given: User is logged in
         When: User submits a new thread
         Then: Server must respond with 200 OK
         When: Thread is queried
         Then: Thread queried must contain recently submitted threads.
        """
        headers, _ = self.login_routine()
        headers["accept"]: "application/json"
        test_submit_req = {
            "topic": "My Test Topic",
            "content": "My Test Content",
        }
        test_response = self.client.post(
            "http://127.0.0.1:8000/user/thread/submit", headers=headers, json=test_submit_req
        )
        self.assertTrue(test_response.ok)

    def test_get_thread_info(self) -> None:
        """Test GET thread info.

        Given: User is logged in
         When: User GET a thread with a given thread_id
         Then: Server must respond with the thread data
          And: Server must respond with 200 OK

        But:
          When: User GET a thread that does not exist
          Then: Server must respond with 404 NOT FOUND
        """

        headers, _ = self.login_routine()
        headers["accept"]: "application/json"

        test_response = self.client.get("http://127.0.0.1:8000/user/thread/1", headers=headers)
        self.assertTrue(test_response.ok)

        test_response = self.client.get("http://127.0.0.1:8000/user/thread/99", headers=headers)
        self.assertEqual(test_response.status_code, 404)

    def test_get_thread_list(self) -> None:
        """Test GET thread list.

        Given: User is logged in
         When: User GET all thread
         With: given limit
         Then: Server must respond with list of threads
          And: Length of list must be within limit given
          And: Server must respond with 200 OK
        """
        headers, _ = self.login_routine()
        headers["accept"]: "application/json"

        test_limit = 5
        test_response = self.client.get(
            f"http://127.0.0.1:8000/user/thread/0/?limit={test_limit}", headers=headers
        )
        self.assertTrue(test_response.ok)
        self.assertLessEqual(len(test_response.json()), test_limit)


class _Helpers:
    def setUp(self):
        self.client = requests.Session()

    def tearDown(self):
        self.client.close()

    def helper_login_routine(self) -> Tuple[str, Dict[str, str]]:
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
            "username": "johndoe@gmail.com",
            "password": "testpassword",
        }
        token = self.client.post("http://127.0.0.1:8000/token", headers=headers, data=data).json()
        access_token = token["access_token"]
        token_type = token["token_type"]
        headers = {"Authorization": f"{token_type} {access_token}"}
        user = self.client.get("http://127.0.0.1:8000/login", headers=headers)
        return headers, user.json()


class TestAccountFeature(_Helpers, unittest.TestCase):
    """Feature: Account Features.

      Requirements
    ----------------
        1. As a user I must be able to sign up and create an account.
            > email must be a valid email
            > must provide firstname and lastname
        2. As a user I must be able to login.
    """

    def test_feature_signup_create_an_account(self) -> None:
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
            "email": "johndoe@gmail.com",
            "password": "testpassword",
            "firstname": "John",
            "lastname": "Doe",
        }
        response = self.client.post(
            "http://127.0.0.1:8000/signup", headers=headers, json=new_user_req
        )
        self.assertEqual(response.status_code, 200)

    def test_user_login(self) -> None:
        headers = {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
        }
        data = {
            "grant_type": "password",
            "code": "1",
            "username": "johndoe@gmail.com",
            "password": "testpassword",
        }
        response = self.client.post("http://127.0.0.1:8000/token", headers=headers, data=data)
        token = response.json()
        self.assertEqual(response.status_code, 200)
        self.assertIn("access_token", token)
        self.assertIn("token_type", token)

        access_token = token["access_token"]
        token_type = token["token_type"]
        headers = {"Authorization": f"{token_type} {access_token}"}
        response = self.client.get("http://127.0.0.1:8000/login", headers=headers)
        self.assertEqual(response.status_code, 200)


class TestMoodLoggingFeature(unittest.TestCase):
    """Feature: Mood Logging.

      Requirements
    ----------------
        1. As a user I must be able to log my mood every day.
            > Must contain mood score
                HAPPY(1), SAD(2), CONFUSED(3), SCARED(4), ANGRY(5)
        2. As a user I must be able to GET all mood logs within a month.
            > With percentage statistics for each mood scores.
    """


class TestAppointmentScheduleFeature(unittest.TestCase):
    """Test cases that tests the appointment schedule feature.

      Requirements:
    -------------------
        1. As a user I must be able to schedule an appointment.
        2. As a user I must be able to GET all blocked schedule.
        3. As a user I must be able to GET all upcoming appointments.
        4. As a user I must be able to GET all previous appointment history.
    """


class TestAdminFeature(unittest.TestCase):
    """Feature:  AAdmin Features.

      Requirements:
    ----------------
        [1. Appointments]
            1.1. As an Admin I must be able to view all appointments.
            1.2. As an Admin I must be able to approve/decline/ignore appointment schedule.
    """


if __name__ == "__main__":
    unittest.main()
