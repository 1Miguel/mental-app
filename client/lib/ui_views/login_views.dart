// Standard import
import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/controllers/signup_controller.dart';
import 'package:flutter_intro/controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_views.dart';
import 'mood_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

// External import
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hexcolor/hexcolor.dart';

// Common
// MainHeadingText
// SubHeading

// Constants

class MainHeadingText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const MainHeadingText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 20 : 40;
    //Overwrite size based on length
    newSize = (title.length > 15) ? 25 : 30;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: customColor,
        fontFamily: 'Proza Libre',
        fontWeight: newWeight,
        fontSize: newSize,
      ),
    );
  }
}

class SubHeadingText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const SubHeadingText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 13 : 18;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: customColor,
        fontFamily: 'Open Sans',
        fontWeight: newWeight,
        fontSize: newSize,
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const WelcomeText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 25 : 30;
    //Overwrite based on length as needed
    newSize = (title.length > 25) ? 25 : 30;
    FontWeight newWeight = isHeavy ? FontWeight.w700 : FontWeight.w900;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: customColor,
        fontFamily: 'Proza Libre',
        fontWeight: newWeight,
        fontSize: newSize,
      ),
    );
  }
}

final TextStyle inputStyle = TextStyle(
  fontFamily: 'Open Sans',
  color: Colors.black87,
  fontSize: 13,
);

final InputDecoration decor = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.only(left: 30.0),
  errorStyle: TextStyle(
    fontFamily: 'Open Sans',
    color: Colors.red,
    fontSize: 10,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.0,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
      color: HexColor('#90A4AE'),
      width: 1.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
      color: HexColor('#01579B'),
      width: 1.0,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.0,
    ),
  ),
);

class InputDescription extends StatelessWidget {
  final String desc;

  const InputDescription({
    super.key,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 40,
      child: Text(
        desc,
        style: TextStyle(
          color: HexColor('#607D8B'),
          fontFamily: 'Open Sans',
        ),
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
  Future<String?> getLoggedInState() async {
    String? logged_in;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('islogged_in')) {
      logged_in = prefs.getString('islogged_in')!.toUpperCase();
    } else {
      logged_in = "false";
    }
    return logged_in;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: getLoggedInState(),
        initialData: "false",
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'An ${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              if (data == 'false') {
                return LoginMainView();
              } else {
                // TODO: check one day interval for moods
                // expirationDay = lastDailyCheck.add(oneDayDuration);
                // isOneDayAfter = DateTime.now().isAfter(expirationDay);
                return DashboardPage();
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginMainView extends StatelessWidget {
  const LoginMainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 120),
        Image.asset(
          'images/pmha_logo.jpg',
          fit: BoxFit.fitWidth,
          height: 400,
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WE ARE ',
              style: TextStyle(
                  fontFamily: 'Proza Libre',
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: mainDeepPurple),
            ),
            Text(
              'HERE',
              style: TextStyle(
                  fontFamily: 'Proza Libre',
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: mainLightGreen),
            ),
          ],
        ),
        SizedBox(height: 50),
        FilledButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => LoginPage())));
          },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
              backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
          child: Text(
            'LOGIN',
            style:
                TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          child: Text(
            'SIGN UP',
            style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => SignupPage())));
          },
        ),
      ],
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
  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    loginController.emailController.clear();
    loginController.passwordController.clear();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    MainHeadingText(
                      title: 'LOGIN',
                      isHeavy: true,
                      isOverflow: false,
                      customColor: mainDeepPurple,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SubHeadingText(
                        title: 'Sign in to Continue',
                        isOverflow: false,
                        isHeavy: true,
                        customColor: mainDeepPurple),
                  ],
                ),
              ],
            ),
            SizedBox(height: 70),
            Container(
              width: MediaQuery.sizeOf(context).width - 20,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 242, 243),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                      child: InputDescription(desc: 'Email:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
                        child: TextFormField(
                          style: inputStyle,
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
                          decoration: decor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                      child: InputDescription(desc: 'Password:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
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
                          decoration: decor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 80),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  loginController.loginWithEmail();
                }
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                ),
              ),
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
                    fontFamily: 'Open Sans', fontSize: 12, color: Colors.black),
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
                    MainHeadingText(
                        title: 'Forgot\nPassword',
                        isOverflow: false,
                        isHeavy: true,
                        customColor: mainDeepPurple),
                  ],
                ),
              ],
            ),
            SizedBox(height: 100),
            Container(
              width: MediaQuery.sizeOf(context).width - 20,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 242, 243),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                      child: InputDescription(desc: 'Email:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
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
                          decoration: decor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                  backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
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
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    signupController.nameController.clear();
    signupController.passwordController.clear();
    signupController.emailController.clear();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            SizedBox(height: 15),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: MainHeadingText(
                        title: 'SIGNUP',
                        isHeavy: true,
                        isOverflow: false,
                        customColor: mainDeepPurple,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: SubHeadingText(
                        title: 'Create an Account',
                        isHeavy: true,
                        isOverflow: true,
                        customColor: mainDeepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.sizeOf(context).width - 20,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 242, 243),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                      child: InputDescription(desc: 'First Name:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
                        height: 60,
                        child: TextFormField(
                            style: inputStyle,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            controller: signupController.nameController,
                            initialValue: null,
                            decoration: decor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                      child: InputDescription(desc: 'Last Name:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
                        height: 60,
                        child: TextFormField(
                          style: inputStyle,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          //controller: signupController.nameController,
                          initialValue: null,
                          decoration: decor,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                        child: InputDescription(desc: 'Email:')),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
                        height: 60,
                        child: TextFormField(
                            style: inputStyle,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                            controller: signupController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: decor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                      child: InputDescription(desc: 'Password:'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
                        height: 60,
                        child: TextFormField(
                            style: inputStyle,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            controller: signupController.passwordController,
                            obscureText: true,
                            initialValue: null,
                            decoration: decor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signupController.registerWithEmail();
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
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('first_name')!.toUpperCase();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => MoodModalPage())));
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: FutureBuilder(
              future: getUserName(),
              initialData: null,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'An ${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    String welcomeString = 'WELCOME   $data';
                    return Column(
                      children: [
                        SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: MainHeadingText(
                                  title: welcomeString,
                                  isOverflow: false,
                                  isHeavy: true,
                                  customColor: mainDeepPurple),
                            )
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
                            MainHeadingText(
                                title: 'HERE FOR  ',
                                isOverflow: false,
                                isHeavy: true,
                                customColor: mainDeepPurple),
                            MainHeadingText(
                                title: 'YOU',
                                isOverflow: false,
                                isHeavy: true,
                                customColor: mainLightGreen),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MainHeadingText(
                                title: 'HERE TO  ',
                                isOverflow: false,
                                isHeavy: true,
                                customColor: mainDeepPurple),
                            MainHeadingText(
                                title: 'STAY',
                                isOverflow: false,
                                isHeavy: true,
                                customColor: mainLightGreen),
                          ],
                        ),
                      ],
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
