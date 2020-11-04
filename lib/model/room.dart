class Room {
  //Room ID
  String id;
  String name;
  String imgUrl;
  List<String> members;
  Map<String, dynamic> lastMessage;
  Room({
    this.id,
    this.name,
    this.imgUrl,
    this.members,
    this.lastMessage,
  });

  factory Room.fromJson(Map<String, dynamic> json, String roomId) {
    return Room(
      id: roomId,
      name: json['name'].toString(),
      imgUrl: json['imgUrl'].toString(),
      members: json['members'].cast<String>() as List<String>,
      lastMessage: json['lastMessage'] as Map<String, dynamic>,
    );
  }
}
