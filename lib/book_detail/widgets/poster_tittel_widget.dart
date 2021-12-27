import 'package:books_app/models/document.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PosterTittleWidget extends StatelessWidget {

  final DocumentModel document;
  const PosterTittleWidget( this.document );

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only( top: 20 ),
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Hero(
            tag: document.coverId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 150,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: document.getBookCover(),
                  placeholder: (context, string) => const CircularProgressIndicator(),
                  fit: BoxFit.fitWidth,
                  errorWidget: (context, _, error) => const Icon(Icons.error, color: Colors.black,),
                ),
              ),
            ),
          ),
          const SizedBox( width: 20 ),
          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 190 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( document.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2 ),
                Text( document.titleSuggest, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}