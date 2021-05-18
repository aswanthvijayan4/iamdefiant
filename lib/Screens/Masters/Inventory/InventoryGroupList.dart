import 'package:authentication_with_bloc/Blocs/Master/Inventory/Groups/List/inventorygroups_bloc.dart';
import 'package:authentication_with_bloc/Database/Inventory/Masters/InventoryGroupsMasterDatabaseHelper.dart';
import 'package:authentication_with_bloc/Screens/Masters/Inventory/InventoryGroupEditor.dart';
import 'package:authentication_with_bloc/Widgets/Drawer/GDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryGroupListScreen extends StatelessWidget {
  const InventoryGroupListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => GDrawer.of(context).open(),
          );
        },
      ),
      title: Text('Inventory Groups'),
    );

    return GDrawer(
      child: BlocProvider(
        create: (context) =>
            InventorygroupsBloc(InventoryGroupDBHelper())..add(LoadData()),
        child: InventoryGroupList(
          appBar: appBar,
        ),
      ),
    );
  }
}

class InventoryGroupList extends StatefulWidget {
  const InventoryGroupList({Key key, this.appBar}) : super(key: key);

  @override
  _InventoryGroupListState createState() => _InventoryGroupListState();

  final AppBar appBar;
}

class _InventoryGroupListState extends State<InventoryGroupList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  InventorygroupsBloc _groupsBloc;
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    print('Init Called');
    _groupsBloc = BlocProvider.of<InventorygroupsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _groupsBloc.add(CreateEntityEvent());
            },
            child: Icon(Icons.add)),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _searchTextField(),
              ),
              Expanded(child: _buildList())
            ],
          ),
        ));
  }

  Widget _buildList() {
    return BlocListener<InventorygroupsBloc, InventorygroupsState>(
      listener: (context, state) {
        if (state is EntityFetched) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _groupsBloc,
                    child: InventoryGroupEditor(
                      isEditing: true,
                      group: state.group,
                    ),
                  )));
        }
      },
      child: BlocBuilder<InventorygroupsBloc, InventorygroupsState>(
        builder: (context, state) {
          if (state is InventorygroupsInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ListError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is ListLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'No Such Groups!!!',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return index > state.items.length
                    ? BottomLoader()
                    : GroupListItemWidget(group: state.items[index]);
              },
              itemCount: state.items.length - 1,
              controller: _scrollController,
            );
          } else {
            return Center(
              child: Text('Else Failed to fetch posts At Else'),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _groupsBloc.add(LoadData());
    }
  }

  void sendSearchEvent(String filter) {
    print('Keypressed : $filter');
    _groupsBloc.add(SearchEvent(filter));
  }

  Widget _searchTextField() {
    return TextField(
        onChanged: sendSearchEvent,
        controller: _searchTextController,
        decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            focusColor: Colors.black
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(25.0)))
            ));
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class GroupListItemWidget extends StatelessWidget {
  final Map group;

  const GroupListItemWidget({Key key, @required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color c2 = Color.fromRGBO(237, 244, 234, 1);
    Color c1 = Color.fromRGBO(126, 38, 57, 1);

    // Color c1 = Color.fromRGBO(247, 248, 243, 1);
    // Color c2 = Color.fromRGBO(0, 44, 62, 1);

    double bevel = .2;
    InventorygroupsBloc _groupsBloc =
        BlocProvider.of<InventorygroupsBloc>(context);
    return Container(
        color: c1,
        child: Card(
            elevation: 10,
            color: c2,
            child: Container(
              color: c1,
              child: ListTile(
                // leading: CircleAvatar(
                //   backgroundColor: Colors.cyan,
                // ),
                title: Text(
                  '${group['Name']}',
                  style: TextStyle(
                      fontSize: 18.0, color: c2, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  group['2nd'] ?? "",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: c2,
                  ),
                ),
                dense: true,
                trailing: IconButton(
                  icon: new Icon(Icons.view_headline),
                  onPressed: () {
                    print('Edit');
                  },
                ),
                onTap: () {
                  print('Clicked ${group['id']}');
                  // Open Group Editor with Navigator Bloc ? ? ?
                  _groupsBloc.add(FetchEntityEvent(group['id']));
                },
                onLongPress: () {
                  // Open Group Editor with Navigator Bloc ? ? ?
                  print('Long Pressed ${group['2nd']}');
                },
              ),
            )));
  }
}
