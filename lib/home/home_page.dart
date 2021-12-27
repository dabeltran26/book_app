import 'package:books_app/home/bloc/home_bloc.dart';
import 'package:books_app/home/bloc/home_event.dart';
import 'package:books_app/home/bloc/home_state.dart';
import 'package:books_app/home/repository/home_repository.dart';
import 'package:books_app/home/widgets/search_result_widget.dart';
import 'package:books_app/models/document.dart';
import 'package:books_app/profile/profile_page.dart';
import 'package:books_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  TextEditingController? controllerSearchField;
  String? textSearch;
  List<DocumentModel>? myDocuments;
  HomeRepository homeRepository = HomeRepository();

  @override
  void initState() {
    _homeBloc = HomeBloc(homeRepository, refreshTickets);
    _homeBloc.add(Init(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size padding = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GeneralColors.white,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.account_circle_outlined),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return const ProfilePage();
            }));
          },
        ),
        body: BlocBuilder(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is DataState) {
              myDocuments = myDocuments != null ? myDocuments : state.documents;
              return Stack(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: padding.width * 0.15,
                            right: padding.width * 0.15,
                            top: padding.height * 0.02,
                            bottom: padding.height * 0.02),
                        alignment: Alignment.center,
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: '¿Qué libro buscas?',
                            hintStyle: TextStyle(
                                color: GeneralColors.black.withOpacity(0.5)),
                          ),
                          controller: controllerSearchField,
                          style: const TextStyle(color: GeneralColors.black),
                          onChanged: (input) {
                            setState(() {
                              textSearch = input;
                            });
                            _homeBloc.add(UpdateEvent(myDocuments!, input));
                          },
                        ),
                      ),
                    ),
                    Expanded(
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
                                _homeBloc.add(LikeBook(myDocuments![index]));
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const ProfilePage();
                                }));
                              },
                              labelAdd: 'Agregar',
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
                myDocuments == null || myDocuments!.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        child: const Text(
                          "No hay coincidencias.",
                          style: TextStyle(color: GeneralColors.white),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(),
              ]);
            }

            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black12,
            ));
          },
        ));
  }

  void refreshTickets(List<DocumentModel> documents) {
    myDocuments = documents;
    setState(() {});
  }
}
