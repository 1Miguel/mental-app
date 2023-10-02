// Standard import
import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/controllers/signup_controller.dart';
import 'package:flutter_intro/controllers/login_controller.dart';
import 'dashboard_views.dart';
import 'mood_views.dart';

// External import
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

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
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('SIGN UP'),
          ),
          FilledButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 10)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text(
                'LOGIN',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
        ],
      ),
    );
  }
}

// Login Form Widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  SignupController signupController = Get.put(SignupController());
  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                  child: Text(
                    "Please enter email",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: 315,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      controller: loginController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                  child: Text(
                    "Please enter password",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: 315,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      controller: loginController.passwordController,
                      obscureText: true,
                      initialValue: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  loginController.loginWithEmail();
                }
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 74, 173))),
              child: Text('LOGIN'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ForgotPasswordPage())));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 10)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 12, color: Colors.grey),
              ),
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
                'Go Back (DEBUG ONLY)',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ForgotPasswordState createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final forgotEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
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
                      'Forgot',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.deepPurple),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.deepPurple),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New Password',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.deepPurple),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                  child: Text(
                    "Please enter email",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: 315,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: REST API
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 74, 173))),
              child: Text('SEND'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupState createState() {
    return SignupState();
  }
}

class SignupState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset(
              'images/pmha_logo.jpg',
              fit: BoxFit.fitWidth,
              height: 200,
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
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                  child: Text(
                    "Please enter your name",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: 315,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      initialValue: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                  child: Text(
                    "Please enter your email",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: 315,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                  child: Text(
                    "Please enter your password",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: 315,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      initialValue: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: REST API
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => LoginMainPage())));
                }
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 74, 173))),
              child: Text('SIGN UP'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => MoodModalPage())));
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME, USER!',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
              Image.asset(
                'images/welcome_logo.png',
                fit: BoxFit.fitWidth,
                height: 400,
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HERE FOR ',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.deepPurple),
                  ),
                  Text(
                    'YOU',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HERE TO ',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.deepPurple),
                  ),
                  Text(
                    'STAY',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TheraphyIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => ForgotPasswordPage())));
        },
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.asset(
                'images/therapy_logo.png',
                fit: BoxFit.fitWidth,
                height: 400,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Therapy & Care',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'We will continue to enhance',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'individual and collective well-being',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'for a mentally stable Philippines!',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
              SizedBox(height: 40),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DashboardPage())));
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 0, 74, 173))),
                child: Text('GET STARTED'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
