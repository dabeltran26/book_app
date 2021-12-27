import 'package:books_app/book_detail/widgets/items_detail_widget.dart';
import 'package:books_app/book_detail/widgets/poster_tittel_widget.dart';
import 'package:books_app/models/document.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final DocumentModel document;
  const BookDetailPage({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
                  PosterTittleWidget( document ),
                  ItemsDetailWidget( 'Autor',document.authorName.first ),
                  ItemsDetailWidget( 'Cotribuidor',document.contributor.first ),
                  ItemsDetailWidget( 'Fecha publicacion',document.firstPublishYear.toString() ),
                  ItemsDetailWidget( 'Editora',document.publisher.first ),
                  Container(
                      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
                      child: languajes(document,context))
                ])
            )
          ],
        )
    );
  }

  Widget languajes(DocumentModel document, BuildContext context){
    List<Widget> items = [];
    for(int i =0 ;i<document.language.length; i++){
      items.add(Text(document.language[i]+' , '));
    }
    return Row(
      children: [
        Text('Idiomas:  ',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,),
        Row(
          children: items,
        )
      ],
    );
  }

}

