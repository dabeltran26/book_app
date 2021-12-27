import 'package:bloc/bloc.dart';
import 'package:books_app/models/document.dart';
import 'package:books_app/profile/bloc/profile_event.dart';
import 'package:books_app/profile/bloc/profile_state.dart';
import 'package:books_app/repository/favorite_book_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final FavoriteBookRepository _favoriteRepository;

  ProfileBloc(this._favoriteRepository) : super( Initialized() ) {

    List<DocumentModel> result;

    on<Init>( (event, emit ) async {
      try{
        result = await _favoriteRepository.getFavoritesBooks();
        emit(DataState(result));
      }catch(_){
        print('Error');
      }
    });

    on<DeleteBook>( (event, emit ) async {
      bool resp = await _favoriteRepository.deleteBook(event.book);
      if(resp){
        print('Ok');
      }else{
        print('Error');
      }
    });

  }
}