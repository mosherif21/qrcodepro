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

@HiveType(typeId: 5)
class GenericQRCodeData extends QRCodeData {
  final String value;

  GenericQRCodeData({
    required this.value,
  });

  @HiveField(0)
  @override
  final String type = 'generic';
}

@HiveType(typeId: 6)
class WebsiteData extends QRCodeData {
  final String url;

  WebsiteData({
    required this.url,
  });

  @override
  @HiveField(0)
  String get type => 'website';
}

@HiveType(typeId: 7)
class MobileNumberData extends QRCodeData {
  final String number;

  MobileNumberData({
    required this.number,
  });

  @override
  @HiveField(0)
  String get type => 'mobileNumber';
}

// Adapters

class WebsiteDataAdapter extends TypeAdapter<WebsiteData> {
  @override
  int get typeId => 6;

  @override
  WebsiteData read(BinaryReader reader) {
    final url = reader.readString();

    return WebsiteData(
      url: url,
    );
  }

  @override
  void write(BinaryWriter writer, WebsiteData obj) {
    writer.writeString(obj.url);
  }
}

class MobileNumberDataAdapter extends TypeAdapter<MobileNumberData> {
  @override
  int get typeId => 7;

  @override
  MobileNumberData read(BinaryReader reader) {
    final number = reader.readString();

    return MobileNumberData(
      number: number,
    );
  }

  @override
  void write(BinaryWriter writer, MobileNumberData obj) {
    writer.writeString(obj.number);
  }
}

class GenericQRCodeDataAdapter extends TypeAdapter<GenericQRCodeData> {
  @override
  int get typeId => 5;

  @override
  GenericQRCodeData read(BinaryReader reader) {
    final value = reader.readString();

    return GenericQRCodeData(
      value: value,
    );
  }

  @override
  void write(BinaryWriter writer, GenericQRCodeData obj) {
    writer.writeString(obj.value);
  }
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
