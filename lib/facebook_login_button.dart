import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:social_login_test/login.dart';

class FacebookLoginButton extends StatefulWidget {
  @override
  _FacebookLoginButtonState createState() => _FacebookLoginButtonState();
}

class _FacebookLoginButtonState extends State<FacebookLoginButton> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<Null> _login() async {
    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('token = ${accessToken.toMap()}');
        final token = result.accessToken.token;
        final graphResponse = await Dio().get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');

        final data = jsonDecode(graphResponse.data);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login(data["name"])),
        );

        break;
      case FacebookLoginStatus.cancelledByUser:
        print('error cancelledByUser');
        break;
      case FacebookLoginStatus.error:
        print('error errorerror');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return RaisedButton(
      onPressed: _login,
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
    );
  }
}
