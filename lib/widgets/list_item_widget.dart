import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justnote/models/notes_model.dart';
import 'package:justnote/provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/boxes.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: Boxes.addNoteToBase().listenable(),
        builder: (context, box, _){
          return Consumer<NotesProvider>(
              builder: (context, data, _){
                final notes = box.values.toList().cast<NotesModel>();
                return Expanded(
                  child: SizedBox(
                    width: size.width,
                    child: ListView.builder(
                      itemCount: box.length,
                        itemBuilder: (context, index){
                          return Container(
                            height: 44,
                            margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(width: 2, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 3,
                                    spreadRadius: 0.3,
                                    offset: const Offset(2, 2)
                                ),
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                const BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 2,
                                    spreadRadius: -2,
                                    offset: Offset(2, 2)
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.grey.withOpacity(0.23),
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                                stops: const [0.2, 1.0],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(notes[index].title, style: kBlackStyle,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 3,),
                                    Text(DateFormat('d MMM y').format(DateTime.parse(notes[index].dateTime)),
                                      style: kBlackStyleSmall,),
                                    Text(DateFormat('Hm').format(DateTime.parse(notes[index].dateTime)),
                                      style: kBlackStyleSmall,),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                );
              });
        });
  }
}