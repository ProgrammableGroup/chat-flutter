import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/ui/pages/create_room/select_member_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SelectMemberController>(context);
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.members.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 40,
            margin: const EdgeInsets.all(AppSpace.small),
            child: FlatButton(
              onPressed: () {
                controller.removeMember(controller.members[index]);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Colors.blue,
              child: Text(
                controller.members[index].name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
