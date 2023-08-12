import 'package:flutter/material.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 140),
          Image.asset(
            'images/pmha_logo.jpg',
            fit: BoxFit.fitWidth,
            height: 400,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'WE ARE ',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    color: Colors.deepPurple),
              ),
              Text(
                'HERE',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    color: Colors.lightGreen),
              ),
            ],
          ),
          SizedBox(height: 80),
          FilledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SignupPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurple)),
            child: Text('Signup'),
          ),
          SizedBox(height: 15),
          FilledButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text(
                'Login',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.black),
              )),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Image.asset(
            'images/pmha_logo.jpg',
            fit: BoxFit.fitWidth,
            height: 250,
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign in to Continue',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 360,
            height: 70,
            child: TextFormField(
              initialValue: null,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 360,
            height: 60,
            child: TextFormField(
              obscureText: true,
              initialValue: null,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.grey),
            ),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurple)),
            child: Text('Login'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  icon: Image.asset('images/google_logo.png'),
                  iconSize: 5.0,
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  icon: Image.asset('images/facebook_logo.png'),
                  iconSize: 5.0,
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  icon: Image.asset('images/ios_logo.png'),
                  iconSize: 5.0,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: Text(
              'Go Back',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Image.asset(
            'images/pmha_logo.jpg',
            fit: BoxFit.fitWidth,
            height: 250,
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PHILIPPINE MENTAL',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEALTH ASSOCIATION',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PALAWAN',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 360,
            height: 70,
            child: TextFormField(
              initialValue: null,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 360,
            height: 70,
            child: TextFormField(
              initialValue: null,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 360,
            height: 70,
            child: TextFormField(
              obscureText: true,
              initialValue: null,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
          SizedBox(height: 20),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepPurple)),
            child: Text('Signup'),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 50)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: Text(
              'Go Back',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
