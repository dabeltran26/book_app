import 'package:books_app/models/document.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileState {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class Initialized extends ProfileState{
  @override
  String toString() => 'Init';
}

class DataState extends ProfileState{
  final List<DocumentModel> documents;
  const DataState(this.documents);
  @override
  List<Object> get props => [documents];

  @override
  String toString() => 'return favorites';
}

