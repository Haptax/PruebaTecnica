import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_model.dart';

class CardController {
  static const String apiUrl = "https://db.ygoprodeck.com/api/v7/cardinfo.php";

  Future<List<CardModel>> fetchCards(int offset, int limit) async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final cards = (data['data'] as List)
          .skip(offset)
          .take(limit)
          .map((json) => CardModel.fromJson(json))
          .toList();
      return cards;
    } else {
      throw Exception('Error al cargar cartas');
    }
  }
}
