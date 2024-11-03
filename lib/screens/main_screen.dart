import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); // Ganti dengan nama ikon aplikasi Anda

    // Hanya pengaturan untuk Android yang didefinisikan
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // Pengaturan iOS dihilangkan
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        // Tangani saat notifikasi ditekan
        print('Notifikasi ditekan dengan payload: ${notificationResponse.payload}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tekan tombol di bawah untuk mengirim notifikasi!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Logika untuk mengirim notifikasi bisa ditambahkan di sini
                print('Tombol untuk mengirim notifikasi ditekan!');
              },
              child: Text('Kirim Notifikasi'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}