import 'package:chat_flutter/ui/pages/main/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/ui/atoms/profile_image.dart';
import 'package:chat_flutter/ui/molecules/profile/app_bar.dart';

import 'package:chat_flutter/model/user.dart';

import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/config/app_text_size.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _profileProvider = Provider.of<ProfileController>(context);
    return Scaffold(
      appBar: ProfilePageAppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder<User>(
        future: _profileProvider.getUserById("userId"),
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
    final _profileController = Provider.of<ProfileController>(context,listen: false);
    final TextEditingController _nameController = TextEditingController(
      text: ModalRoute.of(context).settings.arguments,
    );
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: ProfileImage(image: user.imgUrl),
          ),
          SizedBox(
            height: AppSpace.small,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpace.midium,
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              controller: _nameController,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppTextSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
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
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
                label: Text("更新する"),
                onPressed: () {
                  _profileController.changeProfileInfo();
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