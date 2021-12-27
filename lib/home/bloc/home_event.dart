import 'package:books_app/models/document.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent {}

class Init extends HomeEvent{
  final String text;
  Init(this.text);
}

class UpdateEvent extends HomeEvent{
  final List<DocumentModel> documents;
  final String text;
  UpdateEvent(this.documents, this.text);

  @override
  List<Object> get props => [];
}

class LikeBook extends HomeEvent{
  final DocumentModel book;
  LikeBook(this.book);
}