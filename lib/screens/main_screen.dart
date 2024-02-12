import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justnote/constants.dart';
import 'package:justnote/models/boxes.dart';
import 'package:justnote/provider.dart';
import 'package:justnote/screens/add_note_screen.dart';
import 'package:provider/provider.dart';
import '../models/notes_model.dart';
import '../widgets/add_button_widget.dart';

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
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              child: ListView.builder(
                                  itemCount: box.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 44,
                                      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                      decoration: insetDecoration,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(notes[index].title, style: kBlackStyle,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(height: 3),
                                              Text(
                                                DateFormat('d MMM y').format(DateTime.parse(notes[index].dateTime)),
                                                style: kBlackStyleSmall,
                                              ),
                                              Text(
                                                DateFormat('Hm').format(DateTime.parse(notes[index].dateTime)),
                                                style: kBlackStyleSmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 0,
                              child: AddButtonWidget(onTap: () =>
                                  Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                  const AddNoteScreen())),)
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
