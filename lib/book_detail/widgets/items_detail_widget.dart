import 'package:flutter/material.dart';

class ItemsDetailWidget extends StatelessWidget {

  final String tittle;
  final String text;
  const ItemsDetailWidget(this.tittle, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$tittle:  ',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                text,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}