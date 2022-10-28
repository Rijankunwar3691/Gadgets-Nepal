import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var username = "";
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();

  bool _obscuretext = true;

  //validate function executes on button press====================
  void validate() async {
    if (formkey.currentState!.validate()) {
      try {
        // ignore: unused_local_variable
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Registered Succesfully.Please Login',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.cyanAccent,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.',
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.cyanAccent,
          ));
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.',
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.cyanAccent,
          ));
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.purple,
          body: Center(
            child: SizedBox(
              height: 500.0,
              width: 400.0,
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0,
                                    letterSpacing: 1.0),
                              ),
                            ),
                            const Divider(
                              height: 10.0,
                              thickness: 2,
                              color: Color.fromRGBO(0, 0, 0, 0.63),
                            ),
                            //user name input============================
                            TextFormField(
                              controller: usernamecontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Username';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(letterSpacing: 1.0),
                              ),
                            ),
                            //user name input closed============================

                            const SizedBox(
                              height: 10.0,
                            ),
                            //email input field================================

                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              controller: emailcontroller,
                              onChanged: (value) {
                                email = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                } else if (!value.contains('@')) {
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(letterSpacing: 1.0),
                              ),
                            ),
                            //email input field closed================================

                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: passwordcontroller,
                              autocorrect: false,
                              enableSuggestions: false,
                              obscureText: _obscuretext,
                              onChanged: (val) => password = val,
                              // assign the the multi validator to the TextFormField validator
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscuretext = !_obscuretext;
                                      });
                                    },
                                    child: Icon(_obscuretext
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  labelText: 'Password',
                                  labelStyle:
                                      const TextStyle(letterSpacing: 1.0)),
                            ),
                            TextFormField(
                              autocorrect: false,
                              enableSuggestions: false,
                              obscureText: _obscuretext,
                              validator: (val) => MatchValidator(
                                      errorText: 'passwords do not match')
                                  .validateMatch(val!, password),
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscuretext = !_obscuretext;
                                      });
                                    },
                                    child: Icon(_obscuretext
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  labelText: 'Confirm password',
                                  labelStyle:
                                      const TextStyle(letterSpacing: 1.0)),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Center(
                                child: SizedBox(
                              width: 150.0,
                              child: ElevatedButton(
                                onPressed: validate,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      letterSpacing: 1.0, fontSize: 20),
                                ),
                              ),
                            )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already a member?',
                                  style: TextStyle(letterSpacing: 1.0),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ));
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(letterSpacing: 1.0),
                                    ))
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
