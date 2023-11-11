// Standard import
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

// Local import
import 'package:flutter_intro/controllers/signup_controller.dart';
import 'package:flutter_intro/controllers/login_controller.dart';
import 'package:flutter_intro/ui_views/admin_navigation_views.dart';
import 'package:flutter_intro/ui_views/login_captcha.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'dashboard_views.dart';
import 'mood_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

// External import
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:local_captcha/local_captcha.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class HeaderContentText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const HeaderContentText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 18 : 22;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 3,
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

InputDecoration getDecor(IconData icon, String hintText) {
  return InputDecoration(
    suffixIcon: Icon(icon),
    filled: true,
    fillColor: inputTextBoxFill,
    contentPadding: EdgeInsets.only(left: 30.0),
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    errorStyle: TextStyle(
      fontFamily: 'Open Sans',
      color: Colors.red,
      fontSize: 10,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: HexColor('#90A4AE'),
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.teal,
        width: 1.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.red,
        //width: 1.0,
      ),
    ),
  );
}

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
          color: primaryGrey,
          fontWeight: FontWeight.bold,
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

class CheckBoxExample extends StatefulWidget {
  final GlobalKey<FormState> formkey;

  const CheckBoxExample({super.key, required this.formkey});

  @override
  State<CheckBoxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckBoxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.grey;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
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

                if (kIsWeb) {
                  return AdminApp();
                } else {
                  return DashboardPage();
                }
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

