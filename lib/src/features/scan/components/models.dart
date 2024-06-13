import '../../../constants/enums.dart';

class WifiFormat {
  String ssid;
  String password;
  WifiSecurityType securityType;

  WifiFormat({
    required this.ssid,
    required this.password,
    required this.securityType,
  });

  Map<String, dynamic> toJson() => {
        'ssid': ssid,
        'password': password,
        'securityType': securityType.toString(),
      };
}

class ContactFormat {
  String name;
  String phoneNumber;
  String email;

  ContactFormat({
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
      };
}

class SmsFormat {
  String phoneNumber;
  String msgBody;

  SmsFormat({
    required this.phoneNumber,
    required this.msgBody,
  });

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'msgBody': msgBody,
      };
}

class EmailFormat {
  String email;
  String subject;
  String content;

  EmailFormat({
    required this.email,
    required this.subject,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'subject': subject,
        'content': content,
      };
}

class MyContactCard {
  String name;
  String phoneNumber;
  String email;
  String address;
  String birthDate;
  String organization;

  MyContactCard({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.birthDate,
    required this.organization,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'birthDate': birthDate,
        'organization': organization,
      };
}
