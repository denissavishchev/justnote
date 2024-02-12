import 'package:flutter/material.dart';
import 'package:justnote/constants.dart';
import 'package:justnote/provider.dart';
import 'package:provider/provider.dart';

import '../widgets/button_widget.dart';
import 'main_screen.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGrey,
      body: SafeArea(
        child: Consumer<NotesProvider>(
          builder: (context, data, _){
            return Column(
              children: [
                const SizedBox(height: 12,),
                Container(
                  color: Colors.transparent,
                  height: size.height * 0.08,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                          onTap: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) =>
                              const MainScreen())),
                        icon: Icons.arrow_back,
                          ),
                      const Spacer(),
                      ButtonWidget(
                          onTap: () => print('reminder'),
                        icon: Icons.alarm,
                          ),
                      const SizedBox(width: 30,),
                      ButtonWidget(
                          onTap: () => data.addNoteToBase(context),
                        icon: Icons.check,
                          ),
                    ],
                  ),
                ),
                Container(
                    height: 44,
                    margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: insetDecoration,
                    child: Center(
                      child: TextField(
                        controller: data.titleController,
                        cursorColor: Colors.white,
                        style: kBlackStyle,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                            hintText: 'Title',
                            hintStyle: TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.7))
                        ),
                      ),
                    )),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: insetDecoration,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: data.bodyController,
                        cursorColor: Colors.white,
                        style: kBlackStyle,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                            hintText: 'Description',
                            hintStyle: TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.7))
                        ),
                      )),
                ),
                const SizedBox(height: 12,),
              ],
            );
          },
        ),
      ),
    );
  }
}
