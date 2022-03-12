import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinlist_app/bloc/home/home_bloc.dart';
import 'package:sinlist_app/bloc/list/list_repository.dart';
import 'package:sinlist_app/core/http/api_provider.dart';
import 'package:sinlist_app/pages/home_page.dart';
import 'package:sinlist_app/pages/lists/list_items.dart';

class BlocProviders {
  static List<BlocProvider> get ({ApiProvider apiProvider}) {
    return [
      BlocProvider<HomeBloc>(create: (BuildContext context) {
        return HomeBloc(repository: new ListRepository(apiProvider: apiProvider));
      },
      child: HomePage(),),
      BlocProvider<HomeBloc>(create: (BuildContext context) {
        return HomeBloc(repository: new ListRepository(apiProvider: apiProvider));
      },
        child: ListItems(),),
    ];
  }
}