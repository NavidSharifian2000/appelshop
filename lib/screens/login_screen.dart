import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/authentication/auth_bloc.dart';
import 'package:shop_fluter/bloc/authentication/auth_event.dart';
import 'package:shop_fluter/bloc/authentication/auth_state.dart';
import 'package:shop_fluter/constant/Colors.dart';

class LoginScren extends StatelessWidget {
  LoginScren({super.key});
  final usernametextcontroller = TextEditingController(text: 'amirahmad');
  final passwordtextcontroller = TextEditingController(text: '12345678');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: OurColor.andicatorcolor,
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/icon_application.png",
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "اپل شاپ",
                    style: TextStyle(
                        fontFamily: 'sb', fontSize: 18, color: Colors.white),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernametextcontroller,
                    decoration: InputDecoration(
                      labelText: "نام کاربری",
                      labelStyle: TextStyle(
                          fontFamily: "sm", fontSize: 15, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordtextcontroller,
                    decoration: InputDecoration(
                      labelText: "رمز عبور",
                      labelStyle: TextStyle(
                          fontFamily: "sm", fontSize: 15, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    if (state is AuthStateInitainstate) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                              fontFamily: 'sb',
                              fontSize: 15,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            minimumSize: Size(200, 48),
                          ),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthloginRequest(usernametextcontroller.text,
                                    passwordtextcontroller.text));
                          },
                          child: Text("ورود"));
                    }
                    if (state is AuthStateLoadingstate) {
                      return CircularProgressIndicator();
                    }
                    if (state is AuthResponsestate) {
                      Text widget = Text('');
                      state.respons.fold((l) {
                        widget = Text(l);
                      }, (r) {
                        widget = Text(r);
                      });
                      return widget;
                    }

                    return Text("خطای نا مشخص");
                  }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
