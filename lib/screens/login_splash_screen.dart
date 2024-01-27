import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:medivault/constants.dart';
import 'package:medivault/screens/dashboard_screen.dart';
import 'package:medivault/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class LoginSplashScreen extends StatefulWidget {
  const LoginSplashScreen({Key? key}) : super(key: key);

  @override
  State<LoginSplashScreen> createState() => _LoginSplashScreenState();
}

class _LoginSplashScreenState extends State<LoginSplashScreen> {
  bool loading = false;
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
          child: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Hero(
                tag: "logo",
                child: SizedBox(
                  height: height * 0.06,
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              ImageSlideshow(
                indicatorRadius: 0,
                height: height * 0.45,
                width: double.infinity,
                autoPlayInterval: 2000,
                isLoop: true,
                disableUserScrolling: true,
                children: [
                  Image(
                    image: AssetImage('assets/pg1-bg1.png'),
                  ),
                  Image(
                    image: AssetImage('assets/pg1-bg2.png'),
                  ),
                  Image(
                    image: AssetImage('assets/pg1-bg3.png'),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              GestureDetector(
                onTap: () async {
                  final pref = await SharedPreferences.getInstance();
                  final mmid = pref.getString("mmid");
                  if (mmid == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => LoginScreen(),
                      ),
                    );
                  } else {
                    final LocalAuthentication auth = LocalAuthentication();
                    final bool didAuthenticate = await auth.authenticate(
                        localizedReason:
                            'Please authenticate to show account details');
                    if (didAuthenticate) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => DashboardScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => LoginScreen(),
                        ),
                      );
                    }
                  }
                },
                child: Hero(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
