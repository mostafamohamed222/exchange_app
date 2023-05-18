import 'package:flutter/material.dart';


import '../../core/appbloc/appbloc.dart';
import '../../core/models/excahngeModel.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({super.key , required this.rateModel});


  final ExchangeModel rateModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              rateModel.day.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "1 ${AppBloc.get(context).baseCode}   = ${rateModel.rate}${AppBloc.get(context).toCode} ",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