  Future<String?> getLogOutState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  _onAlertCloseApp(context) {
    Alert(
        context: context,
        type: AlertType.warning,
        title: "Close App",
        desc: "Are you sure you want to close this app?",
        buttons: [
          DialogButton(
            onPressed: () {
              getLogOutState();
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        _onAlertCloseApp(context);
      },
      child: Container(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 120),
                Image.asset(
                  'images/pmha_logo.jpg',
                  fit: BoxFit.fitHeight,
                  height: 300,
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
                          color: Colors.teal),
                    ),
                    Text(
                      'HERE',
                      style: TextStyle(
                          fontFamily: 'Proza Libre',
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.lightGreen),
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(width: 2.0, color: loginDarkTeal),
                      ),
                    ),
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SignupPage())));
                  },
                ),
                // kIsWeb
                //     ? FilledButton(
                //         onPressed: () {
                //           if (kIsWeb) {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: ((context) => AdminApp())));
                //           }
                //         },
                //         style: ButtonStyle(
                //             minimumSize:
                //                 MaterialStateProperty.all<Size>(Size(200, 50)),
                //             backgroundColor: MaterialStateProperty.all<Color>(
                //                 primaryLightBlue)),
                //         child: Text(
                //           'ADMIN (TEMP DEBUG ONLY)',
                //           style: TextStyle(
                //               fontFamily: 'Open Sans',
                //               fontWeight: FontWeight.bold),
                //         ),
                //       )
                //     : SizedBox(height: 10),
              ],
            ),
          ],
        ),
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
  final _captchaFormKey = GlobalKey<FormState>();
  final _configFormKey = GlobalKey<FormState>();
  final _localCaptchaController = LocalCaptchaController();
  final _configFormData = ConfigFormData();
  LoginController loginController = Get.put(LoginController());
  bool agreementChecked = false;
  bool validEmail = false;

  var _inputCode = '';

  var isLogin = false.obs;

  @override
  void initState() {
    super.initState();
    loginController.emailController.clear();
    loginController.passwordController.clear();
  }

  @override
  void dispose() {
    loginController.emailController.clear();
    loginController.passwordController.clear();
    _localCaptchaController.dispose();

    super.dispose();
  }

  // _onPagePop(context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: ((context) => LoginMainPage())));
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return PopScope(
        canPop: true,
        // onPopInvoked: (value) {
        //   //_onPagePop(context);
        // },
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          body: Container(
            color: backgroundColor,
            height: constraint.maxHeight,
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Image.asset(
                        'images/pmha_logo_rembg.png',
                        fit: BoxFit.fitHeight,
                        height: 250,
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: constraint.maxWidth,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border(
                              top: BorderSide(color: loginDarkTeal, width: 2),
                              left: BorderSide(color: loginDarkTeal, width: 2),
                              right: BorderSide(color: loginDarkTeal, width: 2),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(50, 20),
                                topRight: Radius.elliptical(50, 20))),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 30.0, bottom: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: SizedBox(
                                  width: constraint.maxWidth - 40,
                                  child: Text(
                                    "Welcome",
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontFamily: 'Proza Libre',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: SizedBox(
                                  width: constraint.maxWidth - 40,
                                  child: Text(
                                    "Please login with your information",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontFamily: 'Proza Libre',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 3.0, left: 40.0),
                                child: InputDescription(desc: 'Email Address:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 12.0, left: 40, right: 40),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 40,
                                  child: TextFormField(
                                    style: inputStyle,
                                    cursorColor: Colors.teal,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        validEmail = false;
                                        return 'Please enter email';
                                      } else if (!EmailValidator.validate(
                                          value)) {
                                        validEmail = false;
                                        return 'Invalid email';
                                      }
                                      validEmail = true;
                                      return null;
                                    },
                                    controller: loginController.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: getDecor(
                                        validEmail == true
                                            ? Icons.check_box
                                            : Icons.email,
                                        ""),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      if (validEmail == true) {
                                        setState(() {
                                          validEmail = true;
                                        });
                                      } else {
                                        setState(() {
                                          validEmail = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 3.0, left: 40.0),
                                child: InputDescription(desc: 'Password:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 12.0, left: 40, right: 40),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 40,
                                  child: TextFormField(
                                    validator: (value) {
                                      String validPattern = '[^ a-zA-Z]';
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      if (value
                                          .contains(RegExp(validPattern))) {
                                        return 'Must not contain invalid characters';
                                      }
                                      if (value.length > 128 ||
                                          value.length < 8) {
                                        //validEmail = false;
                                        return 'Invalid password length';
                                      }
                                      return null;
                                    },
                                    controller:
                                        loginController.passwordController,
                                    obscureText: true,
                                    initialValue: null,
                                    decoration:
                                        getDecor(Icons.remove_red_eye, ""),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: constraint.maxWidth / 2 - 60,
                                      child: CheckboxListTileFormField(
                                        title: Text(
                                          "I'm not a robot",
                                          style: TextStyle(
                                            color: primaryGrey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        initialValue: false,
                                        onSaved: (bool? value) {
                                          print(value);
                                        },
                                        validator: (bool? value) {
                                          if (value! && agreementChecked) {
                                            return null;
                                          } else {
                                            return 'Required';
                                          }
                                        },
                                        onChanged: (value) {
                                          agreementChecked = true;
                                          if (value) {
                                          } else {}
                                        },
                                        errorColor: Colors.red.shade300,
                                        activeColor: Colors.teal,
                                        checkColor: Colors.white,
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        contentPadding:
                                            EdgeInsets.only(right: 1),
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraint.maxWidth / 2 - 80,
                                      child: TextButton(
                                        child: Text(
                                          'Forgot Password?',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 12, color: primaryGrey),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ForgotPasswordPage())));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50),
                              FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _onAlertWithCustomContentPressed(context);
                                  }
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(200, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          width: 2.0, color: loginDarkTeal),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "Verify",
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width - 100,
              child: Form(
                key: _captchaFormKey,
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    LocalCaptcha(
                      key: ValueKey(_configFormData.toString()),
                      controller: _localCaptchaController,
                      height: 150,
                      width: MediaQuery.sizeOf(context).width - 100,
                      backgroundColor: Colors.grey[100]!,
                      chars: _configFormData.chars,
                      length: _configFormData.length,
                      fontSize: _configFormData.fontSize > 0
                          ? _configFormData.fontSize
                          : null,
                      caseSensitive: _configFormData.caseSensitive,
                      codeExpireAfter: _configFormData.codeExpireAfter,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter captcha code',
                        hintText: 'Enter captcha code',
                        isDense: true,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final validation =
                              _localCaptchaController.validate(value);

                          switch (validation) {
                            case LocalCaptchaValidation.invalidCode:
                              return '* Invalid code.';
                            case LocalCaptchaValidation.codeExpired:
                              return '* Code expired.';
                            case LocalCaptchaValidation.valid:
                            default:
                              return null;
                          }
                        }

                        return '* Required field.';
                      },
                      onSaved: (value) => _inputCode = value ?? '',
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 40.0,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.refresh, size: 20),
                        onPressed: () => _localCaptchaController.refresh(),
                        label: const Text('New Code'),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (_captchaFormKey.currentState?.validate() ?? false) {
                _captchaFormKey.currentState!.save();
                Navigator.of(context, rootNavigator: true).pop();
                loginController.loginWithEmail();
              }
            },
            child: Text(
              "Verify Code",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.teal,
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(100, 20.0),
              ),
            ),
            title: Text(
              "Verification",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: backgroundColor,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 80,
                        child: Center(
                          child: Text(
                            "Please enter your email address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryGrey,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.normal,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width - 80,
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
                              decoration: getDecor(Icons.email, ""),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: REST API
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        ForgotPasswordEmailVerifyPage())));
                          }
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(200, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  BorderSide(width: 2.0, color: loginDarkTeal),
                            ),
                          ),
                        ),
                        child: Text(
                          'SEND',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ForgotPasswordEmailVerifyPage extends StatefulWidget {
  const ForgotPasswordEmailVerifyPage({super.key});

  @override
  ForgotPasswordEmailVerifyState createState() {
    return ForgotPasswordEmailVerifyState();
  }
}

class ForgotPasswordEmailVerifyState
    extends State<ForgotPasswordEmailVerifyPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.teal,
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(100, 20.0),
              ),
            ),
            title: Text(
              "Forgot Password",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: backgroundColor,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 80,
                        child: Center(
                          child: Text(
                            "An email with a verification code was sent to {email}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryGrey,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.normal,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width - 80,
                            child: Center(
                              child: Text(
                                "Enter Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: mainLightGreen,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width - 80,
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
                              decoration: getDecor(Icons.code, ""),
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO: REST API
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ChangePasswordPage())));
                            }
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(200, 50)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    width: 2.0, color: loginDarkTeal),
                              ),
                            ),
                          ),
                          child: Text(
                            'SEND',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.teal,
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(100, 20.0),
              ),
            ),
            title: Text(
              "Change Password",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: backgroundColor,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 80,
                        child: Center(
                          child: Text(
                            "Create a new, strong password for your account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryGrey,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.normal,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(bottom: 3.0, left: 40.0, top: 20),
                          child: InputDescription(desc: 'New Password:'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width - 80,
                            child: TextFormField(
                              validator: (value) {
                                String validPattern = '[^ a-zA-Z]';
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                if (value.contains(RegExp(validPattern))) {
                                  return 'Must not contain invalid characters';
                                }
                                if (value.length > 128 || value.length < 8) {
                                  return 'Invalid password length';
                                }
                                return null;
                              },
                              //keyboardType: TextInputType.name,
                              decoration: getDecor(Icons.remove_red_eye, ""),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 3.0, left: 40.0, top: 20.0),
                          child: InputDescription(desc: 'Confirm Password:'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width - 80,
                            child: TextFormField(
                              validator: (value) {
                                String validPattern = '[^ a-zA-Z]';
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                if (value.contains(RegExp(validPattern))) {
                                  return 'Must not contain invalid characters';
                                }
                                if (value.length > 128 || value.length < 8) {
                                  return 'Invalid password length';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: getDecor(Icons.remove_red_eye, ""),
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO: REST API
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ChangePasswordSuccessPage())));
                            }
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(200, 50)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    width: 2.0, color: loginDarkTeal),
                              ),
                            ),
                          ),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChangePasswordSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Container(
            color: backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset(
                  'images/success_logo.png',
                  fit: BoxFit.fitHeight,
                  height: 300,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Success!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mainLightGreen,
                          fontFamily: 'Proza Libre',
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 80,
                  child: HeaderContentText(
                      title:
                          'Congratulations! Your password has successfully been changed',
                      isOverflow: true,
                      isHeavy: true,
                      customColor: Colors.black87),
                ),
                SizedBox(height: 70),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginMainPage())));
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(width: 2.0, color: loginDarkTeal),
                      ),
                    ),
                  ),
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                        fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
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
  bool? checkboxIconFormFieldValue = false;
  bool agreementChecked = false;
  bool pwEditActive = true;
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  @override
  void dispose() {
    signupController.firstNameController.clear();
    signupController.lastNameController.clear();
    signupController.passwordController.clear();
    signupController.confirmPwdController.clear();
    signupController.emailController.clear();

    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   signupController.firstNameController.clear();
  //   signupController.lastNameController.clear();
  //   signupController.passwordController.clear();
  //   signupController.confirmPwdController.clear();
  //   signupController.emailController.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          extendBody: true,
          body: Container(
            color: Colors.teal,
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                          width: constraint.maxWidth - 40,
                          height: 150,
                          child: Text(
                            "Create an\nAccount",
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Proza Libre',
                              fontWeight: FontWeight.w900,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border(
                              top: BorderSide(color: backgroundColor, width: 2),
                              left:
                                  BorderSide(color: backgroundColor, width: 2),
                              right:
                                  BorderSide(color: backgroundColor, width: 2),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(50, 20),
                                topRight: Radius.elliptical(100, 50))),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [],
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 3.0, left: 40.0),
                                child: InputDescription(desc: 'First Name:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0, left: 40, right: 40.0),
                                child: SizedBox(
                                  width: constraint.maxWidth - 80,
                                  height: 60,
                                  child: TextFormField(
                                    style: inputStyle,
                                    validator: (value) {
                                      String validPattern = '[^ a-zA-Z]';
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      if (value
                                          .contains(RegExp(validPattern))) {
                                        return 'Must not contain invalid characters';
                                      }
                                      if (value.length > 128) {
                                        return 'Invalid name length.';
                                      }
                                      return null;
                                    },
                                    controller:
                                        signupController.firstNameController,
                                    initialValue: null,
                                    decoration: getDecor(Icons.person, ""),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5.0, left: 40, right: 40.0),
                                child: InputDescription(desc: 'Last Name:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: SizedBox(
                                  width: constraint.maxWidth - 80,
                                  height: 60,
                                  child: TextFormField(
                                    style: inputStyle,
                                    validator: (value) {
                                      String validPattern = '[^ a-zA-Z]';
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      if (value
                                          .contains(RegExp(validPattern))) {
                                        return 'Must not contain invalid characters';
                                      }
                                      if (value.length > 128) {
                                        return 'Invalid name length.';
                                      }
                                      return null;
                                    },
                                    controller:
                                        signupController.lastNameController,
                                    initialValue: null,
                                    decoration: getDecor(Icons.person, ""),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 3.0, left: 40.0),
                                  child: InputDescription(desc: 'Email:')),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0, left: 40, right: 40.0),
                                child: SizedBox(
                                  width: constraint.maxWidth - 80,
                                  height: 60,
                                  child: TextFormField(
                                    style: inputStyle,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter email';
                                      } else if (!EmailValidator.validate(
                                          value)) {
                                        return 'Invalid email';
                                      }
                                      return null;
                                    },
                                    controller:
                                        signupController.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: getDecor(Icons.email, ""),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 3.0, left: 40.0),
                                child: InputDescription(desc: 'Password:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0, left: 40, right: 40.0),
                                child: SizedBox(
                                  width: constraint.maxWidth - 80,
                                  height: 60,
                                  child: TextFormField(
                                    style: inputStyle,
                                    validator: (value) {
                                      String upperPattern = '^(.*?[A-Z]){1,}';
                                      String lowerPattern = '^(.*?[a-z]){1,}';
                                      String validPattern = '[^a-zA-Z]';

                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      if (value
                                          .contains(RegExp(validPattern))) {
                                        return 'Must not contain invalid characters';
                                      }
                                      if (!value
                                          .contains(RegExp(upperPattern))) {
                                        return 'Must contain 1 uppercase character';
                                      }
                                      if (!value
                                          .contains(RegExp(lowerPattern))) {
                                        return 'Must contain 1 lowercase character';
                                      }
                                      if (value.length > 128 ||
                                          value.length < 8) {
                                        return 'Invalid password length';
                                      }

                                      return null;
                                    },
                                    controller:
                                        signupController.passwordController,
                                    obscureText: true,
                                    initialValue: null,
                                    decoration:
                                        getDecor(Icons.remove_red_eye, ""),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 3.0, left: 40.0),
                                child:
                                    InputDescription(desc: 'Confirm Password:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0, left: 40, right: 40.0),
                                child: SizedBox(
                                  width: constraint.maxWidth - 80,
                                  height: 60,
                                  child: TextFormField(
                                    style: inputStyle,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      } else if (value !=
                                          signupController
                                              .passwordController.text) {
                                        print("value: $value");
                                        print(
                                            "controller: ${signupController.passwordController.text}");
                                        return 'Passwords do not match';
                                      } else if (value.length > 128) {
                                        return 'Invalid password length';
                                      }
                                      return null;
                                    },
                                    controller:
                                        signupController.confirmPwdController,
                                    obscureText: true,
                                    initialValue: null,
                                    decoration:
                                        getDecor(Icons.remove_red_eye, ""),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraint.maxWidth - 80,
                                child: CheckboxListTileFormField(
                                  title: Text(
                                    "By continuing, you agree to Philippine Mental Health Association - Mental Wellness Mobile Application's Terms and Conditions and Privacy Policy",
                                    softWrap: true,
                                    maxLines: 5,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 8,
                                    ),
                                  ),
                                  initialValue: false,
                                  onSaved: (bool? value) {
                                    print(value);
                                  },
                                  validator: (bool? value) {
                                    if (value! && agreementChecked) {
                                      return null;
                                    } else {
                                      return 'Please agree to policy before proceeding';
                                    }
                                  },
                                  onChanged: (value) {
                                    agreementChecked = true;
                                    if (value) {
                                      print("Agreement Checked :)");
                                    } else {
                                      print("Agreement Not Checked :(");
                                    }
                                  },
                                  errorColor: Colors.red.shade300,
                                  activeColor: Colors.teal,
                                  checkColor: Colors.white,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  contentPadding: EdgeInsets.all(1),
                                ),
                              ),
                              SizedBox(height: 10),
                              FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              SignupValidatePage(
                                                email: signupController
                                                    .emailController.text,
                                                onPressed: () {
                                                  signupController
                                                      .registerWithEmail();
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: ((context) =>
                                                  //             SignupSuccessPage())));
                                                },
                                              )),
                                        ));

                                    //
                                  }
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(200, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          width: 2.0, color: loginDarkTeal),
                                    ),
                                  ),
                                ),
                                child: Text('SIGN UP'),
                              ),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SignupValidatePage extends StatefulWidget {
  final String email;
  final VoidCallback onPressed;

  const SignupValidatePage({
    super.key,
    required this.email,
    required this.onPressed,
  });

  @override
  _SignupValidateState createState() {
    return _SignupValidateState(email: email, onPressed: onPressed);
  }
}

