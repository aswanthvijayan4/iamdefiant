class BugData {
  String id;
  String date_of_visit;
  String company_name;
  String person_name;
  String designation;
  String contact_number;
  String place;
  String bussiness_type;
  String status;
  String next_date_of_visit;
  String hardware_quotation_price;
  String email;

  BugData({this.id,this.place, this.bussiness_type, this.status,
  this.next_date_of_visit, this.hardware_quotation_price, this.email,
  this.date_of_visit,this.company_name,this.person_name,this.designation,this.contact_number,});

  factory BugData.fromJason(Map<String, dynamic> json) {
    return BugData(
      id: json['id'],
      date_of_visit:json['date_of_visit'],
      company_name: json['company_name'],
      person_name: json['person_name'],
      designation: json['designation'],
      contact_number: json['contact_number'],
      place: json['place'],
      bussiness_type :json['bussiness_type'],
      status:json['status'],
      hardware_quotation_price: json['hardware_quotation_price'],
      email: json['email'],
      next_date_of_visit: json['next_date_of_visit'],
    );
  }
  dynamic toJson() => {'id':id ,'date_of_visit':date_of_visit,'company_name': company_name, 'person_name': person_name, 'designation':designation,
  'contact_number':contact_number,'place':place,'bussiness_type':bussiness_type,'status':status,'hardware_quotation_price':hardware_quotation_price,
    'email':email,'next_date_of_visit':next_date_of_visit};
}