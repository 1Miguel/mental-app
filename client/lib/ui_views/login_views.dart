import 'package:flutter/material.dart';
import 'dashboard_views.dart';
import 'mood_views.dart';

// Common
// MainHeadingText
// SubHeading

class MainHeadingText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;

  const MainHeadingText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 25 : 40;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: Colors.deepPurple,
        fontFamily: 'Roboto',
        fontWeight: newWeight,
        fontSize: newSize,
      ),
    );
  }
}

class HeadingDescText extends StatelessWidget {
  final String title;

  const HeadingDescText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.deepPurple,
        fontFamily: 'Roboto',
        fontSize: 18,
      ),
    );
  }
}

class ContentBigHeadingText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color textColor;

  const ContentBigHeadingText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 35 : 45;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: textColor,
        fontFamily: 'Roboto',
        fontWeight: newWeight,
        fontSize: newSize,
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  final String title;
  final bool isHeavy;
  final Color textColor;

  const ContentText({
    super.key,
    required this.title,
    required this.isHeavy,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    FontWeight newWeight = isHeavy ? FontWeight.bold : FontWeight.normal;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 5,
      style: TextStyle(
        color: textColor,
        fontFamily: 'Roboto',
        fontWeight: newWeight,
        fontSize: 15,
      ),
    );
  }
}

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
                  MaterialPageRoute(builder: ((context) => LoginPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('LOGIN'),
          ),
          TextButton(
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SignupPage())));
            },
          ),
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
                  MainHeadingText(
                      title: 'Login', isOverflow: false, isHeavy: true),
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
                    obscureText: true,
                    initialValue: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 70),
          FilledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => WelcomePage())));
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: 50,
          //       height: 50,
          //       child: IconButton(
          //         icon: Image.asset('images/google_logo.png'),
          //         iconSize: 5.0,
          //         onPressed: () {},
          //       ),
          //     ),
          //     SizedBox(
          //       width: 50,
          //       height: 50,
          //       child: IconButton(
          //         icon: Image.asset('images/facebook_logo.png'),
          //         iconSize: 5.0,
          //         onPressed: () {},
          //       ),
          //     ),
          //     SizedBox(
          //       width: 50,
          //       height: 50,
          //       child: IconButton(
          //         icon: Image.asset('images/ios_logo.png'),
          //         iconSize: 5.0,
          //         onPressed: () {},
          //       ),
          //     ),
          //   ],
          // ),
          FilledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LoginMainPage())));
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
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.asset(
            'images/pmha_logo.jpg',
            fit: BoxFit.fitWidth,
            height: 250,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainHeadingText(
                title: 'Forgot\nPassword',
                isOverflow: false,
                isHeavy: true,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeadingDescText(
                title: 'Account Recovery',
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                child: Text(
                  "Please enter email or mobile number",
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          ForgotPasswordAccountRecoveryPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('NEXT'),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordAccountRecoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.asset(
            'images/pmha_logo.jpg',
            fit: BoxFit.fitWidth,
            height: 250,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainHeadingText(
                title: 'Forgot\nPassword',
                isOverflow: false,
                isHeavy: true,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeadingDescText(title: 'Account Recovery'),
            ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContentText(
                  title:
                      'An email with verification code was sent to\nhello@reallygreatsite.com',
                  isHeavy: false,
                  textColor: Colors.grey,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                child: Text(
                  "Enter Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  width: 315,
                  child: TextFormField(
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
          SizedBox(height: 60),
          FilledButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ChangePasswordPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('NEXT'),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  MainHeadingText(
                      title: 'Change\nPassword',
                      isOverflow: false,
                      isHeavy: true),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContentText(
                    title: 'Create a new, strong password for your\naccount',
                    isHeavy: true,
                    textColor: Colors.black,
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
                  "Create password",
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
                    obscureText: true,
                    initialValue: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                child: Text(
                  "Confirm password",
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
                    obscureText: true,
                    initialValue: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          FilledButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ChangePasswordSuccessPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('SAVE'),
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
    );
  }
}

class ChangePasswordSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Image.asset(
            'images/pmha_logo.jpg',
            fit: BoxFit.fitWidth,
            height: 200,
          ),
          SizedBox(height: 140),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContentBigHeadingText(
                title: 'Account recovered\n successfully!',
                isOverflow: true,
                isHeavy: true,
                textColor: Colors.deepPurple,
              ),
            ],
          ),
          SizedBox(height: 160),
          FilledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LoginPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('CONTINUE'),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 30),
          Image.asset(
            'images/pmha_logo.jpg',
            fit: BoxFit.fitWidth,
            height: 200,
          ),
          SizedBox(height: 20),
          Column(
            children: [
              MainHeadingText(
                title: 'PHILIPPINE MENTAL\nHEALTH ASSOCIATION',
                isOverflow: true,
                isHeavy: false,
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
          SizedBox(height: 60),
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
                    obscureText: true,
                    initialValue: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          FilledButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => SignupSuccessPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('SIGN UP'),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 10)),
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

class SignupSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              MainHeadingText(
                title: 'PHILIPPINE MENTAL\nHEALTH ASSOCIATION',
                isOverflow: true,
                isHeavy: false,
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
          SizedBox(height: 100),
          ContentBigHeadingText(
            title: 'You have signed up\n successfully!',
            isOverflow: true,
            isHeavy: true,
            textColor: Color.fromARGB(255, 0, 74, 173),
          ),
          SizedBox(height: 100),
          FilledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LoginMainPage())));
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 74, 173))),
            child: Text('CONFIRM'),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300, 10)),
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
