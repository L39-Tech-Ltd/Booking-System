
class EmployeeData {
  final String? id;
  final String? email;
  final String? name;
  final String? role;

  EmployeeData({
    this.id,
    this.email,
    this.name,
    this.role,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json){
    return EmployeeData(
      id: json['employee_id'] is String ? json['employee_id'] : json['employee_id'].toString() ,
      email: json['email'] is String ? json['email'] : json['email'].toString() ,
      name: createName(json),
      role: json['role'] is String ? json['role'] : json['role'].toString() ,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'email': email,
      'name': name,
      'role': role
    };
  }

  static String? createName(Map<String, dynamic> json){

    String? forename = json['forename'] as String?;
    String? surname = json['surname'] as String?;

    String? fullName;
    if(forename != null && surname != null){
      fullName = '$forename $surname';
    }else if(forename != null){
      fullName = forename;
    }else if(surname != null){
      fullName = surname;
    }

    return fullName;
  }
}