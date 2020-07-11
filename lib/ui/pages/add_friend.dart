import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/ui/molecules/add_friend_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/model/user.dart';

class AddFriendPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.symmetric(
            vertical: AppSpace.xsmall,
          ),
          child: TextField(
            controller: _textEditingController,
            //autofocus: true,
            decoration: InputDecoration(
              hintText: "IDを入力",
            ),
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: Color(0xff707070),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //searchの処理
              print(_textEditingController.text);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getUserList(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<User>> snapshot,
        ) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return AddFriendListTile(
                    name: snapshot.data[index].name,
                    imgUrl: snapshot.data[index].imgUrl,
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  "友達が見つかりません",
                ),
              );
            }
          } else if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<List<User>> _getUserList() async {
    final List<User> userList = [
      User(
        name: "Alex",
        imgUrl:
            "https://pbs.twimg.com/profile_images/581025665727655936/9CnwZZ6j.jpg",
        isMe: false,
      ),
      User(
        name: "Alex2(笑)",
        imgUrl:
            "https://pbs.twimg.com/profile_images/581025665727655936/9CnwZZ6j.jpg",
        isMe: false,
      ),
      User(
        name: "Jack",
        imgUrl:
            "https://pbs.twimg.com/profile_images/581025665727655936/9CnwZZ6j.jpg",
        isMe: false,
      ),
      User(
        name: "Brian",
        imgUrl:
            "https://pbs.twimg.com/profile_images/581025665727655936/9CnwZZ6j.jpg",
        isMe: false,
      ),
    ];
    await Future.delayed(Duration(seconds: 5));
    return await Future.value(userList);
  }
}
