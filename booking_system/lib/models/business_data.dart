
class BusinessData {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? location;

  BusinessData({this.id, this.name, this.email, this.phone, this.location});

  factory BusinessData.fromJson(Map<String, dynamic> json){
    return BusinessData(
      id: json['business_id']  is String ? json['business_id'] : json['business_id'].toString(),
      name: json['name']  is String ? json['name'] : json['name'].toString(),
      email: json['email']  is String ? json['email'] : json['email'].toString(),
      phone: json['phone'] is String ? json['phone'] : json['phone'].toString(),
      location: json['location']  is String ? json['location'] : json['location'].toString(),
    );
  }

    Map<String, dynamic> toJson(){
      return{
        'id' : id,
        'name': name,
        'email': email,
        'phone': phone,
        'location': location
      };
    }
  
  String? getName(){
    return name;
  }

}