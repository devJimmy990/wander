class User {
  late final String? firstName, secondName, email, phone, password;
  User();
  User.create(
      {required this.firstName,
      required this.secondName,
      required this.email,
      required this.phone,
      required this.password});

  User.login({required this.email, required this.password});

  void login({required String email, required String password}) {
    this.email = email;
    this.password = password;
  }

  void create(
      {required String email,
      required String password,
      required String firstName,
      required String secondName,
      required String phone}) {
    this.email = email;
    this.password = password;
    this.firstName = firstName;
    this.secondName = secondName;
    this.phone = phone;
  }
}
