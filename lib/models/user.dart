class User {
  final String empCode;
  final String empName;

  const User({
    required this.empCode,
    required this.empName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      empCode: json["CD_EMP"] as String,
      empName: json["NM_USER"] as String,
    );
  }
}
