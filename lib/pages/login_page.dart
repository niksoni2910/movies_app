// import 'package:flutter/material.dart';
// import 'package:movies_app/utils/routes.dart';
// import 'package:velocity_x/velocity_x.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String name = "";
//   bool changeButton = false;
//   final _formkey = GlobalKey<FormState>();
//   moveToHome(BuildContext context) async {
//     if (_formkey.currentState!.validate()) {
//       setState(() {
//         changeButton = true;
//       });
//       await Future.delayed(const Duration(seconds: 1));
//       await Navigator.pushNamed(context, MyRoutes.homeRoute);
//       setState(() {
//         changeButton = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: context.canvasColor,
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formkey,
//             child: Column(
//               children: [
//                 Image.asset(
//                   "assests/images/hey.png",
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "welcome $name",
//                   style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 16.0, horizontal: 32.0),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         decoration: const InputDecoration(
//                             hintText: "Enter username", labelText: "username"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "username cannot be empty";
//                           }
//                           return null;
//                         },
//                         onChanged: (value) {
//                           name = value;
//                           setState(() {});
//                         },
//                       ),
//                       TextFormField(
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                             hintText: "Enter password", labelText: "password"),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "password cannot be empty";
//                           } else if (value.length < 6) {
//                             return "password length should be atleast 6";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Material(
//                         color: Colors.lightBlueAccent,
//                         borderRadius:
//                             BorderRadius.circular(changeButton ? 50 : 8),
//                         child: InkWell(
//                           onTap: () => moveToHome(context),
//                           child: AnimatedContainer(
//                             duration: const Duration(seconds: 1),
//                             height: 50,
//                             width: changeButton ? 50 : 150,
//                             alignment: Alignment.center,
//                             child: changeButton
//                                 ? const Icon(
//                                     Icons.done,
//                                     color: Colors.white,
//                                   )
//                                 : const Text(
//                                     "Login",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/config.dart';
import 'package:movies_app/models/login_request_model.dart';
import 'package:movies_app/pages/home_page.dart';
import 'package:movies_app/pages/register_page.dart';
import 'package:movies_app/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormkEY = GlobalKey<FormState>();
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xfff403b58),
            body: ModalProgressHUD(
              inAsyncCall: isAPIcallProcess,
              child: Form(
                key: globalFormkEY,
                child: _loginUI(context),
              ),
              key: UniqueKey(),
              opacity: 0.3,
            )));
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assests/images/hey.png",
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "username",
            "Username",
            (onvalidateVal) {
              if (onvalidateVal == "") {
                return "Username can\'t be empty.";
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
            },
            prefixIcon: Icon(Icons.person),
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context, "password", "Password",
                (onvalidateVal) {
              if (onvalidateVal == "") {
                return "Password can\'t be empty.";
              }
              return null;
            }, (onSavedVal) {
              password = onSavedVal;
            },
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                prefixIcon: Icon(Icons.person),
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white.withOpacity(0.7),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ))),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      children: [
                    TextSpan(
                        text: 'Forget Password?',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Forget Password");
                          }),
                  ])),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Login", () {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });
                LoginRequestModel model =
                    LoginRequestModel(username: username, password: password);
                APIService.login(model).then((value) => {
                      setState(() {
                  isAPIcallProcess = true;
                }),
                      if (value)
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()))
                        }
                    });
              } else {
                FormHelper.showSimpleAlertDialog(
                    context, Config.appName, "Invalid Uername/Password", "OK",
                    () {
                  Navigator.pop(context);
                });
              }
            },
                btnColor: Colors.red,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      children: [
                    TextSpan(text: "Don't have an Account"),
                    TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          }),
                  ])),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormkEY.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
