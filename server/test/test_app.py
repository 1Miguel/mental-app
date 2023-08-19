import unittest
import json
import httpx


class Test(unittest.IsolatedAsyncioTestCase):
    def setUp(self):
        print("setUp")

    async def asyncSetUp(self):
        print("asyncSetUp")
        self.client = httpx.Client()

    async def test_root_response(self):
        print(self.client)
        response = self.client.get("http://127.0.0.1:8000")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.text, '{"message":"Hello World"}')

    def tearDown(self):
        print("tearDown")

    async def asyncTearDown(self):
        print("asyncTearDown")

    async def on_cleanup(self):
        print("cleanup")


if __name__ == "__main__":
    unittest.main()
