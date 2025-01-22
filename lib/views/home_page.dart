import 'package:flutter/material.dart';
import 'package:flutter_application_prueba/views/card_list.dart';
import 'package:provider/provider.dart';
import '../models/card_model.dart';
import '../controllers/card_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yu-Gi-Oh! Cards', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF212121),
      ),
      body: ChangeNotifierProvider(
        create: (context) {
          final provider = CardProvider();
          provider.fetchMoreCards(); // Carga inicial
          return provider;
        },
        child: CardList(),
      ),
    );
  }
}

class CardProvider extends ChangeNotifier {
  final CardController _controller = CardController();
  List<CardModel> _allCards = [];
  List<CardModel> _filteredCards = [];
  int _offset = 0;
  final int _limit = 10;
  bool _isLoading = false;

  List<CardModel> get cards =>
      _filteredCards.isEmpty ? _allCards : _filteredCards;
  bool get isLoading => _isLoading;

  Future<void> fetchMoreCards() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final newCards = await _controller.fetchCards(_offset, _limit);
      _allCards.addAll(newCards);
      _offset += _limit;
    } catch (error) {
      print('Error al cargar más cartas: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchCards(String query) {
    if (query.isEmpty) {
      _filteredCards = [];
    } else {
      _filteredCards = _allCards
          .where(
              (card) => card.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
