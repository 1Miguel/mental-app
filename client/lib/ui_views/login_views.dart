// Standard import
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

// Local import
import 'package:flutter_intro/controllers/signup_controller.dart';
import 'package:flutter_intro/controllers/login_controller.dart';
import 'package:flutter_intro/ui_views/admin_navigation_views.dart';
import 'package:flutter_intro/ui_views/login_captcha.dart';

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
        width: 1.0,
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
  void dispose() {
    loginController.emailController.clear();
    loginController.passwordController.clear();
    _localCaptchaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
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
                        padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
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
                              padding: EdgeInsets.only(bottom: 3.0, left: 40.0),
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
                              padding: EdgeInsets.only(bottom: 3.0, left: 40.0),
                              child: InputDescription(desc: 'Password:'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12.0, left: 40, right: 40),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width - 40,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    } else if (value.length > 128) {
                                      validEmail = false;
                                      return 'Invalid password';
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
                              padding:
                                  const EdgeInsets.only(left: 40.0, right: 40),
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
                                      contentPadding: EdgeInsets.only(right: 1),
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
              width: 300.0,
              child: Form(
                key: _captchaFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LocalCaptcha(
                      key: ValueKey(_configFormData.toString()),
                      controller: _localCaptchaController,
                      height: 150,
                      width: 300,
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: backgroundColor,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset(
                'images/pmha_logo_rembg.png',
                fit: BoxFit.fitHeight,
                height: 200,
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainHeadingText(
                        title: 'Philippine Mental\nHealth Association',
                        isHeavy: true,
                        isOverflow: true,
                        customColor: primaryBlue,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubHeadingText(
                          title: 'Account Recovery',
                          isOverflow: false,
                          isHeavy: true,
                          customColor: mainLightGreen),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 80,
                child: HeaderContentText(
                    title: 'Enter the email associated\nwith your account',
                    isOverflow: true,
                    isHeavy: true,
                    customColor: Colors.black54),
              ),
              SizedBox(height: 20),
              Padding(
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
                          decoration: getDecor(Icons.email, ""),
                        ),
                      ),
                    ),
                  ],
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
                                ForgotPasswordEmailVerifyPage())));
                  }
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainBlue)),
                child: Text('SEND'),
              ),
            ],
          ),
        ),
      ),
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
  final forgotEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: backgroundColor,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset(
                'images/pmha_logo_rembg.png',
                fit: BoxFit.fitHeight,
                height: 200,
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainHeadingText(
                        title: 'Philippine Mental\nHealth Association',
                        isHeavy: true,
                        isOverflow: true,
                        customColor: primaryBlue,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubHeadingText(
                          title: 'Account Recovery',
                          isOverflow: false,
                          isHeavy: true,
                          customColor: mainLightGreen),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 80,
                child: HeaderContentText(
                    title:
                        'Enter the verification code we just sent on your email address',
                    isOverflow: true,
                    isHeavy: true,
                    customColor: Colors.black54),
              ),
              SizedBox(height: 20),
              Padding(
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
                          decoration: getDecor(Icons.email, ""),
                        ),
                      ),
                    ),
                  ],
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainBlue)),
                child: Text('SEND'),
              ),
            ],
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

  @override
  Widget build(BuildContext context) {
    signupController.firstNameController.clear();
    signupController.lastNameController.clear();
    signupController.passwordController.clear();
    signupController.emailController.clear();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        color: backgroundColor,
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
                    height: 200,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    // decoration: BoxDecoration(
                    //     //color: Color.fromARGB(255, 240, 242, 243),
                    //     color: primaryBlue,
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(70),
                    //         topRight: Radius.circular(70))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: MainHeadingText(
                                      title:
                                          'Philippine Mental\nHealth Association',
                                      isHeavy: true,
                                      isOverflow: true,
                                      customColor: primaryBlue,
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
                                      title: 'PALAWAN',
                                      isHeavy: true,
                                      isOverflow: false,
                                      customColor: mainLightGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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
                                  controller:
                                      signupController.firstNameController,
                                  initialValue: null,
                                  decoration: getDecor(Icons.person, "")),
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
                                controller: signupController.lastNameController,
                                initialValue: null,
                                decoration: getDecor(Icons.person, ""),
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
                                decoration: getDecor(Icons.email, ""),
                              ),
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
                                  controller:
                                      signupController.passwordController,
                                  obscureText: true,
                                  initialValue: null,
                                  decoration:
                                      getDecor(Icons.remove_red_eye, "")),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 35,
                            child: CheckboxListTileFormField(
                              title: Text(
                                "Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data as a member of the Association. I understand the processing of my personal data shall be limited to the purpose specified.",
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
                              checkColor: Colors.white,
                              autovalidateMode: AutovalidateMode.disabled,
                              contentPadding: EdgeInsets.all(1),
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signupController.registerWithEmail();
                              }
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(200, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryLightBlue)),
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
  }
}

class SignupSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => LoginMainPage())));
        },
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset(
                'images/welcome_logo.png',
                fit: BoxFit.fitHeight,
                height: 300,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: MainHeadingText(
                        title: "Success!",
                        isOverflow: true,
                        isHeavy: true,
                        customColor: mainLightGreen),
                  )
                ],
              ),
              SizedBox(height: 70),
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
                        MaterialStateProperty.all<Color>(primaryLightBlue)),
                child: Text('CONTINUE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('first_name')!;
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
                        style: const TextStyle(fontSize: 18, color: Colors.red),
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
    ));
  }
}
