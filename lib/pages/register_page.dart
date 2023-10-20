// import 'package:flutter/material.dart';
// // import 'package:flutter_signin_button/flutter_signin_button.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// // import 'package:play_on/widget/button.dart';

// class RegisterDemo extends StatefulWidget {

//   const RegisterDemo({super.key});
//   @override
//   RegisterDemoState createState() => RegisterDemoState();
// }

// class RegisterDemoState extends State<RegisterDemo> {
//   late String email;
//   late String password;
//   bool isspinner = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // decoration: const BoxDecoration(
//       //     image: DecorationImage(
//       //         image: AssetImage("images/bgimage.jpg"), fit: BoxFit.cover)),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text("Welcome to Play On"),
//           backgroundColor: Colors.blue,
//         ),
//         body: ModalProgressHUD(
//           inAsyncCall: isspinner,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 const Padding(
//                   padding: EdgeInsets.only(top: 60.0),
//                   child: Center(
//                     child: SizedBox(
//                       width: 200,
//                       height: 150,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: TextField(
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                         icon: Icon(Icons.email_outlined),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                         labelText: 'Email ID',
//                         hintText: 'Enter registered email id'),
//                     onChanged: (value) {
//                       email = value;
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 15.0, right: 15.0, top: 15, bottom: 0),
//                   //padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                         icon: Icon(Icons.password),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                         labelText: 'Password',
//                         hintText: 'Enter Your Password'),
//                     onChanged: (value) {
//                       password = value;
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   height: 50,
//                   width: 250,
//                   decoration: BoxDecoration(
//                       // color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.blueAccent),
//                         shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(40),
//                         ))),
//                     onPressed: () async {
//                       setState(() {
//                         isspinner = true;
//                       });
//                       try {
//                         // final newUser =
//                         //     await _auth.createUserWithEmailAndPassword(
//                         //         email: email, password: password);
//                         // if (newUser != null) {
//                         //   Navigator.pushNamed(context,MyRoutes.registerRoute);
//                         // }
//                         // isspinner = false;
//                       } catch (e) {
//                         print(e);
//                       }
//                       setState(() {
//                         isspinner = false;
//                       });
//                     },
//                     // style: ButtonStyle(shape: ),
//                     child: Text(
//                       'Register',
//                       style: TextStyle(color: Colors.black, fontSize: 25),
//                     ),
//                   ),
//                 ),
//                 // Divider(),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 // SignInButton(
//                 //   padding: const EdgeInsets.only(right: 15, left: 15),
//                 //   Buttons.Google,
//                 //   onPressed: () {
//                 //     signInWithGoogle();
//                 //   },
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // void signInWithGoogle() async {
//   //   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   //   GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//   //   AuthCredential credential = GoogleAuthProvider.credential(
//   //     accessToken: googleAuth?.accessToken,
//   //     idToken: googleAuth?.idToken,
//   //   );
//   //   UserCredential userCredential =
//   //       await FirebaseAuth.instance.signInWithCredential(credential);
//   //   print(userCredential.user?.displayName);
//   //   if (userCredential != null) {
//   //     Navigator.pushNamed(context, RegistrationDemo.id);
//   //   }
//   // }
// }

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies_app/config.dart';
import 'package:movies_app/models/register_request_model.dart';
import 'package:movies_app/pages/login_page.dart';
import 'package:movies_app/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormkEY = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xfff403b58),
            body: ModalProgressHUD(
              inAsyncCall: isAPIcallProcess,
              child: Form(
                key: globalFormkEY,
                child: _registerUI(context),
              ),
              key: UniqueKey(),
              opacity: 0.3,
            )));
  }

  Widget _registerUI(BuildContext context) {
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
              "Register",
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context, "email", "Email",
                (onvalidateVal) {
              if (onvalidateVal == "") {
                return "Email can\'t be empty.";
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
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Register", () {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });
                RegisterRequestModel model = RegisterRequestModel(
                    username: username, password: password, email: email);
                APIService.register(model).then((value) => {
                  setState(() {
                  isAPIcallProcess = false;
                }),
                      if (value.data != null)
                        {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Registration Successfull.Please login to the account",
                              "OK", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }),
                        }
                      else
                        {
                          FormHelper.showSimpleAlertDialog(
                              context, Config.appName, value.message, "OK", () {
                            Navigator.pop(context);
                          })
                        }
                    });
              }
            },
                btnColor: Colors.red,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10),
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
