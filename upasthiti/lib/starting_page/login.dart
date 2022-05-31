import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upasthiti/common/base_url.dart';
import 'package:upasthiti/frontPages/staff_page.dart';

import "package:http/http.dart" as http;
import 'package:upasthiti/starting_page/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool seePassword = false;
  final snackbar = const SnackBar(content: Text("Invalid email or password "));
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = jsonEncode({
      "username": emailController.text,
      "password": passwordController.text,
      "device_token":
          "eEcu_X4XMkspr7fsv6IlrL:APA91bFcUP60TtS7Nf-WMBhpxhFbXLuzYvVmo6e7Iczct6oNH3XUFrM1k0J2sr5pkQ-RGbF7Sssf7JWY5CZnEiApFnq5lvj4MajFpKZ7aqr32Jzxn1IR6W_zoJO7-vl-163q3xnEQ9QS"
    });
    try {
      final response =
          await http.post(loginurl, body: body, headers: requestHeaders);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        prefs.setString('profile', jsonEncode(data['data']));
        prefs.setString('token', data['api_token']);
        prefs.setBool('islogin', true);
        return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const StaffPage()),
            (Route<dynamic> route) => false);
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'Login to your Account',
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          label: Text('Email',
                              style: TextStyle(color: Colors.grey[600])),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      cursorColor: Colors.grey,
                      controller: passwordController,
                      obscureText: seePassword ? true : false,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          label: Text('Password',
                              style: TextStyle(color: Colors.grey[600])),
                          suffixIcon: IconButton(
                            icon: Icon(seePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                seePassword = !seePassword;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          )),
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
                          login();
                          // if (formKey.currentState!.validate()) {
                          //   formKey.currentState!.save();

                          // }
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 9, horizontal: 40),
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Center(child: Text('Or Sign in with')),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                      child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        size: 30,
                      ),
                    ),
                  )),
                  SizedBox(width: 10),
                  SizedBox(
                      child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 30,
                      ),
                    ),
                  )),
                  SizedBox(width: 10),
                  SizedBox(
                      child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 30,
                      ),
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignupPage();
                      }));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: Color(0xffd13132),
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
