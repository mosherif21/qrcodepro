import 'package:hive_flutter/adapters.dart';
import 'package:qrcodepro/src/constants/enums.dart';

abstract class QRCodeData {
  String get type;
}

@HiveType(typeId: 0)
class WifiData extends QRCodeData {
  String ssid;
  String password;
  WifiSecurityType securityType;

  WifiData({
    required this.ssid,
    required this.password,
    required this.securityType,
  });

  @override
  @HiveField(0)
  String get type => 'wifi';
}

@HiveType(typeId: 1)
class ContactData extends QRCodeData {
  String name;
  String phoneNumber;
  String email;

  ContactData({
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  @override
  @HiveField(0)
  String get type => 'contact';
}

@HiveType(typeId: 2)
class SMSData extends QRCodeData {
  String phoneNumber;
  String msgBody;

  SMSData({
    required this.phoneNumber,
    required this.msgBody,
  });

  @override
  @HiveField(0)
  String get type => 'sms';
}

@HiveType(typeId: 3)
class EmailData extends QRCodeData {
  String email;
  String subject;
  String content;

  EmailData({
    required this.email,
    required this.subject,
    required this.content,
  });

  @override
  @HiveField(0)
  String get type => 'email';
}

@HiveType(typeId: 4)
class MyContactCardData extends QRCodeData {
  String name;
  String phoneNumber;
  String email;
  String address;
  String birthDate;
  String organization;

  MyContactCardData({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.birthDate,
    required this.organization,
  });

  @override
  @HiveField(0)
  String get type => 'myContactCard';
}

class WifiDataAdapter extends TypeAdapter<WifiData> {
  @override
  int get typeId => 0;
  @override
  WifiData read(BinaryReader reader) {
    final ssid = reader.readString();
    final password = reader.readString();
    final securityType = WifiSecurityType.values.byName(reader.readString());
    return WifiData(
      ssid: ssid,
      password: password,
      securityType: securityType,
    );
  }

  @override
  void write(BinaryWriter writer, WifiData obj) {
    writer.writeString(obj.ssid);
    writer.writeString(obj.password);
    writer.writeString(obj.securityType.name);
  }
}

class ContactDataAdapter extends TypeAdapter<ContactData> {
  @override
  int get typeId => 1;
  @override
  ContactData read(BinaryReader reader) {
    final name = reader.readString();
    final phoneNumber = reader.readString();
    final email = reader.readString();
    return ContactData(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
    );
  }

  @override
  void write(BinaryWriter writer, ContactData obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.phoneNumber);
    writer.writeString(obj.email);
  }
}

class SMSDataAdapter extends TypeAdapter<SMSData> {
  @override
  int get typeId => 2;
  @override
  SMSData read(BinaryReader reader) {
    final phoneNumber = reader.readString();
    final msgBody = reader.readString();
    return SMSData(
      phoneNumber: phoneNumber,
      msgBody: msgBody,
    );
  }

  @override
  void write(BinaryWriter writer, SMSData obj) {
    writer.writeString(obj.phoneNumber);
    writer.writeString(obj.msgBody);
  }
}

class EmailDataAdapter extends TypeAdapter<EmailData> {
  @override
  int get typeId => 3;
  @override
  EmailData read(BinaryReader reader) {
    final email = reader.readString();
    final subject = reader.readString();
    final content = reader.readString();
    return EmailData(
      email: email,
      subject: subject,
      content: content,
    );
  }

  @override
  void write(BinaryWriter writer, EmailData obj) {
    writer.writeString(obj.email);
    writer.writeString(obj.subject);
    writer.writeString(obj.content);
  }
}

class MyContactCardDataAdapter extends TypeAdapter<MyContactCardData> {
  @override
  int get typeId => 4;
  @override
  MyContactCardData read(BinaryReader reader) {
    final name = reader.readString();
    final phoneNumber = reader.readString();
    final email = reader.readString();
    final address = reader.readString();
    final birthDate = reader.readString();
    final organization = reader.readString();
    return MyContactCardData(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      birthDate: birthDate,
      organization: organization,
    );
  }

