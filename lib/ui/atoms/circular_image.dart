import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({Key key, @required this.size, this.imgUrl})
      : super(key: key);
  final double size;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    if (imgUrl != null && imgUrl.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imgUrl),
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
