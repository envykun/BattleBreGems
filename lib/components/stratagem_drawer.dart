import 'package:battle_bre_gems/components/preview_card.dart';
import 'package:battle_bre_gems/providers/changes_provider.dart';
import 'package:battle_bre_gems/providers/edit_gem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/stratagem.dart';

enum DialogType {
  create,
  edit,
}

class StratagemDrawer extends StatefulWidget {
  const StratagemDrawer({Key? key}) : super(key: key);

  @override
  State<StratagemDrawer> createState() => _StratagemDrawerState();
}

class _StratagemDrawerState extends State<StratagemDrawer> {
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _costController;
  late TextEditingController _costController2;
  late TextEditingController _loreController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: context.read<EditGem>().stratagem.title)
      ..addListener(() {
        setState(() {});
      });
    _typeController = TextEditingController(text: context.read<EditGem>().stratagem.type)
      ..addListener(() {
        setState(() {});
      });
    _costController = TextEditingController(text: context.read<EditGem>().stratagem.cost)
      ..addListener(() {
        setState(() {});
      });
    _costController2 = TextEditingController(text: context.read<EditGem>().stratagem.cost2)
      ..addListener(() {
        setState(() {});
      });
    _loreController = TextEditingController(text: context.read<EditGem>().stratagem.lore)
      ..addListener(() {
        setState(() {});
      });
    _descriptionController = TextEditingController(text: context.read<EditGem>().stratagem.description)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _costController.dispose();
    _costController2.dispose();
    _loreController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void createStratagem() {
    final Stratagem newStratagem = new Stratagem(
      uuid: Uuid().v4(),
      title: _nameController.text,
      type: _typeController.text,
      lore: _loreController.text,
      cost: _costController.text,
      cost2: _costController2.text,
      description: _descriptionController.text,
      descriptionList: [],
      descriptionEnd: "",
      tag: CrudTag.create,
    );
    context.read<ChangesObserver>().addCreateToList(newStratagem);
    context.read<EditGem>().resetStratagem();
    Scaffold.of(context).closeEndDrawer();
  }

  void updateStratagem() {
    final Stratagem newStratagem = new Stratagem(
      uuid: context.read<EditGem>().stratagem.uuid,
      title: _nameController.text,
      type: _typeController.text,
      lore: _loreController.text,
      cost: _costController.text,
      cost2: _costController2.text,
      description: _descriptionController.text,
      descriptionList: [],
      descriptionEnd: "",
      tag: context.read<EditGem>().crudTag == CrudTag.create ? CrudTag.create : CrudTag.update,
    );
    context.read<EditGem>().crudTag == CrudTag.create ? context.read<ChangesObserver>().updateCreateList(newStratagem) : context.read<ChangesObserver>().addChangeToList(newStratagem);
    context.read<EditGem>().resetStratagem();
    Scaffold.of(context).closeEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 500,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: context.read<EditGem>().createOrEdit == DialogType.create ? Text("Create a Stratagem for <FORCE TYPE>.") : Text("Edit <FORCE TYPE> Stratagem."),
          ),
          // Drawer Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StratagemPreview(
                    stratagem: new Stratagem(
                      uuid: '',
                      title: _nameController.text,
                      type: _typeController.text,
                      lore: _loreController.text,
                      cost: _costController.text,
                      cost2: _costController2.text,
                      description: _descriptionController.text,
                      descriptionList: [],
                      descriptionEnd: "",
                      tag: CrudTag.create,
                    ),
                  ),
                  StratagemForm(
                    nameController: _nameController,
                    typeController: _typeController,
                    costController: _costController,
                    costController2: _costController2,
                    loreController: _loreController,
                    descriptionController: _descriptionController,
                  ),
                ],
              ),
            ),
          ),
          // Drawer Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Scaffold.of(context).closeEndDrawer();
                    context.read<EditGem>().resetStratagem();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: context.read<EditGem>().createOrEdit == DialogType.create ? createStratagem : updateStratagem,
                  child: context.read<EditGem>().createOrEdit == DialogType.create ? Text("Create") : Text("Save"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StratagemForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController costController;
  final TextEditingController costController2;
  final TextEditingController loreController;
  final TextEditingController descriptionController;
  const StratagemForm({
    Key? key,
    required this.nameController,
    required this.costController,
    required this.costController2,
    required this.descriptionController,
    required this.loreController,
    required this.typeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Name",
                errorText: null,
                border: OutlineInputBorder(),
                hintText: "Name of the Stratagem ...",
              ),
              controller: nameController,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Flexible(
                  flex: 7,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Type",
                      errorText: null,
                      border: OutlineInputBorder(),
                      hintText: "Given type ...",
                    ),
                    controller: typeController,
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Cost",
                      errorText: null,
                      border: OutlineInputBorder(),
                      hintText: "CP",
                    ),
                    controller: costController,
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Cost 2",
                      errorText: null,
                      border: OutlineInputBorder(),
                      hintText: "CP",
                    ),
                    controller: costController2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: "Lore",
                errorText: null,
                border: OutlineInputBorder(),
                hintText: "Lore text ...",
              ),
              controller: loreController,
              maxLines: null,
            ),
            SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(hintText: "Description", labelText: "Description", errorText: "Das geht nicht weil du dumm bist, lel.", border: OutlineInputBorder()),
              controller: descriptionController,
              maxLines: null,
            ),
            SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: "",
                errorText: null,
                border: OutlineInputBorder(),
                hintText: "Unit Tags",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StratagemPreview extends StatelessWidget {
  final Stratagem stratagem;

  StratagemPreview({Key? key, required this.stratagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StratagemPreviewCard(stratagem: stratagem);
  }
}
