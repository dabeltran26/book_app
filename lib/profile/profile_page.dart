import 'package:books_app/home/widgets/search_result_widget.dart';
import 'package:books_app/models/document.dart';
import 'package:books_app/profile/bloc/profile_bloc.dart';
import 'package:books_app/profile/bloc/profile_event.dart';
import 'package:books_app/profile/bloc/profile_state.dart';
import 'package:books_app/repository/favorite_book_repository.dart';
import 'package:books_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FavoriteBookRepository _favoriteRepository = FavoriteBookRepository();
  late ProfileBloc _profileBloc;
  List<DocumentModel>? myDocuments;

  @override
  void initState() {
    _profileBloc = ProfileBloc(_favoriteRepository);
    _profileBloc.add(Init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GeneralColors.white,
        body: BlocBuilder(
          bloc: _profileBloc,
          builder: (context, state) {

            if (state is DataState) {
              if(state.documents.isNotEmpty){
                myDocuments = state.documents;
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.count(
                      mainAxisSpacing: 10.0,
                      childAspectRatio: (3/6),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(myDocuments!.length, (index) {
                        return Hero(
                          tag: myDocuments![index].coverId,
                          child: BookWidget(
                            document: myDocuments![index],
                            function: (){
                              _profileBloc.add(DeleteBook(myDocuments![index]));
                              _profileBloc.add(Init());
                            },
                            labelAdd: 'Quitar',
                          ),
                        );
                      }),
                    ),
                  ),
                );
              }else{
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: const Text(
                    "No hay coincidencias.",
                    style: TextStyle(color: GeneralColors.black),
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }

            return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black12,
                ));
          },
        ));
  }
}
