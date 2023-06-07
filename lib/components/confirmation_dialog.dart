import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/stratagem.dart';
import '../providers/changes_provider.dart';

enum ActionButtonType { apply, discard, delete, triple }

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<String> affectedGems;
  final ActionButtonType actionButtonType;
  final Stratagem stratagem;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.affectedGems,
    required this.actionButtonType,
    required this.stratagem,
  }) : super(key: key);

// For delete function
// context.read<ChangesObserver>().addDeleteToList(stratagem);

// For discard
// context.read<ChangesObserver>().discardChanges();

  void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void deleteStratagem(BuildContext context, Stratagem stratagem) {
    context.read<ChangesObserver>().addDeleteToList(stratagem);
    closeDialog(context);
  }

  void discardAll(BuildContext context) {
    context.read<ChangesObserver>().discardChanges();
    closeDialog(context);
  }

  renderAnctionButtons(ActionButtonType actionButtonType, BuildContext context) {
    switch (actionButtonType) {
      case ActionButtonType.apply:
        return [
          TextButton(onPressed: () => closeDialog(context), child: Text("Cancel")),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: null,
              child: Text(
                "Apply",
                style: TextStyle(color: Colors.white),
              )),
        ];
      case ActionButtonType.delete:
        return [
          TextButton(onPressed: () => closeDialog(context), child: Text("Cancel")),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
              ),
              onPressed: () => deleteStratagem(context, stratagem),
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              )),
        ];
      case ActionButtonType.discard:
        return [
          TextButton(onPressed: () => closeDialog(context), child: Text("Cancel")),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
              ),
              onPressed: () => discardAll(context),
              child: Text(
                "Discard",
                style: TextStyle(color: Colors.white),
              )),
        ];
      case ActionButtonType.triple:
        return [
          TextButton(onPressed: () => closeDialog(context), child: Text("Cancel")),
          ElevatedButton(onPressed: null, child: Text("Discard")),
          ElevatedButton(onPressed: null, child: Text("Apply")),
        ];
      default:
        return [
          TextButton(onPressed: () => closeDialog(context), child: Text("Cancel")),
          ElevatedButton(onPressed: null, child: Text("Save")),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: Text(description),
          ),
          SizedBox(height: 32),
          Column(
            children: [Text("Add List here...")],
          )
        ],
      ),
      actions: renderAnctionButtons(actionButtonType, context),
      actionsAlignment: actionButtonType == ActionButtonType.triple ? MainAxisAlignment.spaceAround : MainAxisAlignment.end,
    );
  }
}
