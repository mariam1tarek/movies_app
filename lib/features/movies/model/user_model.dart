class UserModel {
  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
    this.phone = '',
  });

  final String uid;
  final String name;
  final String email;
  final String phone;
  final String avatar;

  UserModel copyWith({String? uid}) => UserModel(
        uid: uid ?? this.uid,
        name: name,
        email: email,
        phone: phone,
        avatar: avatar,
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar': avatar,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map['uid'] as String? ?? '',
        name: map['name'] as String? ?? '',
        email: map['email'] as String? ?? '',
        phone: map['phone'] as String? ?? '',
        avatar: map['avatar'] as String? ?? '',
      );
}
