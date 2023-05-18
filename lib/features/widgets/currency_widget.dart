import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CurrencyWidget extends StatelessWidget {
  CurrencyWidget(
      {super.key,
      required this.code,
      required this.search,
      required this.showText});

  String showText = "";
  var search = TextEditingController();
  List<String> code;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .3,
          child: Text(
            showText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: CustomDropdown.search(
              hintText: 'Select currency',
              items: code,
              controller: search,
            ),
          ),
        ),
      ],
    );
  }
}
