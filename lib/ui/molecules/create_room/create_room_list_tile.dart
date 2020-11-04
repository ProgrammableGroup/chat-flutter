import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/model/user.dart';
import 'package:chat_flutter/ui/atoms/circular_image.dart';
import 'package:flutter/material.dart';

import 'package:chat_flutter/config/app_text_size.dart';

class CreateRoomListTile extends StatelessWidget {
  final User user;

  const CreateRoomListTile({
    this.user,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpace.small),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularImage(
            size: 50,
            imgUrl: user.imgUrl,
          ),
          const SizedBox(
            width: AppSpace.midium,
          ),
          Expanded(
            child: Text(
              user.name,
              style: const TextStyle(
                fontSize: AppTextSize.midium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
