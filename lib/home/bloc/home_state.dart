import 'package:books_app/models/document.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeState {
  const HomeState();

  @override
  List<Object> get props => [];
}

class Initialized extends HomeState{
  @override
  String toString() => 'Init';
}

class DataState extends HomeState{
  final List<DocumentModel> documents;
  const DataState(this.documents);
  @override
  List<Object> get props => [documents];

  @override
  String toString() => 'return searches';
}

