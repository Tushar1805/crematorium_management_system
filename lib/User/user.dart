class User {
  String name, role, address, mobile;
  DateTime createdTime;

  User({this.name, this.createdTime, this.role, this.address, this.mobile});

  Map<String, dynamic> toJson() => {
        'name': name,
        'createdTime': createdTime,
        'role': role,
        'address': address
      };

  static User fromJson(Map<String, dynamic> json) => User(
        // createdTime: Utils.toDateTime(json['createdTime']),
        name: json['name'],
        role: json['role'],
        address: json['address'],
      );
}
