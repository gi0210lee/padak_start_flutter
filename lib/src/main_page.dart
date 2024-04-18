import "package:flutter/material.dart";
import "package:flutter_application_1/src/grid_page.dart";
import "package:flutter_application_1/src/list_page.dart";

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Movie'),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.sort),
              onSelected: (value) {
                if (value == 0)
                  print('예매율순');
                else if (value == 1)
                  print('큐레이션');
                else
                  print('최신순');
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(value: 0, child: Text("예매율순")),
                  const PopupMenuItem(value: 1, child: Text("큐레이션")),
                  const PopupMenuItem(value: 2, child: Text("최신순")),
                ];
              })
        ],
      ),
      body: _buildPage(_selectedTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: 'List', icon: Icon(Icons.view_list)),
          BottomNavigationBarItem(label: 'Grid', icon: Icon(Icons.grid_on)),
        ],
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
            print("$_selectedTabIndex TabClicked");
          });
        },
      ),
    );
  }
}

Widget _buildPage(index) {
  if (index == 0) {
    return ListPage();
  } else {
    return GridPage();
  }
}
