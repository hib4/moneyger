import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/model/chat_model.dart';
import 'package:moneyger/service/api_service.dart';
import 'package:moneyger/ui/widget/chat/chat_message_item.dart';
import 'package:moneyger/ui/widget/custom_text_form_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatModel> _chat = [];
  List<ChatModel> _reversedChat = [];

  final _scrollController = ScrollController();
  final _questionController = TextEditingController();
  bool _isLoad = false;

  void addData(ChatModel model) {
    setState(() {
      _chat.add(model);
      _reversedChat = _chat.reversed.toList();
      _questionController.clear();
      _isLoad = !_isLoad;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konsultasi'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: _isLoad,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(right: 50),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                    ),
                    child: Lottie.asset('assets/lottie/typing.json', width: 25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _buildInput(),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: _reversedChat.length,
      itemBuilder: (_, index) {
        var message = _reversedChat[index];

        return ChatMessageItem(chat: message);
      },
    );
  }

  Widget _buildInput() {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: CustomTextFormField(
            label: 'Ketikkan seusatu',
            controller: _questionController,
            borderRadius: 30,
          ),
        ),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                const CircleBorder(),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(10),
              ),
              backgroundColor:
                  MaterialStateProperty.all(ColorValue.secondaryColor),
            ),
            onPressed: () async {
              if (_questionController.value.text.trim().isNotEmpty) {
                String text = _questionController.text.trim();
                addData(
                  ChatModel(text, false),
                );
                _scrollDown();
                String? answer = await ApiService().getCompletion(
                  context,
                  prompt: text,
                  maxTokens: 50,
                );
                if (answer != null) {
                  String singleLine = answer.replaceAll("\n", "");
                  addData(
                    ChatModel(singleLine, true),
                  );
                  _scrollDown();
                }
              }
            },
            child: const Icon(Icons.send, size: 20),
          ),
        ),
      ],
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
