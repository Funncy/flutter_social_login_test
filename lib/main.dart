import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/link.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:social_login_test/kakao_login_button.dart';

void main() {
  KakaoContext.clientId = '2234aebf8f5748f7d92cbe410ff2870d';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kakao login test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('kakao login test'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: deviceSize.width * 0.9,
                child: KakaoLoginButton(),
              ),
              SizedBox(
                width: deviceSize.width * 0.9,
                child: RaisedButton(
                  onPressed: () => {},
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/img/facebook_logo.png',
                        width: deviceSize.width * 0.1,
                      ),
                      SizedBox(
                        width: deviceSize.width * 0.1,
                      ),
                      Text('Facebook Login'),
                    ],
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
