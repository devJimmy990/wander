class Address {
  final String street, city, suite, zip;

  Address(
      {required this.street,
      required this.city,
      required this.suite,
      required this.zip});

  Map<String, dynamic> toJson() {
    return {"street": street, "city": city, "suite": suite, "zipcode": zip};
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json["street"] ?? "",
      city: json["city"] ?? "",
      suite: json["suite"] ?? "",
      zip: json["zipcode"] ?? "",
    );
  }

  @override
  String toString() {
    return '{street: $street, city: $city, suite: $suite, zip: $zip}';
  }
}