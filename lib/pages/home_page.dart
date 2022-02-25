import 'package:flutter/material.dart';
import 'package:sinlist_app/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinlist_app/core/bloc/result_state.dart';
import 'package:sinlist_app/core/http/network_exceptions.dart';
import 'package:sinlist_app/data/lists/todolist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  final String routeName = "/home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().getTodolists("123");
    super.didChangeDependencies();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, ResultState<List<Todolist>>>(
        builder: (BuildContext context, ResultState<List<Todolist>> state) {
          return state.when(
              idle: () => Container(),
              loading: () => Center(child: CircularProgressIndicator()),
              data: (data) => _dataWidget(context, data),
              error: (error) => Center(child: Text(NetworkExceptions.getErrorMessage(error))));
        },
      ),
    );
  }

  _dataWidget(BuildContext buildContext, List<Todolist> todolist) {
    return SingleChildScrollView(
      child: Container(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: todolist.length,
          itemBuilder: (BuildContext itemBuilderContext, int index){
            return Container(
              margin: EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0.3,
                borderOnForeground: true,
                child: _getTodolistItemsView(buildContext, todolist[index], index),
              ),
            );
          },
        ),
      ),
    );
  }

  _getTodolistItemsView(BuildContext buildContext, Todolist item, int index)
  {
    return Container(
      child: Row(
        children: [
          Text(item.id.toString()),
          Text(item.name),
          Text(item.deviceInfo),
        ],
      ),
    );
  }
}
