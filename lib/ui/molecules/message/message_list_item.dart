import 'package:chat_flutter/config/app_radius.dart';
import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/model/message.dart';
import 'package:chat_flutter/services/firebase_user_service.dart';
import 'package:chat_flutter/ui/atoms/circular_image.dart';
import 'package:chat_flutter/util/common_func_util.dart';
import 'package:flutter/material.dart';

import 'package:chat_flutter/config/app_text_size.dart';

class MessageListItem extends StatelessWidget {
  const MessageListItem(this.message);
  final Message message;
  @override
  Widget build(BuildContext context) {
    final FirebaseUserService firebaseUserService = FirebaseUserService();
    return Padding(
      padding: const EdgeInsets.all(AppSpace.xsmall),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (message.isMe)
            Column(
              children: <Widget>[
                Text(
                  (message.isRead) ? '既読' : '',
                  style: const TextStyle(
                    fontSize: AppTextSize.xsmall,
                  ),
                ),
                Text(
                  CommonFuncUtil.dateTimeToString(message.sendTime),
                  style: const TextStyle(
                    fontSize: AppTextSize.xsmall,
                  ),
                ),
              ],
            ),
          if (!message.isMe)
            FutureBuilder<String>(
              future: firebaseUserService.getUserImgUrl(message.senderId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularImage(
                    size: 40,
                  );
                }
                return CircularImage(
                  size: 40,
                  imgUrl: snapshot.data,
                );
              },
            ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpace.xsmall,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.small),
              color: message.isMe ? Colors.blue : const Color(0xffEEEEEE),
            ),
            padding: const EdgeInsets.all(AppSpace.small),
            child: Text(
              message.text,
              softWrap: true,
              style: TextStyle(
                fontSize: AppTextSize.midium,
                color: message.isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
          if (!message.isMe)
            Text(
              CommonFuncUtil.dateTimeToString(message.sendTime),
              style: const TextStyle(
                fontSize: AppTextSize.xsmall,
              ),
            ),
        ],
      ),
    );
  }
}
