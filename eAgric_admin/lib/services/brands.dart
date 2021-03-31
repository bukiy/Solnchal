import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eAgric_admin/helpers/costants.dart';
import 'package:eAgric_admin/models/brands.dart';

class MachinesServices {
  String collection = "Machines";

  Future<List<MachineModel>> getAll() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<MachineModel> machines = [];
        for (DocumentSnapshot brand in result.docs) {
          machines.add(MachineModel.fromSnapshot(brand));
        }
        return machines;
      });
}
