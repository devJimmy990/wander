class User {
  final String? id, password, avatar, name, email, phone;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.avatar = "assets/images/avatar/default.jpg",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"]?.toString(),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
      };

  Map<String, dynamic> toCachedJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
      };

  @override
  String toString() =>
      "User(id: $id, name: $name, email: $email, phone: $phone)";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ phone.hashCode;
}
