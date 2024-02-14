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

  bool reminder = false;

  void editNote(int index, String title, String body){
    titleController.text = title;
    bodyController.text = body;
    editIndex = index;
    notifyListeners();
  }

  void editNoteToBase(int index, String title, String body, String time, Box<NotesModel> box){
    box.putAt(index, NotesModel()
        ..title = title
        ..body = body
        ..photo = '0'
        ..audio = '0'
        ..createTime = time
        ..editTime = DateTime.now().toString()
        ..reminderTime = reminder ? dateTime.toString() : ''
    );
    if(reminder){
      addNotificationData();
    }
  }

  Future addNoteToBase(context) async {
    final note = NotesModel()
      ..title = titleController.text
      ..body = bodyController.text
      ..photo = '0'
      ..audio = '0'
      ..createTime = DateTime.now().toString()
      ..editTime = DateTime.now().toString()
      ..reminderTime = reminder ? dateTime.toString() : '';
    final box = Boxes.addNoteToBase();
    box.add(note);
    if(reminder){
      addNotificationData();
    }
    titleController.clear();
    bodyController.clear();
  }

  deleteNote(Box<NotesModel> box, int index){
    box.deleteAt(index);
  }

  Future<void> addNotificationData() async {
    AwesomeNotifications().setChannel(NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Notification channel for basic tests'));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().microsecondsSinceEpoch.remainder(200),
        channelKey: 'basic_channel',
        title: '${Emojis.animals_worm} Drink some Note',
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
    if(reminder == false){
      reminder = true;
      showCupertinoModalPopup(
          context: context,
          builder: (context){
            return Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: kGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))
              ),
              child: CupertinoDatePicker(
                initialDateTime: dateTime,
                onDateTimeChanged: (DateTime newTime){
                  dateTime = newTime;
                  notifyListeners();
                },
                use24hFormat: true,
              ),
            );
          });
    }else{
      reminder = false;
    }
    notifyListeners();
  }

}