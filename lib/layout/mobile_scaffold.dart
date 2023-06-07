import 'package:battle_bre_gems/components/sidebar.dart';
import 'package:battle_bre_gems/components/stratagem_card.dart';
import 'package:flutter/material.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(),
      // drawer: SideBar(),
      body: Center(
        child: Column(
          children: [
            // const StratagemCard(),
            // const StratagemCard(),
            // const StratagemCard(),
          ],
        ),
      ),
    );
  }
}
