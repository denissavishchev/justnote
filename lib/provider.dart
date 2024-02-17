import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:justnote/constants.dart';
import 'models/boxes.dart';
import 'models/notes_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotesProvider with ChangeNotifier {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  int editIndex = 0;
  bool isEdit = true;

  DateTime dateTime = DateTime.now();
  int notificationId = 0;

  bool reminder = false;

  void editNote(int index, String title, String body, String reminderTime, int id){
    titleController.text = title;
    bodyController.text = body;
    dateTime = reminderTime == 'x' ? DateTime.now() : DateTime.parse(reminderTime);
    notificationId = id;
    editIndex = index;
    notifyListeners();
  }

  void editNoteToBase(int index, String title, String body, String time, Box<NotesModel> box){
    notificationId = DateTime.now().microsecondsSinceEpoch.remainder(200);
    box.putAt(index, NotesModel()
        ..title = title
        ..body = body
        ..photo = '0'
        ..audio = '0'
        ..createTime = time
        ..editTime = DateTime.now().toString()
        ..reminderTime = reminder ? dateTime.toString() : ''
      ..notificationId = notificationId
    );
    if(reminder){
      addNotificationData();
    }
  }

  Future addNoteToBase(context) async {
    notificationId = DateTime.now().microsecondsSinceEpoch.remainder(200);
    final note = NotesModel()
      ..title = titleController.text
      ..body = bodyController.text
      ..photo = '0'
      ..audio = '0'
      ..createTime = DateTime.now().toString()
      ..editTime = DateTime.now().toString()
      ..reminderTime = reminder ? dateTime.toString() : ''
      ..notificationId = notificationId;
    final box = Boxes.addNoteToBase();
    box.add(note);
    if(reminder){
      addNotificationData();
    }
    titleController.clear();
    bodyController.clear();
    dateTime = DateTime.now();
    reminder = false;
    notifyListeners();
  }

  deleteNote(Box<NotesModel> box, int index){
    box.deleteAt(index);
  }


  Future<void> addNotificationData() async {
    AwesomeNotifications().setChannel(NotificationChannel(
        channelKey: 'scheduled',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Notification channel for basic tests'));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'scheduled',
        title: '${Emojis.time_alarm_clock} ${titleController.text}',
      ),
      schedule: NotificationCalendar(
        year: dateTime.year,
        month: dateTime.month,
        day: dateTime.day,
        hour: dateTime.hour,
        minute: dateTime.minute,
        second: 0,
        repeats: false
      ),
    );
  }
  
  void setNotificationTime(context){
      showCupertinoModalPopup(
          context: context,
          builder: (context){
            return Container(
              height: 300,
              decoration: const BoxDecoration(
                  color: kGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: (){
                        AwesomeNotifications().cancel(notificationId);
                        reminder = true;
                        notifyListeners();
                        Navigator.of(context).pop();
                      },
                          child: Text('Add')),
                      ElevatedButton(onPressed: () {
                        AwesomeNotifications().cancel(notificationId);
                        reminder = false;
                        notifyListeners();
                        Navigator.of(context).pop();
                      },
                          child: Text('Remove')),
                    ],
                  ),
                  SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoDatePicker(
                      initialDateTime: dateTime,
                      onDateTimeChanged: (DateTime newTime){
                        dateTime = newTime;
                        notifyListeners();
                      },
                      use24hFormat: true,
                    ),
                  ),
                ],
              ),
            );
          });
  }

}