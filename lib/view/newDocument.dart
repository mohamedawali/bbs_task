import 'package:bbs_task/cubit/newDocumentCubit/new_document_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/DocumentModel.dart';


class NewDocument extends StatefulWidget {
  const NewDocument({super.key});

  @override
  State<NewDocument> createState() => _NewDocumentState();
}

class _NewDocumentState extends State<NewDocument> {

  NewDocumentCubit? documentCubit;
  TextEditingController documentController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: '1');
  TextEditingController barcodeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    documentCubit = BlocProvider.of<NewDocumentCubit>(context);

    checkDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Document'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(child: Text('Document No.')),
                Expanded(
                  child: TextField(
                    controller: documentController,
                    enabled: false,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Barcode'),
                      TextField(
                        controller: barcodeController,
                        decoration: const InputDecoration(
                            hintText: '123211', border: OutlineInputBorder()),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('name'),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: 'name', border: OutlineInputBorder()),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Qty'),
                      TextField(
                        controller: quantityController,
                        decoration: const InputDecoration(
                            //hintText: quantityController.value.text,
                            border: OutlineInputBorder()),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Price'),
                      TextField(
                        controller: priceController,
                        decoration: const InputDecoration(
                            hintText: '50', border: OutlineInputBorder()),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  var barcodeQuery = await documentCubit!
                      .barcodeQuery(barcodeController.value.text);
                  int quantity = int.parse(quantityController.value.text);
                  int price = int.parse(priceController.value.text);
                  if (barcodeQuery.isEmpty) {
                    if (documentCubit!.itemList.isEmpty) {
                      documentCubit!.addToItemList(SingleItem(
                          nameController.value.text,
                          quantity,
                          barcodeController.value.text,
                          price));
                    } else {
                      bool isExist = documentCubit!.itemList.any((element) =>
                          element.itemBareCode == barcodeController.value.text);

                      if (isExist) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("this item is exist"),
                        ));
                      } else {
                        documentCubit!.addToItemList(SingleItem(
                            nameController.value.text,
                            quantity,
                            barcodeController.value.text,
                            price));
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("this item is exist"),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                  size.width,
                  50,
                )),
                child: const Text('Add')),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: BlocBuilder<NewDocumentCubit, NewDocumentState>(
              builder: (context, state) {
                return ListView.builder(
                    itemCount: documentCubit!.itemList.length,
                    itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(documentCubit!.itemList[index].itemName
                                .toString()),
                            Text(documentCubit!.itemList[index].itemQuantity
                                .toString())
                          ],
                        ));
              },
            )),
            ElevatedButton(
                onPressed: () async {
                  var dateTime = DateTime.now();
                  int currentHour = dateTime.hour;
                  int currentMinute = dateTime.minute;
                  int currentSecond = dateTime.second;

                  String time = " $currentHour:$currentMinute:$currentSecond";
                  if (documentCubit!.itemList.isNotEmpty) {
                    List<Map<String, dynamic>> itemsMapList =
                        documentCubit!.itemList.map((item) {
                      return ItemModel(
                              itemName: item.itemName,
                              itemBareCode: item.itemBareCode,
                              itemQuantity: item.itemQuantity,
                              itemPrice: item.itemPrice)
                          .saveItem();
                    }).toList();

                    await documentCubit!
                        .insertInTables(itemsMapList,
                            int.parse(documentController.value.text), time)
                        .then((value) => Navigator.pop(context));
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                  size.width,
                  50,
                )),
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    documentCubit!.itemList.clear();
    super.dispose();
  }



  void checkDocument() async {
    var documentQuery = await documentCubit!.documentQuery();

    documentController .text=  documentQuery.toString();
  }
}
