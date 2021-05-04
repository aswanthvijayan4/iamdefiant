import 'dart:convert';

class SalesData {
  String id;
  String slno;
  String companyName;
  String dateofvisit;
  String status;
  String nextcall;
  String nextdateofvisit;
  String followup;
  String probability;
  String coutomerReq;
  String expetedPlan;
  String hardwarequotationprice;
  SalesData({
    this.id,
    this.slno,
    this.companyName,
    this.dateofvisit,
    this.status,
    this.nextcall,
    this.nextdateofvisit,
    this.followup,
    this.probability,
    this.coutomerReq,
    this.expetedPlan,
    this.hardwarequotationprice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slno': slno,
      'companyName': companyName,
      'dateofvisit': dateofvisit,
      'status': status,
      'nextcall': nextcall,
      'nextdateofvisit': nextdateofvisit,
      'followup': followup,
      'probability': probability,
      'customerReq': coutomerReq,
      'expectedPlan': expetedPlan,
      'hardwarequotationprice': hardwarequotationprice,
    };
  }

  factory SalesData.fromMap(Map<String, dynamic> map) {
    return SalesData(
      id: map['id'],
      slno: map['slno'],
      companyName: map['companyName'],
      dateofvisit: map['dateofvisit'],
      status: map['status'],
      nextcall: map['nextcall'],
      nextdateofvisit: map['nextdateofvisit'],
      followup: map['followup'],
      probability: map['probability'],
      coutomerReq: map['customerReq'],
      expetedPlan: map['expectedPlan'],
      hardwarequotationprice: map['hardwarequotationprice'],
    );
  }

  factory SalesData.fromJason(Map<String, dynamic> map) {
    return SalesData(
      id: map['id'],
      slno: map['slno'],
      companyName: map['companyName'],
      dateofvisit: map['dateofvisit'],
      status: map['status'],
      nextcall: map['nextcall'],
      nextdateofvisit: map['nextdateofvisit'],
      followup: map['followup'],
      probability: map['probability'],
      coutomerReq: map['customerReq'],
      expetedPlan: map['expectedPlan'],
      hardwarequotationprice: map['hardwarequotationprice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesData.fromJson(String source) =>
      SalesData.fromMap(json.decode(source));
}

//   SalesData({
//     this.id,
//     this.place,
//     this.bussiness_type,
//     this.status,
//     this.next_date_of_visit,
//     this.hardware_quotation_price,
//     this.email,
//     this.date_of_visit,
//     this.company_name,
//     this.person_name,
//     this.designation,
//     this.contact_number,
//     this.slno,
//     this.probability,
//     this.nextcall,
//     this.followup,
//     this.coutomerReq,
//     this.expetedPlan,
//     this.quoted,
//     this.typeoftrade,
//     this.clientSize,
//     this.area,
//     this.localPlace,
//     this.software,
//     this.moreDetails,
//     this.comment,
//   });

//   factory SalesData.fromJason(Map<String, dynamic> json) {
//     return SalesData(
//       id: json['id'],
//       date_of_visit: json['date_of_visit'],
//       company_name: json['company_name'],
//       person_name: json['person_name'],
//       designation: json['designation'],
//       contact_number: json['contact_number'],
//       place: json['place'],
//       bussiness_type: json['bussiness_type'],
//       status: json['status'],
//       hardware_quotation_price: json['hardware_quotation_price'],
//       email: json['email'],
//       next_date_of_visit: json['next_date_of_visit'],
//       slno: json['slno'],
//       probability: json['probability'],
//       nextcall: json['nextcall'],
//       followup: json['followup'],
//       coutomerReq: json['coutomerReq'],
//       expetedPlan: json['expetedPlan'],
//       quoted: json['quoted'],
//       typeoftrade: json['typeoftrade'],
//       clientSize: json['clientSize'],
//       area: json['area'],
//       localPlace: json['localPlace'],
//       software: json['software'],
//       moreDetails: json['moreDetails'],
//       comment: json['comment'],
//     );
//   }
//   dynamic toJson() => {
//         'id': id,
//         'date_of_visit': date_of_visit,
//         'company_name': company_name,
//         'person_name': person_name,
//         'designation': designation,
//         'contact_number': contact_number,
//         'place': place,
//         'bussiness_type': bussiness_type,
//         'status': status,
//         'hardware_quotation_price': hardware_quotation_price,
//         'email': email,
//         'next_date_of_visit': next_date_of_visit,
//         'slno': slno,
//         'probability': probability,
//         'nextcall': nextcall,
//         'followup': followup,
//         'coutomerReq': coutomerReq,
//         'expetedPlan': expetedPlan,
//         'quoted': quoted,
//         'typeoftrade': typeoftrade,
//         'clientSize': clientSize,
//         'area': area,
//         'localPlace': localPlace,
//         'software': software,
//         'moreDetails': moreDetails,
//         'comment': comment,
//       };
// }
