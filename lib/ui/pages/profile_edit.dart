import 'package:chat_flutter/providers/user.dart';
import 'package:chat_flutter/ui/atoms/profile_image.dart';
import 'package:chat_flutter/ui/molecules/profile/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: ProfilePageAppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder<User>(
        future: userProvider.getUserById("userId"),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: // データの取得まち
              return Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (snapshot.hasData) {
                return _ProfileEditPage(
                  user: snapshot.data,
                );
              } else {
                return Center(
                  child: Text("該当するユーザーがいません"),
                );
              }
          }
        },
      ),
    );
  }
}

class _ProfileEditPage extends StatelessWidget {
  final User user;

  const _ProfileEditPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ProfileImage(image: user.imgUrl),
          SizedBox(height: 15),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Center(
            child: Container(
              width: 150,
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
                label: Text("更新する"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.redAccent,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
