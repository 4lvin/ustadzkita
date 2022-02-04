import 'package:daikita/src/app.dart';
import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

void main() async{
  DateTime sekarang;
  DateTime jam;
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true
  );
  getKota().then((value) async {
    final DateFormat formatter = DateFormat('HH:mm');
    final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
    jam = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    blocFitur.jadwalSholatTerdekat(formatter.format(jam), value, formatterDate.format(DateTime.now()));
  });
  blocFitur.resJadwalTerdekat.listen((value) {
    var parsedEndDate = DateTime.parse('${formatter.format(now)} ${value.result.waktu}');;
    Workmanager().registerPeriodicTask(
      "2",
      "",
      frequency: Duration(minutes: parsedEndDate.difference(sekarang).inMinutes),
    );
  });
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(App()));
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {

    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}
Future _showNotificationWithDefaultSound(flip) async {

  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );
  await flip.show(0, 'Adzan',
      'Waktunya Sholat',
      platformChannelSpecifics, payload: 'Default_Sound'
  );
}
