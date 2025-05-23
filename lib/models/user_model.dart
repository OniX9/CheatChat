class UserModel {
  String? uid;
  String? name;
  String? profileUrl;
  String? token;
  bool? suspended;
  bool? searching;
  String? chatRoom;

  UserModel({
    this.uid,
    this.name,
    this.profileUrl,
    this.token,
    this.suspended,
    this.searching,
    this.chatRoom,
  });

  // Named constructor to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      profileUrl: json['profile_url'],
      token: json['token'],
      suspended: json['suspended'],
      searching: json['searching'],
      chatRoom: json['chat_room'],
    );
  }

  // Method to convert a UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'profile_url': profileUrl,
      'token': token,
      'suspended': suspended,
      'searching': searching,
      'chat_room': chatRoom,
    };
  }
}
