import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eAgric_admin/helpers/costants.dart';
import 'package:eAgric_admin/models/user.dart';

class UserServices {
  String adminsCollection = "admins";
  String usersCollection = "Farmer";

  void createAdmin({
    String id,
    String name,
    String email,
  }) {
    firebaseFiretore.collection(adminsCollection).doc(id).set({
      "name": name,
      "id": id,
      "email": email,
    });
  }

  void updateUserData(Map<String, dynamic> values) {
    firebaseFiretore
        .collection(adminsCollection)
        .doc(values['id'])
        .update(values);
  }

  Future<UserModel> getAdminById(String id) =>
      firebaseFiretore.collection(adminsCollection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  Future<List<UserModel>> getAllUsers() async =>
      firebaseFiretore.collection(usersCollection).get().then((result) {
        List<UserModel> users = [];
        for (DocumentSnapshot user in result.docs) {
          users.add(UserModel.fromSnapshot(user));
        }
        print(users);
        return users;
      });
}
