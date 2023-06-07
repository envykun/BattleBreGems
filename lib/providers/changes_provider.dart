import 'package:battle_bre_gems/models/stratagem.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class ChangesObserver with ChangeNotifier {
  List<Stratagem> _changeGems = [];
  List<Stratagem> _createGems = [];
  List<Stratagem> _finalList = [];

  bool get hasChanges => _createGems.length > 0 || _changeGems.length > 0;
  int get changesCount => _changeGems.length + _createGems.length;
  int get elementCount => _finalList.length;
  List<Stratagem> get changes => _changeGems;
  List<Stratagem> get finalList => _finalList;

  void addChangeToList(Stratagem stratagem) {
    if (_changeGems.any((element) => element.uuid == stratagem.uuid)) {
      _changeGems[_changeGems.indexWhere((element) => element.uuid == stratagem.uuid)] = stratagem;
    } else {
      _changeGems.add(stratagem);
    }
    inspect(_changeGems);
    notifyListeners();
  }

  void undoChange(Stratagem stratagem) {
    _changeGems.removeWhere((element) => element.uuid == stratagem.uuid);
    notifyListeners();
  }

  void addCreateToList(Stratagem stratagem) {
    _createGems.add(stratagem);
    notifyListeners();
  }

  void updateCreateList(Stratagem stratagem) {
    inspect(stratagem);
    inspect(_createGems);
    _createGems[_createGems.indexWhere((element) => element.uuid == stratagem.uuid)] = stratagem;
    notifyListeners();
  }

  void undoCreate(Stratagem stratagem) {
    _createGems.removeWhere((element) => element.uuid == stratagem.uuid);
    notifyListeners();
  }

  void addDeleteToList(Stratagem stratagem) {
    Stratagem gemToDelete = new Stratagem(
      uuid: stratagem.uuid,
      title: stratagem.title,
      type: stratagem.type,
      cost: stratagem.cost,
      lore: stratagem.lore,
      description: stratagem.description,
      tag: CrudTag.delete,
    );
    if (!_changeGems.any((element) => (element.uuid == stratagem.uuid && element.tag == gemToDelete.tag))) {
      addChangeToList(gemToDelete);
    }
  }

  void undoDelete(Stratagem stratagem) {
    _changeGems.removeWhere((element) => element.uuid == stratagem.uuid);
    notifyListeners();
  }

  void discardChanges() {
    _changeGems = [];
    _createGems = [];
    notifyListeners();
  }

  initializeList(List<Stratagem> data) {
    _finalList = data;
    notifyListeners();
  }

  getFinalList(List<Stratagem> data) {
    List<Stratagem> tempList = [...data];
    if (_changeGems.length > 0) {
      _changeGems.forEach((a) {
        tempList[tempList.indexWhere((element) => element.uuid == a.uuid)] = a;
      });
    }
    if (_createGems.length > 0) {
      tempList.addAll(_createGems);
    }
    _finalList = tempList;
    return tempList;
  }
}

// TODO: Implement CRUD 

// DELETE LIST

// UPDATE LIST
