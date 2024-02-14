import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 3)
class NotesModel extends HiveObject{
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String body;
  @HiveField(2)
  late String photo;
  @HiveField(3)
  late String audio;
  @HiveField(4)
  late String createTime;
  @HiveField(5)
  late String editTime;
  @HiveField(6)
  late String reminderTime;
}