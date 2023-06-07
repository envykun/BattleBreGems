import 'package:battle_bre_gems/providers/changes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/stratagem.dart';
import 'confirmation_dialog.dart';

class SideBar extends StatefulWidget {
  final Function selectedFactionCallback;
  const SideBar({Key? key, required this.selectedFactionCallback}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    super.initState();
  }

  List armies = [
    {
      "name": "Imperium",
      "factions": [
        "Adeptus Custodes",
        "Adepta Sororitas",
        "Adeptus Mechanicus",
        "Astra Militarum",
        "Imperial Knights",
      ]
    },
    {
      "name": "Chaos",
      "factions": [
        "Chaos Space Marines",
        "Death Guard",
        "Thousand Sons",
        "Chaos Knights",
        "Chaos Daemons",
      ]
    },
    {
      "name": "Xenos",
      "factions": [
        "Leagues of Votann",
        "Aeldari",
        "Drukhari",
        "Necrons",
        "T'au Empire",
        "Tyranids",
        "Genestealer Cults",
        "Orks",
      ]
    },
    {
      "name": "Space Marines",
      "factions": [
        "Adeptus Astartes",
        "Black Templars",
        "Blood Angels",
        "Dark Angels",
        "Deathwatch",
        "Grey Knights",
        "Imperial Fists",
        "Iron Hands",
        "Raven Guards",
        "Salamanders",
        "Space Wolves",
        "Ultramarines",
        "White Scars",
      ]
    }
  ];

  getArmyToExpansionTile(List armies) {
    return armies
        .map(
          (army) => ExpansionTile(
            title: Text(army["name"]),
            subtitle: Text("Lastly modified: 20. September 2022"),
            children: getFactionsToTile(army["factions"]),
          ),
        )
        .toList();
  }

  getFactionsToTile(List factions) {
    return factions.map((faction) {
      String imageUrl = faction.replaceAll(" ", "_");
      return ListTile(
        title: Text(faction),
        subtitle: Text(
          "Lastly modified: 20. September 2022",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        ),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image(
              image: AssetImage(checkIfImageAvailable(imageUrl) ? 'assets/icons/factions/$imageUrl.png' : 'assets/icons/factions/Adeptus_Custodes.png'),
            ),
          ),
        ),
        trailing: Text("24"),
        selected: selectedFaction == faction,
        selectedTileColor: Colors.blue,
        selectedColor: Colors.white,
        tileColor: Colors.grey[350],
        onTap: () => context.read<ChangesObserver>().hasChanges ? openDiscardOrApplyDialog() : handleSelectFaction(faction),
      );
    }).toList();
  }

  bool checkIfImageAvailable(String faction) {
    return factionIcons.contains(faction);
  }

  void handleSelectFaction(String faction) {
    widget.selectedFactionCallback(faction);
    selectedFaction = faction;
  }

  Future openDiscardOrApplyDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: "Unsaved changes!",
          description: "You have unsaved changes. Do you want to apply them to the database or discard them? Changes made to:",
          affectedGems: [],
          actionButtonType: ActionButtonType.triple,
          stratagem: new Stratagem(uuid: "uuid", title: "title", type: "type", cost: "", lore: "lore", description: "description", tag: CrudTag.delete),
        );
      },
    );
  }

  String selectedFaction = '';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      elevation: 10,
                      child: Image.asset(
                        'assets/icons/BattleBreGemsIcon.png',
                        width: 96,
                        height: 96,
                      ),
                    ),
                    Text(selectedFaction),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: getArmyToExpansionTile(armies),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
