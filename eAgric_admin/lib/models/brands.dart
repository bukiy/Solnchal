import 'package:cloud_firestore/cloud_firestore.dart';

class MachineModel {
  static const ID = "ID";
  static const CATEGORY = "CATEGORY";
  static const DESCRIPTION = "DESCRIPTION";
  static const NAME = "NAME";
  static const PICTURE = "PICTURE";
  static const AVAILABLE = "AVAILABLE";

  String _id;
  String _category;
  String _description;
  String _name;
  String _picture;
  bool _available;

//  getters
  String get category => _category;
  String get id => _id;
  String get description => _description;
  String get name => _name;
  String get picture => _picture;
  bool get available => _available;

  MachineModel.fromSnapshot(DocumentSnapshot snapshot) {
    _category = snapshot.data()[CATEGORY];
    _id = snapshot.data()[ID];
    _description = snapshot.data()[DESCRIPTION] ?? " ";
    _name = snapshot.data()[NAME];
    _picture = snapshot.data()[PICTURE];
    _available = snapshot.data()[AVAILABLE];
  }
}
