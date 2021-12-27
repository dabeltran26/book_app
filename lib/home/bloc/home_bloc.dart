import 'package:bloc/bloc.dart';
import 'package:books_app/home/bloc/home_event.dart';
import 'package:books_app/home/bloc/home_state.dart';
import 'package:books_app/home/repository/home_repository.dart';
import 'package:books_app/models/document.dart';
import 'package:books_app/models/search_result.dart';
import 'package:books_app/repository/favorite_book_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final HomeRepository _homeRepository;
  final Function(List<DocumentModel> documents) callback;

  HomeBloc(this._homeRepository, this.callback) : super( Initialized() ) {
    FavoriteBookRepository favoriteBookRepository = FavoriteBookRepository();
    SearchResult result;

    on<Init>( (event, emit ) async {
      try{
        result = await _homeRepository.fetchSearchResults(event.text);
        emit(DataState(result.docs));
      }catch(_){
        print('pailas');
      }
    });

    on<UpdateEvent>( (event, emit ) async {
      result = await _homeRepository.fetchSearchResults(event.text);
      if(result.docs.isEmpty){
        callback.call([]);
      }else{
        callback.call(result.docs);
      }
    });

    on<LikeBook>( (event, emit ) async {
      bool resp = await favoriteBookRepository.saveBook(event.book);
      if(resp){
        print('Ok');
      }else{
        print('Error');
      }
    });

  }
}