import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:justnote/provider.dart';
import 'package:justnote/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'models/notes_model.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelGroupKey: 'basic_channel_group',
          channelName: 'Scheduled Notifications',
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: 'Notification channel for basic tests',)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: false
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotesProvider>(create: (_) => NotesProvider()),
      ],
      builder: (context, child){
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
            home: MainScreen());
      },
    );
  }
}

