import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController image;
  late ScrollController main;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController addressp = TextEditingController();
  TextEditingController blood = TextEditingController();
  TextEditingController guardian = TextEditingController();
  TextEditingController pid = TextEditingController();
  TextEditingController guardianp = TextEditingController();
  TextEditingController phone = TextEditingController();

  getData() async {
    final pref = await SharedPreferences.getInstance();
    email.text = pref.getString("email") ?? "test@gmail.com";
    name.text = pref.getString("name") ?? "Name";
    age.text = pref.getString("age") ?? "20";
    gender.text = pref.getString("gender") ?? "Male";
    addressp.text = pref.getString("addressp") ?? "Final";
    blood.text = pref.getString("bloodGroup") ?? "O-";
    guardian.text = pref.getString("guardian") ?? "Guardian";
    pid.text = pref.getString("pid") ?? "PID";
    guardianp.text = pref.getString("guardianp") ?? "00";
    phone.text = pref.getString("phone") ?? "00";
  }

  @override
  void initState() {
    super.initState();
    getData();

    _controllers = LinkedScrollControllerGroup();
    image = _controllers.addAndGet();
    main = _controllers.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: ListView(
              controller: image,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.chevron_left,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.18,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage(
                      "assets/pg3-bg1.png",
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image(
                      image: AssetImage(
                        "assets/pg3-bg3.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.3,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage(
                      "assets/pg3-bg2.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: ListView(
                controller: main,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  SizedBox(
                    height: height * 0.06,
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/logo.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Text(
                    "PROFILE",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    "Patient ID".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: pid,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Name".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: name,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Email".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: email,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Age".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: age,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Gender".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: gender,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Address".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: addressp,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Blood Group".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: blood,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Guardian".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: guardian,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "Guardian Phone".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: guardianp,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "phone number".toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                  TextField(
                    enabled: false,
                    controller: phone,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
