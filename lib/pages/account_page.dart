import 'package:digi_farmer/api/google_sign_in.dart';
import 'package:digi_farmer/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountPage extends StatefulWidget {
  final User? user;

  const AccountPage({super.key, this.user});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 248, 212),
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
              // statusBarColor: Color.fromARGB(255, 146, 173, 118),
              ),
        ),
      ),

      body: getBody(),
    );
  }

  Widget getBody() {
    var userName = widget.user?.displayName;
    var userPicUrl = widget.user?.photoURL;
    return Center(
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
          const SizedBox(
            height: 30,
          ),
          Text(
            'Name: ${userName!}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Email: ${widget.user!.email}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              await GoogleSignInApi.logout();

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text("LOG OUT"),
          )
        ],
      ),
    );
  }
}