class _SignupValidateState extends State<SignupValidatePage> {
  final _formKey = GlobalKey<FormState>();
  EmailOTP myauth = EmailOTP();
  TextEditingController otp = TextEditingController();
  final String email;
  final VoidCallback onPressed;

  _SignupValidateState({required this.email, required this.onPressed});

  @override
  void initState() {
    super.initState();
    sendOtp();
  }

  void sendOtp() async {
    myauth.setConfig(
        appEmail: "pmhi.test.01@gmail.com",
        appName: "Email OTP",
        userEmail: "pmhi.test.01@gmail.com",
        otpLength: 6,
        otpType: OTPType.digitsOnly);

    if (await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("OTP has been sent"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Oops, OTP send failed"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.teal,
          automaticallyImplyLeading: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(100, 20.0),
            ),
          ),
          title: Text(
            "Verification",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            color: backgroundColor,
            child: ListView(
              children: [
                Container(
                  color: backgroundColor,
                  width: constraint.maxWidth,
                  height: (constraint.maxHeight / 8) * 7,
                  child: Column(
                    children: [
                      SizedBox(height: 200),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 150,
                          child: Text(
                            "Please enter the verification\ncode was sent to\n$email",
                            softWrap: true,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryGrey,
                              fontSize: 25,
                              fontFamily: 'Asap',
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            return null;
                          },
                          controller: otp,
                          decoration: getDecor(Icons.key, "OTP"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: FilledButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (await myauth.verifyOTP(otp: otp.text) ==
                                  true) {
                                onPressed();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Invalid OTP"),
                                ));
                              }
                            }
                            ;
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(200, 50)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    width: 2.0, color: loginDarkTeal),
                              ),
                            ),
                          ),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SignupSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: Container(
            color: backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset(
                  'images/success_logo.png',
                  fit: BoxFit.fitHeight,
                  height: 300,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Success!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mainLightGreen,
                          fontFamily: 'Proza Libre',
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 80,
                  child: HeaderContentText(
                      title:
                          'Congratulations! Your account has been successfully created',
                      isOverflow: true,
                      isHeavy: true,
                      customColor: Colors.black87),
                ),
                SizedBox(height: 70),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginMainPage())));
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(width: 2.0, color: loginDarkTeal),
                      ),
                    ),
                  ),
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                        fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name;

    if (prefs.containsKey('first_name')) {
      name = prefs.getString('first_name');
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => MoodLogCarouselPage())));
          },
          child: Container(
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
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data;
                      String welcomeString = 'Welcome,  $data!';
                      return ListView(
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
                                    customColor: Colors.teal),
                              )
                            ],
                          ),
                          Image.asset(
                            'images/welcome_logo.png',
                            fit: BoxFit.fitHeight,
                            height: 400,
                          ),
                          SizedBox(height: 80),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainHeadingText(
                                  title: 'Here for  ',
                                  isOverflow: false,
                                  isHeavy: true,
                                  customColor: Colors.teal),
                              MainHeadingText(
                                  title: 'you.',
                                  isOverflow: false,
                                  isHeavy: true,
                                  customColor: Colors.lightGreen),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainHeadingText(
                                  title: 'Here to  ',
                                  isOverflow: false,
                                  isHeavy: true,
                                  customColor: Colors.teal),
                              MainHeadingText(
                                  title: 'stay.',
                                  isOverflow: false,
                                  isHeavy: true,
                                  customColor: Colors.lightGreen),
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
      )),
    );
  }
}
