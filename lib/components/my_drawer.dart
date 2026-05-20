import 'package:flutter/material.dart';
import 'package:songweb/pages/home_page.dart';
import 'package:songweb/pages/settings_pages.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // LOGO
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,

                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // HOME TITLE
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              ),
            ),
          ),

          //SETTINGS  TITLE
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 0.0),
            child: ListTile(
              title: const Text('S E T T I N G S'),
              leading: const Icon(Icons.settings),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                //navigate to setting page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
