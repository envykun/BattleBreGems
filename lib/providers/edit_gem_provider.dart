import 'package:battle_bre_gems/components/stratagem_drawer.dart';
import 'package:battle_bre_gems/models/stratagem.dart';
import 'package:flutter/material.dart';

class EditGem with ChangeNotifier {
  Stratagem _stratagem = new Stratagem(
    uuid: '',
    cost: '',
    cost2: '',
    description: '',
    descriptionEnd: '',
    descriptionList: [],
    lore: '',
    tag: CrudTag.vanilla,
    title: '',
    type: '',
  );
  DialogType _createOrEdit = DialogType.create;
  bool _madeChanges = false;

  Stratagem get stratagem => _stratagem;
  CrudTag get crudTag => _stratagem.tag;
  DialogType get createOrEdit => _createOrEdit;
  bool get madeChanges => _madeChanges;

  void setStratagem(Stratagem stratagem) {
    _stratagem = stratagem;
  }

  void resetStratagem() {
    _stratagem = new Stratagem(
      uuid: '',
      cost: '',
      cost2: '',
      description: '',
      descriptionEnd: '',
      descriptionList: [],
      lore: '',
      tag: CrudTag.vanilla,
      title: '',
      type: '',
    );
  }

  void setCreateOrEdit(DialogType dialogType) {
    _createOrEdit = dialogType;
  }

  void checkForChanges(dynamic data1, dynamic data2) {
    if (data1 != data2) {
      _madeChanges = true;
    } else {
      _madeChanges = false;
    }
  }
}
