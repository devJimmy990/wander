class User {
  final String? id; 
  final String name;
  final String email;
  final String phone;
  final String? password; 

  User({
    this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.password,
  });

  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(                 //password is not stored in Firestore for security reasons
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'email': email,
        'phone': phone,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"]?.toString(),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      password: json["password"] ?? "", 
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "phone": phone,
        "password": password, 
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

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}