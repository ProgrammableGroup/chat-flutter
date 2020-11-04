import 'package:chat_flutter/ui/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfileImage extends StatelessWidget {
  const MyProfileImage({Key key, this.size}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    if (profileController.selectedImageFile != null) {
      return SizedBox(
        width: size,
        height: size,
        child: CircleAvatar(
          backgroundImage: FileImage(profileController.selectedImageFile),
        ),
      );
    } else if (profileController.user.imgUrl != '' &&
        profileController.user.imgUrl != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(profileController.user.imgUrl),
          ),
        ),
      );
    } else {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/avatar.JPG'),
          ),
        ),
      );
    }
  }
}
