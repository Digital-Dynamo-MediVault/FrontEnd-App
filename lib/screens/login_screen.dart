import 'package:flutter/material.dart';
import 'package:medivault/constants.dart';
import 'package:medivault/screens/dashboard_screen.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController id = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return loading
        ? Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          )
        : Scaffold(
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
                        keyboardType: TextInputType.emailAddress,
                        controller: id,
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
                        "PASSWORD",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.008,
                      ),
                      TextField(
                        obscureText: visible,
                        keyboardType: TextInputType.name,
                        controller: pass,
                        decoration: InputDecoration(
                          suffix: GestureDetector(
                            onTap: () {
                              visible = !visible;
                              setState(() {});
                            },
                            child: Transform(
                              transform: Matrix4.translationValues(
                                0,
                                4,
                                0,
                              ),
                              child: Icon(
                                visible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          if (id.text == "" || pass.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Enter details"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            Response res = await Dio().post(
                              "https://sapphire-fly-sari.cyclic.app/patient/login",
                              data: {
                                "email": id.text,
                                "password": pass.text,
                              },
                              options: Options(
                                followRedirects: false,
                                validateStatus: (status) {
                                  return status! < 500;
                                },
                              ),
                            );
                            if (res.statusCode! > 199 &&
                                res.statusCode! < 300) {
                              print(res.data);
                              final pref =
                                  await SharedPreferences.getInstance();
                              await pref.setString(
                                'mmid',
                                res.data["user"]!["metamaskAddress"],
                              );
                              await pref.setString(
                                'email',
                                res.data["user"]!["email"],
                              );
                              await pref.setString(
                                'name',
                                res.data["user"]!["name"],
                              );
                              await pref.setString(
                                'age',
                                res.data["user"]!["age"].toString(),
                              );
                              await pref.setString(
                                'gender',
                                res.data["user"]!["gender"],
                              );
                              await pref.setString(
                                'addressp',
                                res.data["user"]!["addressp"],
                              );
                              await pref.setString(
                                'bloodGroup',
                                res.data["user"]!["bloodGroup"],
                              );
                              await pref.setString(
                                'guardian',
                                res.data["user"]!["guardian"],
                              );
                              await pref.setString(
                                'pid',
                                res.data["user"]!["pId"].toString(),
                              );
                              await pref.setString(
                                'guardianp',
                                res.data["user"]!["guardianp"].toString(),
                              );
                              await pref.setString(
                                'phone',
                                res.data["user"]!["phone"].toString(),
                              );
                              await pref.setString(
                                "reports",
                                res.data['user']['report'].join('@-@'),
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (builder) => DashboardScreen(),
                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Wrong ID or password"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                          setState(() {
                            loading = false;
                          });
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
