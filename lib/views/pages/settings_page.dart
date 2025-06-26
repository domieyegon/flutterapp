import 'package:flutter/material.dart';
import 'package:flutterapp/views/pages/expanded_flexible_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? menuItem = 'e1';

  //https://www.fluttermapp.com/articles/local-notifications
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    init().then((_) {
      showInstantNotification(id: 0, title: 'Hello', body: 'It works!');
    });
    super.initState();
  }

  Future<void> init() async {
    initializeTimeZones();


    // try {
    //   final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    //   setLocalLocation(getLocation(currentTimeZone));
    // } catch {
    //   setLocalLocation(getLocation('Africa/Nairobi'));
    // }

    setLocalLocation(getLocation('Africa/Nairobi'));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant notifications',
          channelDescription: 'Instant notifications channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
}) async {
    TZDateTime now = TZDateTime.now(local);
    TZDateTime scheduledDate = now.add(Duration(seconds: 3));

    await notificationsPlugin.zonedSchedule(id, title, body, scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily_reminder_channel_id',
              'Daily reminders',
            channelDescription: 'Reminder to complete daily tasks',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilledButton(
                onPressed: () {
                  showInstantNotification(
                    id: 1,
                    title: 'Instant notif',
                    body: 'Hell! you there?',
                  );
                },
                child: Text('Show Instant alert'),
              ),
              FilledButton(
                onPressed: () {
                  scheduleReminder(
                    id: 1,
                    title: 'Schedule notif',
                    body: 'Hey! you there? has scheduled this',
                  );
                },
                child: Text('Show scheduled alert'),
              ),
              DropdownButton(
                value: menuItem,
                items: [
                  DropdownMenuItem(value: 'e1', child: Text('Element 1')),
                  DropdownMenuItem(value: 'e2', child: Text('Element 2')),
                  DropdownMenuItem(value: 'e3', child: Text('Element 3')),
                  DropdownMenuItem(value: 'e4', child: Text('Element 4')),
                ],
                onChanged: (String? value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Text(controller.text),
              Checkbox.adaptive(
                tristate: true,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              CheckboxListTile.adaptive(
                tristate: true,
                title: Text('Click me'),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),

              Switch.adaptive(
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text('Switch me'),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              Slider.adaptive(
                max: 10,
                divisions: 10,
                value: sliderValue,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              Text('$sliderValue'),

              InkWell(
                splashColor: Colors.teal,
                onTap: () {
                  setState(() {
                    isSwitched = !isSwitched;
                  });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white12,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Alert title'),
                      content: Text('Alert content'),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text('Open dialogue'),
              ),
              Divider(color: Colors.teal, thickness: 2.0, endIndent: 200.0),
              Container(height: 50, child: VerticalDivider(color: Colors.teal)),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 5),
                      behavior: SnackBarBehavior.floating,
                      content: Text('Snackbar'),
                    ),
                  );
                },
                child: Text('Open snackbar'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ExpandedFlexiblePage();
                      },
                    ),
                  );
                },
                child: Text('Show Flexible & Expanded'),
              ),
              TextButton(onPressed: () {}, child: Text('Click me')),
              OutlinedButton(onPressed: () {}, child: Text('Click me')),
              CloseButton(onPressed: () {}),
              BackButton(onPressed: () {}),

              GestureDetector(
                onTap: () {
                  setState(() {
                    isSwitched = !isSwitched;
                  });
                },
                child: Image.asset('assets/images/space-3.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
