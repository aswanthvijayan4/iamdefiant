import 'package:authentication_with_bloc/erp/Blocs/Master/Inventory/Items/List/inventoryitemslist_bloc.dart';
import 'package:authentication_with_bloc/erp/Database/Inventory/Masters/InventoryItemsDatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Screens/Masters/Inventory/InventoryItemEditor.dart';
import 'package:authentication_with_bloc/erp/Widgets/Drawer/GDrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class InventoryItemsListScreen extends StatelessWidget {
  const InventoryItemsListScreen({Key key}) : super(key: key);

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
      title: Text('Inventory Items'),
    );

    return GDrawer(
      child: BlocProvider(
        create: (context) =>
            InventoryItemsListBloc(InventoryItemsDBHelper())..add(LoadData()),
        child: InventoryItemsList(
          appBar: appBar,
        ),
      ),
    );
  }
}

class InventoryItemsList extends StatefulWidget {
  const InventoryItemsList({Key key, this.appBar}) : super(key: key);

  @override
  _InventoryItemsListState createState() => _InventoryItemsListState();
  final AppBar appBar;
}

class _InventoryItemsListState extends State<InventoryItemsList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  InventoryItemsListBloc _itemsListBloc;
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    print('Init Called');
    _itemsListBloc = BlocProvider.of<InventoryItemsListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _itemsListBloc.add(CreateEntityEvent());
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
    return BlocListener<InventoryItemsListBloc, InventoryItemsListState>(
      listener: (context, state) {
        if (state is EntityFetched) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: _itemsListBloc,
                      ),
                      BlocProvider(
                          create: (context) =>
                              InventoryItemsListBloc(InventoryItemsDBHelper())
                                ..add(LoadData())),
                    ],
                    child: InventoryItemEditor(
                      isEditing: true,
                      item: state.item,
                    ),
                  )));
        }
      },
      child: BlocBuilder<InventoryItemsListBloc, InventoryItemsListState>(
        builder: (context, state) {
          if (state is InventoryitemslistInitial) {
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
                return index < state.items.length
                    ? GroupListItemWidget(item: state.items[index])
                    : BottomLoader();
              },
              itemCount: state.hasReachedMax
                  ? state.items.length
                  : state.items.length + 1,
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

    // print('maxScroll : $maxScroll');
    // print('current : $currentScroll');
    if (maxScroll - currentScroll <= _scrollThreshold) {
      print('Load More...');
      _itemsListBloc.add(LoadData());
    }
  }

  void sendSearchEvent(String filter) {
    print('Keypressed : $filter');
    _itemsListBloc.add(SearchEvent(filter));
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
  final Map item;

  const GroupListItemWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color c2 = Color.fromRGBO(237, 244, 234, 1);
    // Color c1 = Color.fromRGBO(126, 38, 57, 1);

    // Color c1 = Color.fromRGBO(247, 248, 243, 1);
    // Color c2 = Color.fromRGBO(0, 44, 62, 1);

    double bevel = .2;
    InventoryItemsListBloc _itemsListBloc =
        BlocProvider.of<InventoryItemsListBloc>(context);
    return Container(
        child: Card(
            elevation: 10,
            child: Container(
              child: ListTile(
                // leading: CircleAvatar(
                //   backgroundColor: Colors.cyan,
                // ),
                title: Hero(
                  tag: 'hero-tag',
                  child: Text(
                    '${item['Name']}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Text(
                  item['2nd'] ?? "",
                  style: TextStyle(
                    fontSize: 14.0,
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
                  print('Clicked ${item['id']}');
                  // Open Group Editor with Navigator Bloc ? ? ?
                  _itemsListBloc.add(FetchEntityEvent(item['id']));
                },
                onLongPress: () {
                  // Open Group Editor with Navigator Bloc ? ? ?
                  print('Long Pressed ${item['2nd']}');
                },
              ),
            )));
  }
}
