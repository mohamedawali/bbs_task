import 'package:bbs_task/cubit/inventoryCubit/inventory_cubit.dart';
import 'package:bbs_task/localDatabase/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/DocumentModel.dart';


class Inventory extends StatelessWidget {
  Inventory({super.key});

  List<ItemModel>? item;
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController= TextEditingController();
  TextEditingController priceController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    var inventoryCubit = BlocProvider.of<InventoryCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: Text('Barcode')),
                Expanded(
                  child: TextField(
                    onSubmitted: (barcode) async{
                   item = await  inventoryCubit.queryByBarcode(barcode);
                   nameController.text = item![0].itemName.toString();
                   priceController.text = item![0].itemPrice.toString();
                   quantityController.text = item![0].itemQuantity.toString();
                    },
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text('Name')),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text('Price')),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text('Quantity')),
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


}
