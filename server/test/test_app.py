import os
import sys
import logging
import unittest
import requests
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

    def login_routine(self) -> Tuple[str, Dict[str, str]]:
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

    def test_root_response(self):
        """Test Root Response.

        Given: Server is running
         When: Client GET index page
         Then: Server must respond with hello message.
        """
        response = self.client.get("http://127.0.0.1:8000")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.text, '{"message":"Hello World"}')

    def test_create_a_new_user(self) -> None:
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
            "firstname": "john",
            "lastname": "doe",
        }
        response = self.client.post(
            "http://127.0.0.1:8000/signup", headers=headers, json=new_user_req
        )
        print(response.json())
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
        print(test_response.json())

    def test_user_logout(self) -> None:
        """Test User logout.

        Given: User is login and user has token
         When: User logout
         Then: Serve must return unauthorize access to all API request.
        """


if __name__ == "__main__":
    unittest.main()
