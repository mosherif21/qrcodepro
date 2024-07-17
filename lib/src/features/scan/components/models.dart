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

  factory WifiFormat.fromMap(Map<String, dynamic> map) {
    return WifiFormat(
      ssid: map['ssid'] ?? '',
      password: map['password'] ?? '',
      securityType: map['securityType'] == 'wpa2'
          ? WifiSecurityType.wpa2
          : map['securityType'] == 'wpa'
              ? WifiSecurityType.wpa
              : map['securityType'] == 'wep'
                  ? WifiSecurityType.wep
                  : WifiSecurityType.none,
    );
  }
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

  Map<String, dynamic> toMap() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
      };
  factory ContactFormat.fromMap(Map<String, dynamic> map) {
    return ContactFormat(
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
    );
  }
}

class SmsFormat {
  String phoneNumber;
  String msgBody;

  SmsFormat({
    required this.phoneNumber,
    required this.msgBody,
  });

  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'msgBody': msgBody,
      };
  factory SmsFormat.fromMap(Map<String, dynamic> map) {
    return SmsFormat(
      phoneNumber: map['phoneNumber'] ?? '',
      msgBody: map['msgBody'] ?? '',
    );
  }
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

  Map<String, dynamic> toMap() => {
        'email': email,
        'subject': subject,
        'content': content,
      };
  factory EmailFormat.fromMap(Map<String, dynamic> map) {
    return EmailFormat(
      email: map['email'] ?? '',
      subject: map['subject'] ?? '',
      content: map['content'] ?? '',
    );
  }
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

  Map<String, dynamic> toMap() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'birthDate': birthDate,
        'organization': organization,
      };
  factory MyContactCard.fromMap(Map<String, dynamic> map) {
    return MyContactCard(
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      birthDate: map['birthDate'] ?? '',
      organization: map['organization'] ?? '',
    );
  }
}
