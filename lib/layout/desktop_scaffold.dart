import 'package:battle_bre_gems/components/sidebar.dart';
import 'package:battle_bre_gems/components/stratagem_card.dart';
import 'package:battle_bre_gems/components/stratagem_drawer.dart';
import 'package:battle_bre_gems/models/stratagem.dart';
import 'package:battle_bre_gems/providers/changes_provider.dart';
import 'package:battle_bre_gems/providers/edit_gem_provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/confirmation_dialog.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

final buttonColors = WindowButtonColors(
  iconNormal: const Color(0xFF805306),
  mouseOver: const Color(0xFFF6A00C),
  mouseDown: const Color(0xFF805306),
  iconMouseOver: const Color(0xFF805306),
  iconMouseDown: const Color(0xFFFFD500),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: const Color(0xFF805306),
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

List<DriveResponse> allStratagems = [
  new DriveResponse(
    "Adeptus Custodes",
    "1.0.0",
    "Henry Arschpirat",
    "Some Date",
    "Some Date",
    [
      new Stratagem(
        uuid: "adfafa01-d7f3-4209-aa0d-fef46deb33fe",
        title: "ETERNAL PENITENT",
        type: "Adeptus Custodes – Requisition Stratagem",
        cost: "1",
        cost2: "",
        lore: "Custodians tainted by dishonour seek penance through voluntary entombment in a Dreadnought's sarcophagus.",
        description: "Use this Stratagem before the battle, when you are mustering your army. Select one ADEPTUS CUSTODES DREADNOUGHT unit from your army.",
        descriptionList: [],
        descriptionEnd: "",
        tag: CrudTag.vanilla,
      ),
      new Stratagem(
        uuid: "adfafa01-d7f3-4209-aa0d-fef46deb33f2",
        title: "ETERNAL PENITENT 2",
        type: "Adeptus Custodes – Requisition Stratagem",
        cost: "1",
        cost2: "",
        lore: "Custodians tainted by dishonour seek penance through voluntary entombment in a Dreadnought's sarcophagus.",
        description: "Use this Stratagem before the battle, when you are mustering your army. Select one ADEPTUS CUSTODES DREADNOUGHT unit from your army.",
        descriptionList: [],
        descriptionEnd: "",
        tag: CrudTag.vanilla,
      ),
      new Stratagem(
        uuid: "adfafa01-d7f3-4209-aa0d-fef46deb33f3",
        title: "ETERNAL PENITENT 3",
        type: "Adeptus Custodes – Requisition Stratagem",
        cost: "1",
        cost2: "",
        lore: "Custodians tainted by dishonour seek penance through voluntary entombment in a Dreadnought's sarcophagus.",
        description: "Use this Stratagem before the battle, when you are mustering your army. Select one ADEPTUS CUSTODES DREADNOUGHT unit from your army.",
        descriptionList: [],
        descriptionEnd: "",
        tag: CrudTag.vanilla,
      ),
      new Stratagem(
        uuid: "adfafa01-d7f3-4209-aa0d-fef46deb33f4",
        title: "ETERNAL PENITENT 4",
        type: "Adeptus Custodes – Requisition Stratagem",
        cost: "1",
        cost2: "",
        lore: "Custodians tainted by dishonour seek penance through voluntary entombment in a Dreadnought's sarcophagus.",
        description: "Use this Stratagem before the battle, when you are mustering your army. Select one ADEPTUS CUSTODES DREADNOUGHT unit from your army.",
        descriptionList: [],
        descriptionEnd: "",
        tag: CrudTag.vanilla,
      ),
      new Stratagem(
        uuid: "adfafa01-d7f3-4209-aa0d-fef46deb33f5",
        title: "ETERNAL PENITENT 5",
        type: "Adeptus Custodes – Requisition Stratagem",
        cost: "1",
        cost2: "",
        lore: "Custodians tainted by dishonour seek penance through voluntary entombment in a Dreadnought's sarcophagus.",
        description: "Use this Stratagem before the battle, when you are mustering your army. Select one ADEPTUS CUSTODES DREADNOUGHT unit from your army.",
        descriptionList: [],
        descriptionEnd: "",
        tag: CrudTag.vanilla,
      ),
      new Stratagem(
        uuid: "adfafa01-d7f3-4209-aa0d-fef46deb33f6",
        title: "ETERNAL PENITENT 6",
        type: "Adeptus Custodes – Requisition Stratagem",
        cost: "1",
        cost2: "",
        lore: "Custodians tainted by dishonour seek penance through voluntary entombment in a Dreadnought's sarcophagus.",
        description: "Use this Stratagem before the battle, when you are mustering your army. Select one ADEPTUS CUSTODES DREADNOUGHT unit from your army.",
        descriptionList: [],
        descriptionEnd: "",
        tag: CrudTag.vanilla,
      ),
    ],
  ),
];

class _DesktopScaffoldState extends State<DesktopScaffold> {
  String selectedFaction = "";
  DialogType drawerType = DialogType.create;
  late TextEditingController _searchGemsController;

  void openEditDialog(BuildContext context, Stratagem stratagem) {
    context.read<EditGem>().setStratagem(stratagem);
    context.read<EditGem>().setCreateOrEdit(DialogType.edit);
    Scaffold.of(context).openEndDrawer();
  }

  Future openDeleteDialog(Stratagem stratagem) {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: "Do you really want to delete ${stratagem.title}?",
          description: "Do you really want to delete this Stratagem. It will be marked to delete. You have to press 'Save Changes' to apply it to the Database.",
          affectedGems: [],
          actionButtonType: ActionButtonType.delete,
          stratagem: stratagem,
        );
      },
    );
  }

  void undoCreate(Stratagem stratagem) {
    context.read<ChangesObserver>().undoCreate(stratagem);
  }

  void setSelectedFactionCallback(String faction) {
    setState(() {
      selectedFaction = faction;
    });
  }

  renderStratagems(List<DriveResponse> data, String faction, String searchQuery) {
    List<DriveResponse> _filteredList = data.where((element) => element.name == faction).toList();
    if (_filteredList.length == 0) {
      return [
        Container(
          height: 200,
          child: Center(child: Text(faction != "" ? "No Stratagems for $faction." : "Select a Faction.")),
        )
      ];
    }
    List<Stratagem> _combinedList = context.watch<ChangesObserver>().getFinalList(_filteredList[0].data);
    List<Stratagem> _searchQueryList = _combinedList
        .where(
          (element) => searchQuery == ""
              ? true
              : (element.type.toLowerCase().contains(searchQuery) ||
                  element.cost.toLowerCase().contains(searchQuery) ||
                  element.title.toLowerCase().contains(searchQuery) ||
                  element.description.toLowerCase().contains(searchQuery)),
        )
        .toList();
    return _searchQueryList.length == 0
        ? [
            Container(
              height: 200,
              child: Center(child: Text("No Stratagems found for \"$searchQuery\"")),
            )
          ]
        : _searchQueryList
            .map(
              (stratGem) => StratagemCard(
                stratagem: stratGem,
                editCallback: openEditDialog,
                deleteCallback: stratGem.tag == CrudTag.create ? undoCreate : openDeleteDialog,
              ),
            )
            .toList();
  }

  String getSelectedVersion(List<DriveResponse> data, String faction) {
    List<DriveResponse> _filteredList = data.where((element) => element.name == faction).toList();
    if (_filteredList.length == 0) return "-";
    return _filteredList[0].version;
  }

  @override
  void initState() {
    super.initState();
    _searchGemsController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: StratagemDrawer(),
      body: Row(
        children: [
          SideBar(selectedFactionCallback: setSelectedFactionCallback),
          Expanded(
            child: Column(
              children: [
                Container(
                  child: WindowTitleBarBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: MoveWindow()),
                        const WindowButtons(),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    children: [
                      TopBar(
                        searchGemsController: _searchGemsController,
                        selectedFaction: selectedFaction,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8.0),
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: renderStratagems(allStratagems, selectedFaction, _searchGemsController.text.toLowerCase()),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
                  child: FooterBar(
                    version: getSelectedVersion(allStratagems, selectedFaction),
                    elementCount: context.read<ChangesObserver>().elementCount,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// TOPBAR
class TopBar extends StatefulWidget {
  final TextEditingController searchGemsController;
  final String selectedFaction;
  const TopBar({Key? key, required this.searchGemsController, required this.selectedFaction}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

const List<String> list = <String>['Order By', 'Two', 'Three', 'Four'];

// TOPBAR STATE
class _TopBarState extends State<TopBar> {
  // List<bool> isSelected = [false, true];
  // List<DropdownMenuItem<String?>> dropdownItems = const [
  //   DropdownMenuItem(
  //     child: Text("Name"),
  //     value: "Name",
  //   )
  // ];
  // String dropdownValue = list.first;

  void openCreateDrawer() {
    context.read<EditGem>().setCreateOrEdit(DialogType.create);
    Scaffold.of(context).openEndDrawer();
  }

  Future openSaveChangesDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: "Apply changes to Database",
          description: "Do you really want to apply the changes to the Database?. This will add, change and/or delete these Stratagems:",
          affectedGems: [],
          actionButtonType: ActionButtonType.apply,
          stratagem: new Stratagem(
            uuid: "uuid",
            title: "title",
            type: "type",
            cost: "cost",
            lore: "lore",
            description: "description",
            tag: CrudTag.delete,
          ),
        );
      },
    );
  }

  Future openDiscardChangesDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: "Discard changes?",
          description: "Do you really want to discard all changes?. This will undo following temporary changes:",
          affectedGems: [],
          actionButtonType: ActionButtonType.discard,
          stratagem: new Stratagem(
            uuid: "uuid",
            title: "title",
            type: "type",
            cost: "cost",
            lore: "lore",
            description: "description",
            tag: CrudTag.delete,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SizedBox(
                          width: 280,
                          child: TextField(
                            controller: widget.searchGemsController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search ...",
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 20),
                    // FUTURE: Sort function
                    // DropdownButton<String>(
                    //   value: dropdownValue,
                    //   icon: const Icon(Icons.arrow_downward),
                    //   elevation: 16,
                    //   borderRadius: BorderRadius.circular(8),
                    //   onChanged: (String? value) {
                    //     // This is called when the user selects an item.
                    //     setState(() {
                    //       dropdownValue = value!;
                    //     });
                    //   },
                    //   items: list.map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    // ),
                    // SizedBox(width: 24),
                    // FUTURE: Switch between Cardview and Listview
                    // ToggleButtons(
                    //   children: [Icon(Icons.list), Icon(Icons.check_box_outline_blank)],
                    //   isSelected: isSelected,
                    //   borderWidth: 1,
                    //   borderRadius: BorderRadius.circular(8),
                    //   onPressed: (index) {
                    //     setState(() {
                    //       for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                    //         if (buttonIndex == index) {
                    //           isSelected[buttonIndex] = true;
                    //         } else {
                    //           isSelected[buttonIndex] = false;
                    //         }
                    //       }
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
              Row(
                children: [
                  context.watch<ChangesObserver>().hasChanges
                      ? Row(
                          children: [
                            IconButton(
                              tooltip: "Undo",
                              icon: Icon(Icons.undo),
                              onPressed: openDiscardChangesDialog,
                              splashRadius: 24,
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: openSaveChangesDialog,
                              child: Text("Save changes (${context.watch<ChangesObserver>().changesCount})"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "No changes.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  SizedBox(width: 30),
                  IconButton(
                    tooltip: "Add Stratagem",
                    icon: Icon(Icons.add),
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      hoverColor: Colors.blue[700],
                      highlightColor: Colors.blue[900],
                    ),
                    onPressed: widget.selectedFaction == "" ? null : openCreateDrawer,
                    splashRadius: 24,
                  ),
                  SizedBox(width: 30),
                  PopupMenuButton(
                    tooltip: "More actions",
                    splashRadius: 16,
                    icon: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
                        ),
                      ),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          return;
                        case 'delete':
                          return;
                        default:
                          throw UnimplementedError();
                      }
                    },
                    itemBuilder: (c) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text("Settings"),
                        value: 'settings',
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                        child: Text("Logout"),
                        value: 'logout',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FOOTER
class FooterBar extends StatelessWidget {
  final String version;
  final int elementCount;
  const FooterBar({Key? key, required this.version, required this.elementCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Version: $version"), Text("$elementCount Elements")],
          ),
        ),
      ],
    );
  }
}
