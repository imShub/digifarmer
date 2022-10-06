import 'package:demo_hackit/api/google_sign_in.dart';
import 'package:demo_hackit/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/chat/v1.dart';

class AccountPage extends StatefulWidget {
  final GoogleSignInAccount? user;

  const AccountPage({super.key, this.user});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var userName = widget.user?.displayName;
    var userPicUrl = widget.user?.photoUrl;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    userPicUrl.toString(),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Name: ' + userName!,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ' + widget.user!.email.toString(),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await GoogleSignInApi.logout();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text("LOG OUT"),
            )
          ],
        ),
      ),
    );
  }
}
