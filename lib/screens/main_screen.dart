import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justnote/constants.dart';
import 'package:justnote/models/boxes.dart';
import 'package:justnote/provider.dart';
import 'package:justnote/screens/note_screen.dart';
import 'package:justnote/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import '../models/notes_model.dart';
import '../widgets/add_button_widget.dart';
import 'ai_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kGrey,
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: Boxes.addNoteToBase().listenable(),
            builder: (context, box, _) {
              final notes = box.values.toList().cast<NotesModel>();
              return Consumer<NotesProvider>(
                builder: (context, data, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.white,
                        height: size.height * 0.08,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            const Spacer(),
                            ButtonWidget(
                                onTap: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const AIScreen())),
                                icon: Icons.lightbulb)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              child: ListView.builder(
                                  itemCount: box.length,
                                  padding: const EdgeInsets.only(bottom: 100),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        data.isEdit = true;
                                        notes[index].reminderTime == ''
                                            ? data.reminder = false : data.reminder = true;
                                        data.editNote(index, notes[index].title,
                                            notes[index].body,
                                            notes[index].reminderTime == ''
                                        ? 'x' : notes[index].reminderTime,
                                        notes[index].notificationId);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) =>
                                            const NoteScreen()));
                                      },
                                      onLongPress: () => data.deleteNote(box, index),
                                      child: Container(
                                        height: 44,
                                        margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        decoration: insetDecoration,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: SizedBox(
                                                width: 250,
                                                child: Text(notes[index].title,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                  style: kBlackStyle,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              notes[index].reminderTime == ''
                                                  ? 'X'
                                                  : DateFormat('d MMM Hm').format(DateTime.parse(notes[index].reminderTime)),
                                              style: kBlackStyleSmall,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                const SizedBox(height: 3),
                                                Text(
                                                  DateFormat('d MMM y').format(DateTime.parse(notes[index].editTime)),
                                                  style: kBlackStyleSmall,
                                                ),
                                                Text(
                                                  DateFormat('Hm').format(DateTime.parse(notes[index].editTime)),
                                                  style: kBlackStyleSmall,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 0,
                              child: AddButtonWidget(onTap: () {
                                data.isEdit = false;
                                data.reminder = false;
                                data.titleController.clear();
                                data.bodyController.clear();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) =>
                                    const NoteScreen()));
                                }
                              )
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ));
  }
}
