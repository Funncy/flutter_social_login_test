import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/user.dart';

class Login extends StatefulWidget {
  final String username;
  const Login(this.username);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String id = 'null';
  @override
  void initState() {
    _getUserId();
    super.initState();
  }

  _getUserId() async {
    User user = await UserApi.instance.me();
    setState(() {
      id = user.kakaoAccount.profile.toJson()['nickname'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Container(
        child: Center(
          child: Text(id),
        ),
      ),
    );
  }
}
