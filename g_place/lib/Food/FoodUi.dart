import 'package:flutter/material.dart';

class FoodUi extends StatefulWidget {
  const FoodUi({Key? key}) : super(key: key);

  @override
  State<FoodUi> createState() => _FoodUiState();
}

class _FoodUiState extends State<FoodUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          IconButton(
              splashRadius: 1,
              onPressed: () {
                print('hy');
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              )),
          IconButton(
              splashRadius: 1,
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Food',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
