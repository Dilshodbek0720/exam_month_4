class UserModel {
  String firstname;
  String lastname;
  int age;
  String userId;
  String fcm;
  int userRole;
  String createdAt;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.userId,
    required this.fcm,
    required this.userRole,
    required this.createdAt,
  });

  UserModel copyWith({
    String? firstname,
    String? lastname,
    int? age,
    String? userId,
    String? fcm,
    int? userRole,
    String? createdAt,
  }) {
    return UserModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      age: age ?? this.age,
      userId: userId ?? this.userId,
      fcm: fcm ?? this.fcm,
      userRole: userRole ?? this.userRole,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      firstname: jsonData['firstname'] as String? ?? "",
      lastname: jsonData['lastname'] as String? ?? '',
      age: jsonData['age'] as int? ?? 0,
      userId: jsonData['userId'] as String? ?? '',
      fcm: jsonData['fcm'] as String? ?? '',
      userRole: jsonData['userRole'] as int? ?? 0,
      createdAt: jsonData['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
      'userId': userId,
      'fcm': fcm,
      'userRole': userRole,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return ''''
       firstname : $firstname,
       lastname : $lastname,
       age : $age,
       userId : $userId,
       fcm : $fcm,
       userRole : $userRole,
       createdAt : $createdAt, 
      ''';
  }
}