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
  String imagePath; // Added image path property

  WifiData({
    required this.ssid,
    required this.password,
    required this.securityType,
    required this.imagePath,
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
  String imagePath; // Added image path property

  ContactData({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.imagePath,
  });

  @override
  @HiveField(0)
  String get type => 'contact';
}

@HiveType(typeId: 2)
class SMSData extends QRCodeData {
  String phoneNumber;
  String msgBody;
  String imagePath; // Added image path property

  SMSData({
    required this.phoneNumber,
    required this.msgBody,
    required this.imagePath,
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
  String imagePath; // Added image path property

  EmailData({
    required this.email,
    required this.subject,
    required this.content,
    required this.imagePath,
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
  String imagePath; // Added image path property

  MyContactCardData({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.birthDate,
    required this.organization,
    required this.imagePath,
  });

  @override
  @HiveField(0)
  String get type => 'myContactCard';
}

@HiveType(typeId: 5)
class GenericQRCodeData extends QRCodeData {
  final String value;
  String imagePath; // Added image path property

  GenericQRCodeData({
    required this.value,
    required this.imagePath,
  });

  @HiveField(0)
  @override
  final String type = 'generic';
}

// Adapter for GenericQRCodeData (optional, can leverage StringAdapter for simplicity)

class GenericQRCodeDataAdapter extends TypeAdapter<GenericQRCodeData> {
  @override
  int get typeId => 5;

  @override
  GenericQRCodeData read(BinaryReader reader) {
    final value = reader.readString();
    final imagePath = reader.readString();
    return GenericQRCodeData(value: value, imagePath: imagePath);
  }

  @override
  void write(BinaryWriter writer, GenericQRCodeData obj) {
    writer.writeString(obj.value);
    writer.writeString(obj.imagePath);
  }
}

// Update adapters for other data types (WifiData, ContactData, etc.) to include imagePath field
class WifiDataAdapter extends TypeAdapter<WifiData> {
  @override
  int get typeId => 0;

  @override
  WifiData read(BinaryReader reader) {
    final ssid = reader.readString();
    final password = reader.readString();
    final securityType = WifiSecurityType.values.byName(reader.readString());
    final imagePath = reader.readString();
    return WifiData(
      ssid: ssid,
      password: password,
      securityType: securityType,
      imagePath: imagePath,
    );
  }

  @override
  void write(BinaryWriter writer, WifiData obj) {
    writer.writeString(obj.ssid);
    writer.writeString(obj.password);
    writer.writeString(obj.securityType.name);
    writer.writeString(obj.imagePath);
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
    final imagePath = reader.readString();
    return ContactData(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      imagePath: imagePath,
    );
  }

  @override
  void write(BinaryWriter writer, ContactData obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.phoneNumber);
    writer.writeString(obj.email);
    writer.writeString(obj.imagePath);
  }
}

class SMSDataAdapter extends TypeAdapter<SMSData> {
  @override
  int get typeId => 2;

  @override
  SMSData read(BinaryReader reader) {
    final phoneNumber = reader.readString();
    final msgBody = reader.readString();
    final imagePath = reader.readString();
    return SMSData(
      phoneNumber: phoneNumber,
      msgBody: msgBody,
      imagePath: imagePath,
    );
  }

  @override
  void write(BinaryWriter writer, SMSData obj) {
    writer.writeString(obj.phoneNumber);
    writer.writeString(obj.msgBody);
    writer.writeString(obj.imagePath);
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
    final imagePath = reader.readString();
    return EmailData(
      email: email,
      subject: subject,
      content: content,
      imagePath: imagePath,
    );
  }

  @override
  void write(BinaryWriter writer, EmailData obj) {
    writer.writeString(obj.email);
    writer.writeString(obj.subject);
    writer.writeString(obj.content);
    writer.writeString(obj.imagePath);
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
    final imagePath = reader.readString();
    return MyContactCardData(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      birthDate: birthDate,
      organization: organization,
      imagePath: imagePath,
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
    writer.writeString(obj.imagePath);
  }
}
