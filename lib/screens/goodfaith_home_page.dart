import 'package:flutter/material.dart';
import 'package:good_faith/providers/goodfaith_page_provider.dart';
import 'package:good_faith/screens/borrow_request_page.dart';
import 'package:good_faith/screens/lend_list_page.dart';
import 'package:near_api_flutter/near_api_flutter.dart';
import 'package:provider/provider.dart';

class GoodFaithPage extends StatefulWidget {
  final KeyPair keyPair;
  final String userAccountId;

  const GoodFaithPage(
      {Key? key, required this.keyPair, required this.userAccountId})
      : super(key: key);

  @override
  State<GoodFaithPage> createState() => _GoodFaithPageState();
}

class _GoodFaithPageState extends State<GoodFaithPage>
    with WidgetsBindingObserver {
  late GoodFaithProvider provider;

  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = <Widget>[
    LendListPage(keyPair: widget.keyPair, userAccountId: widget.userAccountId),
    BorrowRequestPage(
      keyPair: widget.keyPair,
      userAccountId: widget.userAccountId,
    )
  ];

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<GoodFaithProvider>(context);
    return buildCoinflipPage();
  }

  buildCoinflipPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Good Faith - ${widget.userAccountId}"),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.deepOrange),
            onPressed: () {
              provider.logout();
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Lend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_quote),
            label: 'Request',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
