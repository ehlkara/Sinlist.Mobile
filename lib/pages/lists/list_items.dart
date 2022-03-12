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
import 'package:sinlist_app/pages/widgets/toaster.dart';

class ListItems extends StatefulWidget {
  const ListItems({Key key, this.todolist}) : super(key: key);

  final Todolist todolist;

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  List<TodoListItems> _todolistItems = <TodoListItems>[];

  Future<void> _getTodolistItems(BuildContext buildContext) async {
    var result = await buildContext
        .read<HomeBloc>()
        .repository
        .getTodoListByItems(widget.todolist.id);
    result.when(success: (List<TodoListItems> response) {
      if (response != null) {
        setState(() {
          _todolistItems = response;
        });
      }
    }, failure: (NetworkExceptions error) {
      Toaster.error(context: buildContext, error: error);
    });
  }

  @override
  void didChangeDependencies() {
    if (widget.todolist.id != null) {
      _getTodolistItems(context);
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.todolist.id == null) {
      return Center();
    } else {
      return Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: kSecondaryColor,
        ),
        child: Column(
          children: [
            Text(
              widget.todolist.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Items: ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            _listitemsContainer(context, _todolistItems),
          ],
        ),
      );
    }
  }

  _listitemsContainer(
      BuildContext buildContext, List<TodoListItems> todolistItems) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: todolistItems.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemContainer(buildContext, todolistItems[index], index);
        });
  }

  _itemContainer(BuildContext buildContext, TodoListItems item, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Row(
        children: [
          Checkbox(value: false, onChanged: null),
          Column(
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              Text(
                item.description,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: null,
                icon: FaIcon(
                  FontAwesomeIcons.minusCircle,
                  color: kPrimaryColor,
                  size: 26,
                ),
              ),
              Text(
                item.count.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: FaIcon(
                  FontAwesomeIcons.plusCircle,
                  color: kPrimaryColor,
                  size: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
