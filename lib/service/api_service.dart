import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:moneyger/constant/openai.dart';
import 'package:moneyger/model/artikel_model.dart';
import 'package:moneyger/ui/widget/snackbar/snackbar_item.dart';

class ApiService {
  final _baseUrlOpenAI = 'https://api.openai.com/v1';

  Future getCompletion(
    BuildContext context, {
    String model = 'text-davinci-003',
    required String prompt,
    required num maxTokens,
    num temperature = 0.9,
    num topP = 1,
    num n = 1,
    bool stream = false,
    num presencePenalty = 0,
    num frequencyPenalty = 0,
  }) async {
    try {
      final apiKey = OpenAi().apiKey;
      const endPoint = '/completions';
      final uri = Uri.parse('$_baseUrlOpenAI$endPoint');

      Map reqData = {
        'model': model,
        'prompt': prompt,
        'max_tokens': maxTokens,
        'temperature': temperature,
        'top_p': topP,
        'n': n,
        'stream': stream,
        'presence_penalty': presencePenalty,
        'frequency_penalty': frequencyPenalty,
      };

      final response = await http
          .post(
            uri,
            headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $apiKey',
            },
            body: jsonEncode(reqData),
          )
          .timeout(
            const Duration(seconds: 120),
          );

      if (response.statusCode == 200) {
        print(prompt);
        print(response.body);
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map['choices'];
        return data[0]['text'];
      }
    } on SocketException {
      showSnackBar(context, title: 'Tidak ada koneksi internet');
      return;
    }
  }

  Future<List> getservice() async {
    List artikel = [];
    String json = await rootBundle.loadString("assets/json/artikel.json");

    List datajson = jsonDecode(json);

    datajson.map((value) {
      artikel.add(ArtikelModel.fromJson(value));
    }).toList();
    return artikel;
  }
}
