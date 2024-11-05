import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:patrol_tutorial_prep/pages/integration_test_keys.dart';
import 'package:patrol_tutorial_prep/ui/images.dart';
import 'package:patrol_tutorial_prep/ui/style/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<bool> _requestPermission() async {
    var status = await Permission.notification.status;

    if (status != PermissionStatus.granted) {
      status = await Permission.notification.request();
    }

    return switch (status) {
      PermissionStatus.granted => true,
      _ => false,
    };
  }

  Future<void> _initNotifications(VoidCallback onNotificationTap) async {
    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('notification_icon'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (_) => onNotificationTap(),
    );
  }

  Future<void> triggerLocalNotification({
    required VoidCallback onPressed,
    required VoidCallback onError,
  }) async {
    final hasPermission = await _requestPermission();
    if (!hasPermission) {
      onError();
      return;
    }
    await _initNotifications(onPressed);

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'patrolTutorialChannelId',
        'patrolTutorialChannel',
        importance: Importance.max,
        priority: Priority.high,
        color: PTColors.lcBlack,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        interruptionLevel: InterruptionLevel.active,
      ),
    );

    final timezone = await FlutterTimezone.getLocalTimezone();
    final scheduledTime =
        TZDateTime.now(getLocation(timezone)).add(const Duration(seconds: 3));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Patrol says hello!',
      'This is a notification from the Patrol tutorial app.',
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            key: keys.homePage.notificationIcon,
            icon: const Icon(Icons.notification_add),
            onPressed: () {
              triggerLocalNotification(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      key: keys.homePage.successSnackbar,
                      content: const Text('Notification was tapped!'),
                    ),
                  );
                },
                onError: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Permission was not granted!'),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: PTImages.patrolLogo,
      ),
    );
  }
}
