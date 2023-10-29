import 'package:bbs_task/localDatabase/dbHelper.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Model/DocumentModel.dart';

part 'new_document_state.dart';

class NewDocumentCubit extends Cubit<NewDocumentState> {
  DbHelper dbHelper=DbHelper();
  NewDocumentCubit() : super(NewDocumentInitial());
  List<SingleItem> itemList = [];

  barcodeQuery(String barcode)async {
  return await  dbHelper.barcodeQuery(barcode);
  }

  void addToItemList(SingleItem singleItem) {
    itemList.add(singleItem);
    emit(ItemAddedState());
  }

  Future insertInTables(List<Map<String, dynamic>> itemsMapList, int documentNo, String time) async{
  await  dbHelper.insertInTables(itemsMapList, documentNo, time);
  }

 Future <int> documentQuery() async{
    int? newDocumentNo;

  var documentQuery = await  dbHelper.documentQuery();
  if (documentQuery.isEmpty) {
    return 1;
  }else{
    documentQuery.forEach((doc) {
      int documentNo = StockModel.getStock(doc).documentNo!;
     newDocumentNo = documentNo + 1;     });
    return newDocumentNo!;
  }

}}
