class BookingData {
  final String? title;
  final String? startDate;
  final String? endDate;
  final String? location;
  final String? notes;
  final String? status;
  final String? employee;

  BookingData({
    this.title, 
    this.startDate,
    this.endDate, 
    this.location, 
    this.notes, 
    this.status, 
    this.employee});

  factory BookingData.fromJson(Map<String, dynamic> json){
    return BookingData(
      title: json['title'] is String ? json['title'] : json['title'].toString() ,
      startDate: json['start_data'] is String ? json['start_data'] : json['start_data'].toString(),
      endDate: json['end_data']is String ? json['end_data'] : json['end_data'].toString(),
      location: json['location'] is String ? json['location'] : json['location'].toString(),
      notes: json['notes'] is String ? json['notes'] : json['notes'].toString(),
      status: json['status'] is String ? json['status'] : json['status'].toString(),
      employee: createName(json),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'notes': notes,
      'status': status,
      'employee': employee
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