import 'package:flutter/material.dart';
import 'package:itm/ColorPalettes/color.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.backgroundcolor,
      body: Center(
        child: Text('Favorites Page'),
      ),
    );
  }
}
