import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class facebook extends StatefulWidget {
  const facebook({super.key});

  @override
  State<facebook> createState() => _facebookState();
}

class _facebookState extends State<facebook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.facebook),
          onPressed: () {
            print('Access Token: ');
            facebookLogin();
          },
        ),
      ),
    );
  }
}

Future<void> facebookLogin() async {
  try {
    // Trigger the Facebook Login flow
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // Get the access token
      final AccessToken accessToken = result.accessToken!;
      print('Access Token: ${accessToken.token}');

      // Optionally, fetch user data
      final userData = await FacebookAuth.instance.getUserData();
      print('User Data::: $userData');

      showToast(userData['name']);
    } else {
      print('Facebook Login Failed: ${result.message}');
    }
  } catch (e) {
    print('Error during Facebook Login: $e');
  }
}

Future<bool?> showToast(String msg) {
  return Fluttertoast.showToast(
    backgroundColor: Colors.blueAccent,
    msg: msg,
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
