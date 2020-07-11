import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/config/app_text_size.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/model/room.dart';

class TalkPageListTile extends StatelessWidget {
  final Room room;
  TalkPageListTile(this.room);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/roomPage',arguments: room.name,
        );
      },
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.all(AppSpace.small),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  radius: double.infinity,
                  backgroundImage: NetworkImage(room.imgUrl),
                ),
              ),
              SizedBox(
                width: AppSpace.midium,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width - 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            room.name,
                            style: TextStyle(
                              fontSize: AppTextSize.midium,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          room.sendTime,
                          style: TextStyle(
                            fontSize: AppTextSize.xsmall,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        room.lastMessage,
                        style: TextStyle(
                          fontSize: AppTextSize.small,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
