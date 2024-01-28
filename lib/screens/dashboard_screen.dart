import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medivault/constants.dart';
import 'package:medivault/screens/profile_screen.dart';
import 'package:medivault/screens/reports_screen.dart';
import 'package:medivault/screens/symptoms_speech_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool loading = false;
  Map data = {};
  var options = {
    'key': 'rzp_test_rxjW8wYyh6x9A7',
    'amount': 10000,
    'name': 'Acme Corp.',
    'description': 'Prescription',
    'prefill': {
      'contact': '9772463283',
      'email': 'tanishqa89@gmail.com',
    }
  };
  Razorpay _razorpay = Razorpay();

  String name = "Tanishq";
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('AAAAAAAAAAA');
    print(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('AAAAAAAAAAA');
    print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('AAAAAAAAAAA');
    print(response);
  }

  getCases() async {
    setState(() {
      loading = true;
    });
    final pref = await SharedPreferences.getInstance();
    String pid = pref.getString('pid')!;
    print(pid);
    String url = "https://sapphire-fly-sari.cyclic.app/case/$pid";
    Response res = await Dio().get(
      url,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (res.statusCode! > 199 && res.statusCode! < 300) {
      print(res.data);
      data = res.data;
      setState(() {});
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getName();
    getCases();
  }

  @override
  void dispose() {
    print("YESSS");
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        print("YESSS");
        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        print("NOOOO");
      },
      child: loading
          ? Container(
              height: height,
              width: width,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            )
          : Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                backgroundColor: kPrimaryColor,
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                ),
                tooltip: "Speak your symptoms",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const SpeechScreen(),
                    ),
                  );
                },
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: height * 0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kPrimaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hello ${name.split(" ")[0]}!",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Text(
                                          "Let us make you feel better",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        gradient: const LinearGradient(
                                          begin: Alignment(-1.0, -1),
                                          end: Alignment(1.0, 1),
                                          colors: [
                                            Color(0x3cffffff),
                                            Color(0x1affffff),
                                          ],
                                        ),
                                      ),
                                      height: height * 0.05,
                                      width: height * 0.05,
                                      child: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                ProfileScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          gradient: const LinearGradient(
                                            begin: Alignment(-1.0, -1),
                                            end: Alignment(1.0, 1),
                                            colors: [
                                              Color(0x3cffffff),
                                              Color(0x1affffff),
                                            ],
                                          ),
                                        ),
                                        height: height * 0.05,
                                        width: height * 0.05,
                                        child: const Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.035,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    gradient: const LinearGradient(
                                      begin: Alignment(-1.0, -1),
                                      end: Alignment(1.0, 1),
                                      colors: [
                                        Color(0x3cffffff),
                                        Color(0x1affffff),
                                      ],
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Search Doctor, Health issues",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.035,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: height * 0.06,
                                          width: height * 0.06,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            gradient: const LinearGradient(
                                              begin: Alignment(-1.0, -1),
                                              end: Alignment(1.0, 1),
                                              colors: [
                                                Color(0x3cffffff),
                                                Color(0x1affffff),
                                              ],
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: height * 0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Text(
                                          "Consultation",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: height * 0.06,
                                          width: height * 0.06,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            gradient: const LinearGradient(
                                              begin: Alignment(-1.0, -1),
                                              end: Alignment(1.0, 1),
                                              colors: [
                                                Color(0x3cffffff),
                                                Color(0x1affffff),
                                              ],
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.local_pharmacy,
                                            size: height * 0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Text(
                                          "Pharmacy",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: getCases,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height * 0.06,
                                            width: height * 0.06,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              gradient: const LinearGradient(
                                                begin: Alignment(-1.0, -1),
                                                end: Alignment(1.0, 1),
                                                colors: [
                                                  Color(0x3cffffff),
                                                  Color(0x1affffff),
                                                ],
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.book,
                                              size: height * 0.05,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Appointment",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                ReportScreen(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height * 0.06,
                                            width: height * 0.06,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              gradient: const LinearGradient(
                                                begin: Alignment(-1.0, -1),
                                                end: Alignment(1.0, 1),
                                                colors: [
                                                  Color(0x3cffffff),
                                                  Color(0x1affffff),
                                                ],
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.create_new_folder_rounded,
                                              size: height * 0.05,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            "Reports",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Upcoming Schedule",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffFA5555),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kPrimaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 24,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 23,
                                        child: ClipOval(
                                          child: Image(
                                            image: NetworkImage(
                                              "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['data']['name'] ??
                                                "Dr. Varun Khachane",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            data['data']['specialization'] ??
                                                "Dermatologist Consultant",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: height * 0.04,
                                      width: height * 0.04,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        gradient: const LinearGradient(
                                          begin: Alignment(-1.0, -1),
                                          end: Alignment(1.0, 1),
                                          colors: [
                                            Color(0x3cffffff),
                                            Color(0x1affffff),
                                          ],
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.call,
                                        size: height * 0.03,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.015,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Thursday, 29 January",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 9,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.access_time_filled,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "10:00 am - 11:00 am",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 9,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    gradient: const LinearGradient(
                                      begin: Alignment(-1.0, -1),
                                      end: Alignment(1.0, 1),
                                      colors: [
                                        Color(0x3cffffff),
                                        Color(0x1affffff),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "Past Appointment",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 23,
                                      child: ClipOval(
                                        child: Image(
                                          image: NetworkImage(
                                            "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dr. Tejas Dumbre",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "Dermatologist Consultant",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      try {
                                        _razorpay.open(options);
                                      } catch (e) {
                                        print("BBBBBBB");
                                        print(e);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        color: kPrimaryColor,
                                      ),
                                      child: const Text(
                                        "Pay",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              const Text(
                                "Report",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Jock itch in under...  ",
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'View complete report',
                                      style: TextStyle(
                                        color: Color(0xff2D7F8A),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void getName() async {
    final pref = await SharedPreferences.getInstance();
    name = pref.getString("name") ?? "Tanishq";
    print(name);
    setState(() {});
  }
}
