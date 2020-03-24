import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:social_login_test/login.dart';

class KakaoLoginButton extends StatefulWidget {
  @override
  _KakaoLoginButtonState createState() => _KakaoLoginButtonState();
}

class _KakaoLoginButtonState extends State<KakaoLoginButton> {
  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao installed = $installed');
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  bool _isKakaoTalkInstalled = true;

  _checkAccessToken() async {
    var token = await AccessTokenStore.instance.fromStore();
    debugPrint(token.toString());
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _getUserId() async {
    User user = await UserApi.instance.me();
    return user.kakaoAccount.profile.toJson()['nickname'].toString();
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      var userId = await _getUserId();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login(userId)),
      );
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  logOutTalk() async {
    try {
      var code = await UserApi.instance.logout();
      print('logOutTalk code=${code.toString()}');
    } catch (e) {
      print('logOutTalk error=${e.toString()}');
    }
  }

  unlinkTalk() async {
    try {
      var code = await UserApi.instance.unlink();
      print('unlinkTalk code=${code.toString()}');
    } catch (e) {
      print('unlinkTalk error=${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return RaisedButton(
      onPressed: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
      color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/img/kakao_login.png',
            width: deviceSize.width * 0.1,
          ),
          SizedBox(
            width: deviceSize.width * 0.1,
          ),
          Text('KaKao Login'),
        ],
      ),
    );
  }
}
