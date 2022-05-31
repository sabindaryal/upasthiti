import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upasthiti/model/staff_model.dart';
import 'package:upasthiti/starting_page/login.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({Key? key}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  List<StaffModel> data = [];
  List<StaffModel> adddata = [];

  readData() async {
    final prefs = await SharedPreferences.getInstance();
    var items = prefs.getString('profile');
    var decoddata = [jsonDecode(items!)];
    print(decoddata.runtimeType);

    for (var i in decoddata) {
      adddata.add(StaffModel.fromJson(i));
    }
    setState(() {
      data = adddata;
    });
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('islogin');
    await prefs.remove('profile');
    await prefs.remove('token');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            color: Colors.grey[700],
            height: 200,
            width: double.infinity,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: InkWell(
                      onTap: () {
                        logout();
                      },
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Text(data.isNotEmpty ? data[0].name : ""),
              ],
            ),
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: [
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Image(
                      image: AssetImage('assets/profile.png'),
                      height: 70,
                    ),
                    Text('My Profile')
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Image(
                      image: AssetImage('assets/attendence.png'),
                      height: 70,
                    ),
                    Text('Attendence')
                  ],
                ),
              )
            ],
          )
        ])),
      ),
    );
  }
}
