import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justnote/provider.dart';
import 'package:justnote/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/button_widget.dart';
import '../widgets/messages_widget.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<NotesProvider>(
          builder: (context, data, _){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.white,
                    height: size.height * 0.08,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        ButtonWidget(
                            onTap: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                const MainScreen())),
                            icon: Icons.backspace)
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: data.messages.length,
                          itemBuilder: (context, index){
                            final message = data.messages[index];
                            return Messages(
                                isUser: message.isUser, 
                                message: message.message, 
                                date: DateFormat('HH:mm').format(DateTime.parse(message.date)));
                          })
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.75,
                          child: TextFormField(
                            controller: data.messageController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              label: const Text('Ask me!')
                            ),
                          ),
                        ),
                        ButtonWidget(
                            onTap: () => data.sendMessage(),
                            icon: Icons.send)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      ),
    );
  }
}
