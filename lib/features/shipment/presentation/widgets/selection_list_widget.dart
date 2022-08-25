import 'package:flutter/material.dart';
import '../../domain/entities/shipment_entity.dart';

import '../../../../core/utils/list_item.dart';

class SelectionListWidget extends StatelessWidget {
  final List<ShipmentEntity> shipments;
  const SelectionListWidget({
    required this.shipments,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: shipments.length,
      itemBuilder: (context, index) => ListItem(
        title: shipments[index].name,
        leading: shipments[index].shipmentId,
        ),
    );
  }
}

