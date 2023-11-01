import 'package:flutter/material.dart';
import 'package:robo_ai/constants/constants.dart';
import 'package:robo_ai/widgets/text_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

class ChatWidgets extends StatelessWidget {
  const ChatWidgets({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).cardColor,
          child: Container(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  chatIndex == 0
                      ? Image.asset(
                          'assets/images/user.png',
                          width: 35,
                          height: 35,
                          color: Theme.of(context).indicatorColor,
                        )
                      : Image.asset(
                          'assets/images/bot.png',
                          width: 35,
                          height: 35,
                          color: Theme.of(context).indicatorColor,
                        ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: chatIndex == 0
                        ? Text(
                            msg,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : DefaultTextStyle(
                            style: Theme.of(context).textTheme.bodyLarge!,
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 0,
                              animatedTexts: [
                                TyperAnimatedText(
                                  msg.trim(),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
