
class UserData {
  final String? email;
  final String? forename;
  final String? surname;

  UserData({this.email, this.forename, this.surname});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] as String?,
      forename: json['forename'] as String?,
      surname: json['surname'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'forename': forename,
      'surname': surname,
    };
  }

}
