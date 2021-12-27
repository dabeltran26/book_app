import 'package:books_app/book_detail/book_detail_page.dart';
import 'package:books_app/models/document.dart';
import 'package:books_app/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {

  final DocumentModel document;
  final Function function;
  final String labelAdd;
  const BookWidget({Key? key, required this.document,required this.function,required this.labelAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BookDetailPage(document: document);
                  }));
                },
                child: CachedNetworkImage(
                  imageUrl: document.getBookCover(),
                  placeholder: (context, string) => const CircularProgressIndicator(),
                  fit: BoxFit.fitWidth,
                  errorWidget: (context, _, error) => const Icon(Icons.error, color: Colors.black,),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(child: Text(document.title,maxLines: 2,)),
                    GestureDetector(
                      onTap: (){
                        function();
                      },
                      child: Expanded(child: Text(labelAdd,style: const TextStyle(color: GeneralColors.blue),)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

}