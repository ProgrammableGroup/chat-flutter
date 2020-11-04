import 'package:chat_flutter/model/user.dart';
import 'package:chat_flutter/ui/atoms/my_profile_image.dart';
import 'package:chat_flutter/ui/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/config/app_text_size.dart';

class ProfileEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileController>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xff707070),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff707070),
        ),
      ),
      backgroundColor: Colors.white,
      body: (user == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _ProfileEditPage(
              user: user,
            ),
    );
  }
}

class _ProfileEditPage extends StatelessWidget {
  final User user;

  const _ProfileEditPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    final TextEditingController nameController = TextEditingController(
      text: user.name,
    );
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              final imagePicker = ImagePicker();
              final selectImage = await imagePicker.getImage(
                source: ImageSource.gallery,
              );
              if (selectImage != null) {
                Provider.of<ProfileController>(
                  context,
                  listen: false,
                ).notifySelectImage(
                  selectImage.path,
                );
              }
            },
            child: const MyProfileImage(
              size: 150,
            ),
          ),
          const SizedBox(
            height: AppSpace.small,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.midium,
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              controller: nameController,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppTextSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: AppSpace.large,
          ),
          Center(
            child: SizedBox(
              width: 150,
              child: RaisedButton.icon(
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
                label: const Text('更新する'),
                onPressed: () async {
                  await profileController
                      .changeProfileInfo(nameController.text);
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
