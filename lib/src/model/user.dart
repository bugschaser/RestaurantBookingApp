class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(String uid,Map<String ,dynamic> jsonObject){
    return User(
        name: jsonObject["name"],
        email: jsonObject["email"]
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name":name,
      "email":email
    };
  }

  @override
  String toString() => 'User { name: $name, email: $email}';
}