import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/providers/user.dart';
import 'package:chat_flutter/ui/atoms/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/model/user.dart';

import 'package:chat_flutter/config/app_text_size.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return FutureBuilder<User>(
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
              return _ProfilePage(
                user: snapshot.data,
              );
            } else {
              return Center(
                child: Text("該当するユーザーがいません"),
              );
            }
        }
      },
    );
  }
}

class _ProfilePage extends StatelessWidget {
  final User user;

  const _ProfilePage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ProfileImage(image: user.imgUrl),
          SizedBox(
            height: AppSpace.small,
          ),
          Text(
            user.name,
            style: TextStyle(
              fontSize: AppTextSize.xlarge,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: AppSpace.large,
          ),
          Center(
            child: Container(
              width: 150,
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: Text("編集する"),
                onPressed: () {
                  Navigator.pushNamed<void>(context, "/profileEditPage");
                },
                color: Colors.green,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
