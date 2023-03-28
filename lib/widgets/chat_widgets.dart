import 'package:flutter/material.dart';
import 'package:robo_ai/constants/constants.dart';
import 'package:robo_ai/widgets/text_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
            decoration: chatIndex == 0
                ? const BoxDecoration()
                : BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 0.6,
                      ),
                    ),
                  ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  chatIndex == 0
                      ? Image.asset('assets/images/user.png',
                          width: 40, height: 40)
                      : Image.asset('assets/images/bot.png',
                          width: 40, height: 40),
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
