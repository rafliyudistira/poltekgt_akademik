import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:sisfo_pgt/color.dart';
import 'package:http/http.dart' as http;

class LoginMHS extends StatefulWidget {
  LoginMHS({Key? key}) : super(key: key);

  @override
  State<LoginMHS> createState() => _LoginMHSState();
}

class _LoginMHSState extends State<LoginMHS> {
  final _formKey = GlobalKey<FormState>();

  late String nimMhs, passMhs, statusMhs, namaMhs;
  TextEditingController _nim = TextEditingController();
  TextEditingController _pass = TextEditingController();

  bool _visible = true;

  void login(BuildContext context) async {
    // ip local
    var url = "http://192.168.43.34/back_sisfo/LoginAuth.php";
    var response = await http
        .post(Uri.parse(url), body: {"nim": _nim.text, "password": _pass.text});

    var data = json.decode(response.body);

    // kondisi buat login
    if (data.length < 1) {
      print('Kosong');
      Fluttertoast.showToast(
          msg: "Nim or password is wrong!",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER);
    } else {
      if (data[0]['status'] == 'Aktif') {
        setState(() {
          namaMhs = data[0]['nama'];
        });
        EasyLoading.show(status: 'Loading..');
        Future.delayed(Duration(seconds: 2), () => EasyLoading.dismiss());
        Future.delayed(Duration(seconds: 2),
            () => context.goNamed('home', queryParams: {"nama": namaMhs}));

        print('Bisa login');
      } else {
        print('gabisa login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
          ),
          const TopSginin(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.09),
                      child: Image.asset("assets/image/book.jpg"),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: TextFormField(
                        controller: _nim,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot empty!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          labelText: 'Nim',
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                      ),
                    ),
                    // InputField(headerText: "Username", hintTexti: "Username"),
                    const SizedBox(
                      height: 15,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: TextFormField(
                        controller: _pass,
                        obscureText: _visible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot empty!";
                          } else if (value.length < 6) {
                            return "Password at least more than 6";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(_visible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _visible = !_visible;
                                });
                              }),
                          labelText: 'Password',
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CheckerBox(),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: blue.withOpacity(0.7),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login(context);
                          print("Sign up click");

                          // context.goNamed('home');
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Center(
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: whiteshade),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class CheckerBox extends StatefulWidget {
  const CheckerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckerBox> createState() => _CheckerBoxState();
}

class _CheckerBoxState extends State<CheckerBox> {
  bool? isCheck;
  @override
  void initState() {
    // TODO: implement initState
    isCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              value: isCheck,
              checkColor: whiteshade, // color of tick Mark
              activeColor: blue,
              onChanged: (val) {
                setState(() {
                  isCheck = val!;
                  print(isCheck);
                });
              }),
          Text.rich(
            TextSpan(
              text: "Remember me",
              style: TextStyle(color: grayshade.withOpacity(0.8), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  String headerText;
  String hintTexti;
  InputField({Key? key, required this.headerText, required this.hintTexti})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Text(
            headerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: grayshade.withOpacity(0.5),
              // border: Border.all(
              //   width: 1,
              // ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintTexti,
                  border: InputBorder.none,
                ),
              ),
            )
            //IntrinsicHeight

            ),
      ],
    );
  }
}

class InputFieldPassword extends StatefulWidget {
  String headerText;
  String hintTexti;

  InputFieldPassword(
      {Key? key, required this.headerText, required this.hintTexti})
      : super(key: key);

  @override
  State<InputFieldPassword> createState() => _InputFieldPasswordState();
}

class _InputFieldPasswordState extends State<InputFieldPassword> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: TextFormField(
            obscureText: _visible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon:
                      Icon(_visible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _visible = !_visible;
                    });
                  }),
              labelText: 'Password',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //   child: TextField(
        //     obscureText: _visible,
        //     decoration: InputDecoration(
        //         hintText: widget.hintTexti,
        //         border: InputBorder.none,
        //         suffixIcon: IconButton(
        //             icon: Icon(
        //                 _visible ? Icons.visibility : Icons.visibility_off),
        //             onPressed: () {
        //               setState(() {
        //                 _visible = !_visible;
        //               });
        //             })),
        //   ),
        // ),
      ],
    );
  }
}

class TopSginin extends StatelessWidget {
  const TopSginin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/image/poltekgt.png',
            scale: 5,
          ),
          // const SizedBox(
          //   width: 15,
          // ),
          Text(
            "POLITEKNIK GAJAH TUNGGAL",
            style: TextStyle(color: whiteshade, fontSize: 18),
          ),
          Image.asset(
            'assets/image/poltekgt.png',
            scale: 5,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
