import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordCard extends StatelessWidget {
  const WordCard({Key? key, this.onTap, required this.word}) : super(key: key);
  final void Function()? onTap;
  final String word;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: Text(
              word,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
