import 'package:flutter/material.dart';

import 'components/body.dart';

class WareHouseScreen extends StatelessWidget {
  final String warehouseIdToEdit;

  const WareHouseScreen({Key key, this.warehouseIdToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(warehouseIdToEdit: warehouseIdToEdit),
    );
  }
}
