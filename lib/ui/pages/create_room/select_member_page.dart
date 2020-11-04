import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/ui/molecules/create_room/member_list.dart';
import 'package:chat_flutter/ui/molecules/create_room/searced_user_list.dart';
import 'package:chat_flutter/ui/pages/create_room/select_member_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectMemberPage extends StatelessWidget {
  const SelectMemberPage._({Key key}) : super(key: key);
  static Widget wrapped(Authenticator authenticator) {
    return ChangeNotifierProvider<SelectMemberController>(
      create: (_) => SelectMemberController(authenticator),
      child: const SelectMemberPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SelectMemberController>(context);
    final textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff707070),
        ),
        title: const Text(
          'メンバーを選択',
          style: TextStyle(color: Color(0xff707070)),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('次へ'),
            onPressed: () => Navigator.pushNamed(
              context,
              '/createGroupPage',
              arguments: controller.members,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter a name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    await controller
                        .getSearchedUserExceptMe(textController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: SearchedUserList(),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Add Members',
                style: TextStyle(
                  color: Color(0xff707070),
                ),
              ),
            ),
          ),
          MemberList(),
        ],
      ),
    );
  }
}
