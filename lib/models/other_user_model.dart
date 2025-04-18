class OtherUserModel {
  String? name;
  String? profileUrl;
  bool? suspended;
  String? chatRoom;

  OtherUserModel({
    this.name,
    this.profileUrl,
    this.suspended,
    this.chatRoom,
  });

  // Named constructor to create a OtherUserModel from JSON
  factory OtherUserModel.fromJson(Map<String, dynamic> json) {
    return OtherUserModel(
      name: json['name'],
      profileUrl: json['profile_url'],
      suspended: json['suspended'],
      chatRoom: json['chat_room'],
    );
  }

  // Method to convert a OtherUserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile_url': profileUrl,
      'suspended': suspended,
      'chat_room': chatRoom,
    };
  }
}
