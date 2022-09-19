class User {
  final String userID;
  final String name;
  final String profilePic;
  final String email;

  User( {required this.name, required this.email,required this.userID, this.profilePic='',});

  factory User.fromJson(Map<String ,dynamic> jsonObject){
    return User(
        userID: jsonObject["uid"],
        name: jsonObject["name"],
        email: jsonObject["email"],
        profilePic: jsonObject["profile_pic"]
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uid":userID,
      "name":name,
      "profile_pic":profilePic,
      "email":email
    };
  }

  @override
  String toString() => 'User { name: $name, email: $email}';
}