import 'package:flutter/material.dart';
import 'package:upasthiti/starting_page/login.dart';

class ServerAddresh extends StatefulWidget {
  const ServerAddresh({Key? key}) : super(key: key);

  @override
  State<ServerAddresh> createState() => _ServerAddreshState();
}

class _ServerAddreshState extends State<ServerAddresh> {
  TextEditingController serverAddreshController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Center(
              child: Column(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: AssetImage('assets/logo.png'),
                    height: 200,
                    width: 300,
                  ),
                ],
              ),
            ),
            Text(
              'Enter Server Addresh',
              style: TextStyle(
                  color: Colors.grey[800], fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'field can\'t be empty ';
                      }
                      return null;
                      // if (!RegExp(
                      //         r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                      //     .hasMatch(value)) {
                      //   return 'Password requirement doesn\'t match';
                      // }
                      // return null;
                    }),
                    cursorColor: Colors.grey,
                    controller: serverAddreshController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        label: Text('Server Addresh',
                            style: TextStyle(color: Colors.grey[600])),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xffd13132)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 40),
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
