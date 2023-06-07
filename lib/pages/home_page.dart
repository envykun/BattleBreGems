import 'package:battle_bre_gems/layout/responsive_layout.dart';
import 'package:battle_bre_gems/layout/mobile_scaffold.dart';
import 'package:battle_bre_gems/layout/tablet_scaffold.dart';
import 'package:battle_bre_gems/layout/desktop_scaffold.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: const MobileScaffold(), tabletScaffold: const TabletScaffold(), desktopScaffold: const DesktopScaffold());
  }
}
