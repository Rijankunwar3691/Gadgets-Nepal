// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'checkmail.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var email = "";
  final emailcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();

    super.dispose();
  }

  void validate() async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Email sent succesfully.',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.cyanAccent,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CheckMail(),
            ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('No user found for that email.',
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.cyanAccent,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: SizedBox(
            height: 500,
            width: 400,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reset password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 2,
                        color: Colors.black,
                      ),
                      const Text(
                          'Enter the email associated with your account and we will send an email with instructions to reset your password'),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formkey,
                        child: TextFormField(
                          onChanged: (value) => email = value,
                          controller: emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Email';
                            } else if (!value.contains('@')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              hintText: 'Enter your Email'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: validate,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            child: const Text('Send Instructions'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
