import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sinlist_app/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinlist_app/core/http/network_exceptions.dart';
import 'package:sinlist_app/data/lists/todolist.dart';
import 'package:sinlist_app/data/lists/todolist_items.dart';
import 'package:sinlist_app/pages/constants.dart';
import 'package:sinlist_app/pages/widgets/general_button.dart';
import 'package:sinlist_app/pages/widgets/general_input_field.dart';
import 'package:sinlist_app/pages/widgets/toaster.dart';

class ListItems extends StatefulWidget {
  const ListItems({Key key, this.todolist, this.todolistItems})
      : super(key: key);
  final String routeName = "/list_items";

  final Todolist todolist;
  final List<TodoListItems> todolistItems;

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  GlobalKey<FormState> todoItemCreateFormKey = new GlobalKey<FormState>();
  TodoListItems _createListItem = new TodoListItems();

  bool validateAndSave() {
    final form = todoItemCreateFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _addTodolistItem(BuildContext buildContext,TodoListItems _todoListItem) async {
    if (validateAndSave()) {
      _todoListItem.todoListId = widget.todolist.id;
      _todoListItem.id = 0;
      var result = await buildContext
          .read<HomeBloc>()
          .repository
          .addTodolistItem(_todoListItem);
      result.when(success: (TodoListItems response) {
        if (response != null) {
          setState(() {
            _todoListItem = response;
          });
        }
      }, failure: (NetworkExceptions error) {
        Toaster.error(context: buildContext, error: error);
      });
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void didChangeDependencies() {
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
        child: Container(
          margin: EdgeInsets.only(bottom: 20, top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.todolist.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Items: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _listitemsContainer(context, widget.todolistItems),
              Expanded(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: RoundedButton(
                      color: kPrimaryColor,
                      text: "Add Item",
                      key: Key("AddItemButton"),
                      textColor: Colors.white,
                      press: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('AlertDialog Title'),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter _setState) {
                              return _addListItemPopUpContent(
                                  context, _setState);
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                _addTodolistItem(context, _createListItem);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
      margin: EdgeInsets.only(left: 10, right: 5, bottom: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: null),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          Spacer(),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        item.count == 0 ? item.count=0 : item.count--;
                      });
                    },
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
                    onPressed: () {
                      setState(() {
                        item.count++;
                      });
                    },
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
        ],
      ),
    );
  }

  _addListItemPopUpContent(BuildContext buildContext, StateSetter _setState) {
    return SingleChildScrollView(
      child: new Form(
        key: todoItemCreateFormKey,
        child: Column(
          children: [
            GeneralInputField(
              key: Key("listItemName"),
              hintText: "Item Name",
              validator: (val) =>
              val.isEmpty ? 'Item name is required' : null,
              onSaved: (val) => _createListItem.name = val,
            ),
            SizedBox(height: 5),
            GeneralInputField(
              key: Key("listItemDescription"),
              hintText: "Item Description",
              validator: (val) =>
              val.isEmpty ? 'Item Description is required' : null,
              onSaved: (val) => _createListItem.description = val,
            ),
            SizedBox(height: 5),
            GeneralInputField(
              key: Key("listItemCount"),
              hintText: "Item Count",
              inputType: TextInputType.number,
              validator: (val) =>
              val.isEmpty ? 'Item Count is required' : null,
              onSaved: (val) => val != "" ?  _createListItem.count = int.parse(val) : _createListItem.count = 0,
            ),
          ],
        ),
      ),
    );
  }
}
