const String TableName_Employee_Details = "Employee_Details";

const String column_Employee_Details_id = "_id";
const String column_Employee_Details_TimeStamp = "TimeStamp";
const String column_Employee_Details_Name = "Name";
const String column_Employee_Details_Fathers_Name = "Fathers_Name";
const String column_Employee_Details_Date_of_Birth = "Date_of_Birth";
const String column_Employee_Details_Gender = "Gender";
const String column_Employee_Details_Nationality = "Nationality";
const String column_Employee_Details_Marital_Status = "Marital_Status";
const String column_Employee_Details_Email = "Email";
const String column_Employee_Details_Phone = "Phone";
const String column_Employee_Details_Address = "Address";
const String column_Employee_Details_Username = "UserName";
const String column_Employee_Details_Password = "Password";
const String column_Employee_Details_Employee_ID = "Employee_ID";
const String column_Employee_Details_Designation = "Designation";
const String column_Employee_Details_Department = "Department";
const String column_Employee_Details_Date_of_Joining = "Date_of_Joining";
const String column_Employee_Details_Passport_No = "Passport_No";
const String column_Employee_Details_Passport_Expiry = "Passport_Expiry";
const String column_Employee_Details_Visa_No = "Visa_No";
const String column_Employee_Details_Visa_Expiry = "Visa_Expiry";
const String column_Employee_Details_Bank_Account_No = "Bank_Account_No";
const String column_Employee_Details_Bank_Name = "Bank_Name";
const String column_Employee_Details_Bank_Branch = "Bank_Branch";
const String column_Employee_Details_Bank_Code = "Bank_Code";
const String column_Employee_Details_Highest_Qualification =
    "Highest_Qualification";
const String column_Employee_Details_Date_of_Qualification =
    "Date_of_Qualification";
const String column_Employee_Details_Emergency_Contact_Name =
    "Emergency_Contact_Name";
const String column_Employee_Details_Emergency_Contact_No =
    "Emergency_Contact_No";
const String column_Employee_Details_Emergency_Contact_Relation =
    "Emergency_Contact_Relation";
const String column_Employee_Details_User_Group = "UserGroupID";
const String column_Employee_Details_Show_Emp = "Show_Employee";

class EmployeeProfileDataModel {
  int id;
  String name;
  String fathersname;
  var timestamp;
  var dateOfBirth;
  String gender;
  String nationality;
  String maritalStatus;
  String email;
  String phone;
  String address;
  String username;
  String password;
  int userGroup;
  String employeeID;
  String designation;
  String department;
  DateTime dateOfJoining;
  String passportNo;
  DateTime passportExpiry;
  String visaNo;
  DateTime visaExpiry;
  String bankAccountNo;
  String bankName;
  String bankBranch;
  String bankCode;
  String highestQualification;
  DateTime dateOfQualification;
  String emergencyContactName;
  String emergencyContactNo;
  String emergencyContactRelation;
  bool showEmployee;

  bool fromExternal = false;
  int action;

  EmployeeProfileDataModel.fromMap(Map map) {
    id = map[column_Employee_Details_id];
    name = map[column_Employee_Details_Name];
    fathersname = map[column_Employee_Details_Fathers_Name];
    timestamp = map[column_Employee_Details_TimeStamp];
    dateOfBirth = map[column_Employee_Details_Date_of_Birth];
    gender = map[column_Employee_Details_Gender];
    nationality = map[column_Employee_Details_Nationality];
    maritalStatus = map[column_Employee_Details_Marital_Status];
    email = map[column_Employee_Details_Email];
    phone = map[column_Employee_Details_Phone];
    address = map[column_Employee_Details_Address];
    username = map[column_Employee_Details_Username];
    password = map[column_Employee_Details_Password];
    employeeID = map[column_Employee_Details_Employee_ID];
    designation = map[column_Employee_Details_Designation];
    department = map[column_Employee_Details_Department];
    dateOfJoining = map[column_Employee_Details_Date_of_Joining];
    passportNo = map[column_Employee_Details_Passport_No];
    passportExpiry = map[column_Employee_Details_Passport_Expiry];
    visaNo = map[column_Employee_Details_Visa_No];
    visaExpiry = map[column_Employee_Details_Visa_Expiry];
    bankAccountNo = map[column_Employee_Details_Bank_Account_No];
    bankName = map[column_Employee_Details_Bank_Name];
    bankBranch = map[column_Employee_Details_Bank_Branch];
    bankCode = map[column_Employee_Details_Bank_Code];
    highestQualification = map[column_Employee_Details_Highest_Qualification];
    dateOfQualification = map[column_Employee_Details_Date_of_Qualification];
    emergencyContactName = map[column_Employee_Details_Emergency_Contact_Name];
    emergencyContactNo = map[column_Employee_Details_Emergency_Contact_No];
    emergencyContactRelation =
        map[column_Employee_Details_Emergency_Contact_Relation];
    userGroup = map[column_Employee_Details_User_Group];
    showEmployee = map[column_Employee_Details_Show_Emp];
  }

  Map<String, dynamic> toMapForMasterInsert() {
    Map<String, dynamic> map = {
      column_Employee_Details_id: id,
      column_Employee_Details_Name: name,
      column_Employee_Details_Fathers_Name: fathersname,
      column_Employee_Details_TimeStamp: timestamp,
      column_Employee_Details_Date_of_Birth: dateOfBirth,
      column_Employee_Details_Gender: gender,
      column_Employee_Details_Nationality: nationality,
      column_Employee_Details_Marital_Status: maritalStatus,
      column_Employee_Details_Email: email,
      column_Employee_Details_Phone: phone,
      column_Employee_Details_Address: address,
      column_Employee_Details_Username: username,
      column_Employee_Details_Password: password,
      column_Employee_Details_Employee_ID: employeeID,
      column_Employee_Details_Designation: designation,
      column_Employee_Details_Department: department,
      column_Employee_Details_Date_of_Joining: dateOfJoining,
      column_Employee_Details_Passport_No: passportNo,
      column_Employee_Details_Passport_Expiry: passportExpiry,
      column_Employee_Details_Visa_No: visaNo,
      column_Employee_Details_Visa_Expiry: visaExpiry,
      column_Employee_Details_Bank_Account_No: bankAccountNo,
      column_Employee_Details_Bank_Name: bankName,
      column_Employee_Details_Bank_Branch: bankBranch,
      column_Employee_Details_Bank_Code: bankCode,
      column_Employee_Details_Highest_Qualification: highestQualification,
      column_Employee_Details_Date_of_Qualification: dateOfQualification,
      column_Employee_Details_Emergency_Contact_Name: emergencyContactName,
      column_Employee_Details_Emergency_Contact_No: emergencyContactNo,
      column_Employee_Details_Emergency_Contact_Relation:
          emergencyContactRelation,
      column_Employee_Details_User_Group: userGroup,
      column_Employee_Details_Show_Emp: showEmployee
    };
    return map;
  }
}
