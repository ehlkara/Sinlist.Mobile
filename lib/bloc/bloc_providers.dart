import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinlist_app/core/http/api_provider.dart';
import 'package:sinlist_app/pages/home_page.dart';

class BlocProviders {
  static List<BlocProvider> get ({ApiProvider apiProvider}) {
    return [
      BlocProvider(create: (BuildContext context) {},
      child: HomePage(),),
    ];
  }
}