class Room {
  //Room ID
  String id;
  String name;
  String imgUrl;
  List<String> members;
  String lastMessage;
  String sendTime;
  Room({
    this.id,
    this.name,
    this.imgUrl,
    this.members,
    this.lastMessage,
    this.sendTime,
  });

  factory Room.fromJson(Map<String, dynamic> json, String roomId) {
    return Room(
      id: roomId,
      name: json['name'].toString(),
      imgUrl: json['ImgUrl'].toString(),
      members: json['members'] as List<String>,
      lastMessage: json['lastMessage'].toString(),
      sendTime: json['sendTime'].toString(),
    );
  }
}
