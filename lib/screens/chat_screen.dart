import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:robo_ai/constants/constants.dart';
import 'package:robo_ai/models/chat_model.dart';
import 'package:robo_ai/providers/chat_provider.dart';
import 'package:robo_ai/services/api_service.dart';
import 'package:robo_ai/widgets/chat_widgets.dart';
import 'package:provider/provider.dart';
import 'package:robo_ai/widgets/text_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTyping = false;
  late TextEditingController msgController;
  late ScrollController listScrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    listScrollController = ScrollController();
    msgController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    listScrollController.dispose();
    msgController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          Flexible(
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.white
                  ],
                  stops: [0.0, 0.0, 0.95, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: ListView.builder(
                  controller: listScrollController,
                  itemCount: chatProvider.getChatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidgets(
                      msg: chatProvider.getChatList[index].msg,
                      chatIndex: chatProvider.getChatList[index].chatIndex,
                    );
                  }),
            ),
          ),
          isTyping
              ? const SpinKitThreeBounce(
                  color: Colors.grey,
                  size: 18,
                )
              : const SizedBox.shrink(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: messageTextField(chatProvider),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget messageTextField(ChatProvider chatProvider) {
    return SizedBox(
      height: 60,
      child: TextField(
        enabled: !isTyping,
        focusNode: focusNode,
        controller: msgController,
        onSubmitted: (value) async {
          await sendMessageFCT(chatProvider: chatProvider);
        },
        cursorColor: Theme.of(context).indicatorColor,
        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).highlightColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
            ),
            suffixIcon: IconButton(
              onPressed: () async {
                await sendMessageFCT(chatProvider: chatProvider);
              },
              icon: Icon(
                FontAwesomeIcons.solidPaperPlane,
                size: 20,
                color: Theme.of(context).indicatorColor,
              ),
              splashColor: Colors.transparent,
            )),
      ),
    );
  }

  void scrollListToEND() {
    listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut);
  }

  Future<void> sendMessageFCT({required ChatProvider chatProvider}) async {
    if (msgController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Row(
            children: const [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              SizedBox(width: 5),
              Text(
                'Please type something',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
      return;
    }
    try {
      String msg = msgController.text;
      setState(() {
        isTyping = true;
        //chatList.add(ChatModel(msg: msgController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        msgController.clear();
        focusNode.unfocus();
      });
      log('Message has been sent');
      await chatProvider.sendMessageAndGetAnswers(msg: msg);
      /*chatList.addAll(
          await ApiService.sendMessageTest(message: msgController.text));*/
      setState(() {});
    } catch (error) {
      log('Error $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              const Icon(Icons.error_outline_rounded, color: Colors.white),
              const SizedBox(width: 5),
              const Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    } finally {
      setState(() {
        isTyping = false;
        scrollListToEND();
      });
    }
  }
}
