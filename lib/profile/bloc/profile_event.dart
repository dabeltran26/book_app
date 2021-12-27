import 'package:books_app/models/document.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileEvent {}

class Init extends ProfileEvent{}

class DeleteBook extends ProfileEvent{
  final DocumentModel book;
  DeleteBook(this.book);
}
