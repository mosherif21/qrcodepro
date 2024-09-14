import 'package:hive_flutter/adapters.dart';
import 'package:qrcodepro/src/features/database/hive_models.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WifiDataAdapter());
  Hive.registerAdapter(ContactDataAdapter());
  Hive.registerAdapter(SMSDataAdapter());
  Hive.registerAdapter(EmailDataAdapter());
  Hive.registerAdapter(MyContactCardDataAdapter());
}

Future<void> saveQRCodeData(QRCodeData data) async {
  final box = await Hive.openBox<QRCodeData>('qrcodesScannedData');
  await box.add(data);
}

Future<List<QRCodeData>> getQRCodeData() async {
  final box = await Hive.openBox<QRCodeData>('qrcodesScannedData');
  final dataList = box.values.toList();
  return dataList;
}
