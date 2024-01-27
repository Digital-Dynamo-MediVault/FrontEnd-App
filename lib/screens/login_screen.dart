import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Center(
                  child: Hero(
                    tag: "logo",
                    child: SizedBox(
                      height: height * 0.06,
                      child: Image(
                        image: AssetImage("assets/logo.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  "LOGIN",
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
                  onSubmitted: (String value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Hello"),
                      ),
                    );
                  },
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
                  "OTP",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: height * 0.008,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.005,
                ),
                Text(
                  "Resend OTP",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff0038BB),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Hero(
                  tag: "login",
                  child: Container(
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    height: height * 0.08,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff18A9BC),
                          Color(0xff236B72),
                        ],
                      ),
                      // color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    transform: Matrix4.translationValues(40, 0, 0),
                    height: height * 0.25,
                    child: Image(
                      image: AssetImage(
                        'assets/pg2-bg.png',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
