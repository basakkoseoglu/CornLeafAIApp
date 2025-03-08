import 'package:bitki_hastalik_tani/components/bottom_nav_bar.dart';
import 'package:bitki_hastalik_tani/pages/herb_page.dart';
import 'package:bitki_hastalik_tani/pages/info_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HerbPage(),
    const InfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9F5DB),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(Icons.menu, color: Colors.black),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          )),
      drawer: Drawer(
        backgroundColor: Color(0xFFC7DBA8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //logo
                DrawerHeader(
                  child: Icon(
                    Icons.spa,
                    size: 100,
                    color: Color(0xFF97A97C),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.lightGreen,
                  ),
                ),

                //other pages
                const Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Color(0xFF97A97C),
                      size: 30,
                    ),
                    title: Text('Ana Sayfa',
                        style:
                            TextStyle(color: Color(0xFF97A97C), fontSize: 20)),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Color(0xFF97A97C),
                      size: 30,
                    ),
                    title: Text('Hakkında',
                        style:
                            TextStyle(color: Color(0xFF97A97C), fontSize: 20)),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Color(0xFF97A97C),
                  size: 30,
                ),
                title: Text('Çıkış Yap',
                    style: TextStyle(color: Color(0xFF97A97C), fontSize: 25)),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
