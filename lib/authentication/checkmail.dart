import 'package:ecommercenepal/authentication/resetpassword.dart';
import 'package:flutter/material.dart';

class CheckMail extends StatefulWidget {
  const CheckMail({Key? key}) : super(key: key);

  @override
  State<CheckMail> createState() => _CheckMailState();
}

class _CheckMailState extends State<CheckMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.mail,
              size: 50,
            ),
            const Text(
              'Check your mail',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: 200,
              child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const NewPassword(),
                    //     ));
                  },
                  icon: const Icon(Icons.email),
                  label: const Text('Open email app')),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Skip,I\'ll confirm later',
                  style: TextStyle(
                    letterSpacing: 1.0,
                  ),
                )),
            const Text(
              'Did not recieve the email?Check your spam filter,',
              style: TextStyle(letterSpacing: 1.0),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPassword(),
                      ));
                },
                child: const Text(
                  'try another email address',
                  style: TextStyle(letterSpacing: 1.0),
                ))
          ],
        ),
      ),
    );
  }
}
