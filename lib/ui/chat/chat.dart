import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneyger/common/app_theme_data.dart';
import 'package:moneyger/common/color_value.dart';
import 'package:moneyger/common/shared_code.dart';
import 'package:moneyger/model/chat_model.dart';
import 'package:moneyger/service/api_service.dart';
import 'package:moneyger/ui/subscribe/subscribe.dart';
import 'package:moneyger/ui/widget/chat/chat_message_item.dart';
import 'package:moneyger/ui/widget/custom_text_form_field.dart';
import 'package:provider/provider.dart';

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
  final ValueNotifier<bool> _isCheckSubs = ValueNotifier<bool>(true);

  void _addData(ChatModel model, {bool isFirst = false}) {
    setState(() {
      _chat.add(model);
      _reversedChat = _chat.reversed.toList();
      _questionController.clear();
      _isLoad = isFirst ? false : !_isLoad;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkTokenStatus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  Future _checkTokenStatus() async {
    String check = await SharedCode().getToken('chat') ?? '';
    String subs = await SharedCode().getToken('subs') ?? '';

    if (subs == 'true') {
      _isCheckSubs.value = false;
      _addData(
        ChatModel(
          'Hai, dengan Tim Konsultasi disini. Ada yang bisa kita bantu tentang masalah keuangan?',
          true,
        ),
        isFirst: true,
      );
    } else {
      if (check == '') {
        _isCheckSubs.value = true;
      } else {
        _isCheckSubs.value = false;
        _addData(
          ChatModel(
            'Hai, dengan Tim Konsultasi disini. Ada yang bisa kita bantu tentang masalah keuangan?',
            true,
          ),
          isFirst: true,
        );
      }
    }
  }

  Future<bool> _setTokenSubs() async {
    bool status = await SharedCode().setToken('chat', 'true');
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konsultasi'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: _buildList(),
                ),
                Visibility(
                  visible: _isLoad,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(right: 50),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200,
                        ),
                        child: Lottie.asset('assets/lottie/typing.json',
                            width: 25),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: _buildInput(provider.isDarkMode),
                ),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isCheckSubs,
              builder: (_, value, __) => Visibility(
                visible: value,
                child: _popUp(size.width, size.height),
              ),
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

  Widget _buildInput(bool isDarkMode) {
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
              backgroundColor: MaterialStateProperty.all(
                isDarkMode
                    ? ColorValueDark.secondaryColor
                    : ColorValue.secondaryColor,
              ),
            ),
            onPressed: () async {
              if (_questionController.value.text.trim().isNotEmpty) {
                String text = _questionController.text.trim();
                _addData(
                  ChatModel(text, false),
                );
                _scrollDown();
                String? answer = await ApiService().getCompletion(
                  context,
                  prompt: text,
                  maxTokens: 256,
                );
                if (answer != null) {
                  String singleLine = answer.replaceAll("\n", "");
                  _addData(
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

  Widget _popUp(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.black.withOpacity(0.3),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: ColorValue.secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 150,
                margin: const EdgeInsets.only(top: 28, bottom: 8),
                child: const Image(
                    image: AssetImage('assets/images/subscribe.png')),
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                width: 220,
                child: Text(
                  'Bebas konsultasi keuangan tiap hari dengan Moneyger Premium',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: () async {
                  await _setTokenSubs().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubscribePage(),
                        ));
                  });
                },
                child: const Text(
                  'Berlangganan',
                  style: TextStyle(color: ColorValue.secondaryColor),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: () async {
                  await _setTokenSubs().then((value) {
                    _isCheckSubs.value = false;
                    _addData(
                      ChatModel(
                        'Hai, dengan Tim Konsultasi disini. Ada yang bisa kita bantu tentang masalah keuangan?',
                        true,
                      ),
                      isFirst: true,
                    );
                  });
                },
                child: const Text(
                  'Coba Gratis 3 Hari',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
