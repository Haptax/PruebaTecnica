import 'package:flutter/material.dart';
import 'package:flutter_application_prueba/views/home_page.dart';
import 'package:provider/provider.dart';
import 'card_item.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) => cardProvider.searchCards(query),
        decoration: InputDecoration(
          hintText: 'Buscar cartas...',
          hintStyle: TextStyle(color: Colors.white54),
          prefixIcon: Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: Colors.black, // Mismo color que el fondo
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.white), // Texto blanco
      ),
    );
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);

    return Column(
      children: [
        SearchBar(),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!cardProvider.isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                cardProvider.fetchMoreCards();
              }
              return true;
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 2.5 / 4, // Ajusta la proporción de las cartas
              ),
              itemCount: cardProvider.cards.length,
              itemBuilder: (context, index) {
                final card = cardProvider.cards[index];
                return CardItem(card: card);
              },
            ),
          ),
        ),
        if (cardProvider.isLoading)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}

@override
Widget build(BuildContext context) {
  final cardProvider = Provider.of<CardProvider>(context);

  return Column(
    children: [
      SearchBar(), // Barra de búsqueda
      Expanded(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!cardProvider.isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              cardProvider.fetchMoreCards();
            }
            return true;
          },
          child: ListView.builder(
            itemCount: cardProvider.cards.length,
            itemBuilder: (context, index) {
              final card = cardProvider.cards[index];
              return CardItem(card: card);
            },
          ),
        ),
      ),
      if (cardProvider.isLoading)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
    ],
  );
}
