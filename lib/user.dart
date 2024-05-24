// "id": 1,
// "name": "이정도",
// "username": "jd1386",
// "email": "lee.jungdo@gmail.com",
// "phone": "010-3192-2910",
// "website": "https://leejungdo.com",
// "province": "경기도",
// "city": "성남시",
// "district": "분당구",
// "street": "대왕판교로 160",
// "zipcode": "13525",
// "createdAt": "2019-02-24T16:17:47.000Z",
// "updatedAt": "2019-02-24T16:17:47.000Z"

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String province;
  final String city;
  final String district;
  final String street;
  final String zipcode;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.province,
    required this.city,
    required this.district,
    required this.street,
    required this.zipcode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      province: json['province'],
      city: json['city'],
      district: json['district'],
      street: json['street'],
      zipcode: json['zipcode'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'province': province,
      'city': city,
      'district': district,
      'street': street,
      'zipcode': zipcode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, email: $email, phone: $phone, website: $website, province: $province, city: $city, district: $district, street: $street, zipcode: $zipcode, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
