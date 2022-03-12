import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinlist_app/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinlist_app/core/bloc/result_state.dart';
import 'package:sinlist_app/core/http/network_exceptions.dart';
import 'package:sinlist_app/data/lists/todolist.dart';
import 'package:sinlist_app/data/lists/todolist_items.dart';
import 'package:sinlist_app/pages/constants.dart';
import 'package:sinlist_app/pages/lists/list_items.dart';
import 'package:sinlist_app/pages/widgets/toaster.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  final String routeName = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = new ScrollController();
  Todolist selectedTodolist = new Todolist();
  List<TodoListItems> todolistItems = <TodoListItems>[];

  Future<void> _getTodolistItems(BuildContext buildContext,int selectedTodolistId) async {
    var result = await buildContext
        .read<HomeBloc>()
        .repository
        .getTodoListByItems(selectedTodolistId == null ? 0 : selectedTodolistId);
    result.when(success: (List<TodoListItems> response) {
      if (response != null) {
        setState(() {
          todolistItems = response;
        });
      }
    }, failure: (NetworkExceptions error) {
      Toaster.error(context: buildContext, error: error);
    });
  }

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().getTodolists("123");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              'Sinlist',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Image.asset(
              'assets/images/cookie-bite-solid.png',
              color: kPrimaryColor,
              width: 30,
              height: 30,
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, ResultState<List<Todolist>>>(
        builder: (BuildContext context, ResultState<List<Todolist>> state) {
          return state.when(
              idle: () => Container(),
              loading: () => Center(child: CircularProgressIndicator()),
              data: (data) => _dataWidget(context, data),
              error: (error) => Center(
                  child: Text(NetworkExceptions.getErrorMessage(error))));
        },
      ),
    );
  }

  _dataWidget(BuildContext buildContext, List<Todolist> todolist) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0),
                height: 117,
                width: size.width * 0.94,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: todolist.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == todolist.length - 1) {
                        return Container(
                          width: 117,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kPrimaryColor),
                          child: _addTodolistView(
                              buildContext, todolist[index], index),
                        );
                      } else {
                        return Container(
                          width: 117,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kPrimaryColor),
                          child: _getTodolistItemsView(
                              buildContext, todolist[index], index),
                        );
                      }
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
         _showListItems(buildContext,selectedTodolist),
        ],
      ),
    );
  }

  _getTodolistItemsView(BuildContext buildContext, Todolist item, int index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        child: Row(
          children: [
            Text(
              item.name,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            selectedTodolist = item;
            _getTodolistItems(buildContext,selectedTodolist.id);
          });
        },
      ),
    );
  }

  _showListItems(BuildContext buildContext,Todolist todolist) {
    return ListItems(todolist: todolist,todolistItems: todolistItems);
  }

  _addTodolistView(BuildContext buildContext, Todolist item, int index) {
    return Container(
      padding: EdgeInsets.all(1),
      child: GestureDetector(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 10.0),
                width: 50,
                child: Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
