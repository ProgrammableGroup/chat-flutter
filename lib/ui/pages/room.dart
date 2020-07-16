import 'package:chat_flutter/config/app_radius.dart';
import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/ui/molecules/message/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:chat_flutter/config/app_text_size.dart';

class RoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments.toString();
    final TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff707070),
        ),
        title: Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xff707070),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          MessageList(),
          SizedBox(
            height: AppSpace.xsmall,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: AppSpace.small,
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(AppRadius.midium),
                    ),
                    contentPadding: EdgeInsets.all(
                      AppSpace.small,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: AppTextSize.midium,
                  ),
                ),
              ),
              SizedBox(
                width: AppSpace.xsmall,
              ),
              IconButton(
                onPressed: () {
                  _controller.clear();
                },
                icon: Icon(
                  Icons.send,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSpace.xsmall,
          ),
        ],
      ),
    );
  }
}
