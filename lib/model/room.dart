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
}
