import 'package:chat_flutter/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers {
  return <SingleChildWidget>[
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    ),
  ];
}