  @override
  void write(BinaryWriter writer, MyContactCardData obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.phoneNumber);
    writer.writeString(obj.email);
    writer.writeString(obj.address);
    writer.writeString(obj.birthDate);
    writer.writeString(obj.organization);
  }
}



// class WifiFormat {
//   String ssid;
//   String password;
//   WifiSecurityType securityType;

//   WifiFormat({
//     required this.ssid,
//     required this.password,
//     required this.securityType,
//   });

//   Map<String, dynamic> toJson() => {
//         'ssid': ssid,
//         'password': password,
//         'securityType': securityType.toString(),
//       };

//   factory WifiFormat.fromMap(Map<String, dynamic> map) {
//     return WifiFormat(
//       ssid: map['ssid'] ?? '',
//       password: map['password'] ?? '',
//       securityType: map['securityType'] == 'wpa2'
//           ? WifiSecurityType.wpa2
//           : map['securityType'] == 'wpa'
//               ? WifiSecurityType.wpa
//               : map['securityType'] == 'wep'
//                   ? WifiSecurityType.wep
//                   : WifiSecurityType.none,
//     );
//   }
// }

// class ContactFormat {
//   String name;
//   String phoneNumber;
//   String email;

//   ContactFormat({
//     required this.name,
//     required this.phoneNumber,
//     required this.email,
//   });

//   Map<String, dynamic> toMap() => {
//         'name': name,
//         'phoneNumber': phoneNumber,
//         'email': email,
//       };
//   factory ContactFormat.fromMap(Map<String, dynamic> map) {
//     return ContactFormat(
//       name: map['name'] ?? '',
//       phoneNumber: map['phoneNumber'] ?? '',
//       email: map['email'] ?? '',
//     );
//   }
// }

// class SmsFormat {
//   String phoneNumber;
//   String msgBody;

//   SmsFormat({
//     required this.phoneNumber,
//     required this.msgBody,
//   });

//   Map<String, dynamic> toMap() => {
//         'phoneNumber': phoneNumber,
//         'msgBody': msgBody,
//       };
//   factory SmsFormat.fromMap(Map<String, dynamic> map) {
//     return SmsFormat(
//       phoneNumber: map['phoneNumber'] ?? '',
//       msgBody: map['msgBody'] ?? '',
//     );
//   }
// }

// class EmailFormat {
//   String email;
//   String subject;
//   String content;

//   EmailFormat({
//     required this.email,
//     required this.subject,
//     required this.content,
//   });

//   Map<String, dynamic> toMap() => {
//         'email': email,
//         'subject': subject,
//         'content': content,
//       };
//   factory EmailFormat.fromMap(Map<String, dynamic> map) {
//     return EmailFormat(
//       email: map['email'] ?? '',
//       subject: map['subject'] ?? '',
//       content: map['content'] ?? '',
//     );
//   }
// }

// class MyContactCard {
//   String name;
//   String phoneNumber;
//   String email;
//   String address;
//   String birthDate;
//   String organization;

//   MyContactCard({
//     required this.name,
//     required this.phoneNumber,
//     required this.email,
//     required this.address,
//     required this.birthDate,
//     required this.organization,
//   });

//   Map<String, dynamic> toMap() => {
//         'name': name,
//         'phoneNumber': phoneNumber,
//         'email': email,
//         'address': address,
//         'birthDate': birthDate,
//         'organization': organization,
//       };
//   factory MyContactCard.fromMap(Map<String, dynamic> map) {
//     return MyContactCard(
//       name: map['name'] ?? '',
//       phoneNumber: map['phoneNumber'] ?? '',
//       email: map['email'] ?? '',
//       address: map['address'] ?? '',
//       birthDate: map['birthDate'] ?? '',
//       organization: map['organization'] ?? '',
//     );
//   }
// }
