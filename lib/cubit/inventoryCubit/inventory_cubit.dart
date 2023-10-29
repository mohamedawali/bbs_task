import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Model/DocumentModel.dart';
import '../../localDatabase/dbHelper.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit() : super(InventoryInitial());
  DbHelper dbHelper = DbHelper();

  Future<List<ItemModel>> queryByBarcode(String barcode) async {
    var queryItem = await dbHelper.queryByBarcode(barcode);
  return queryItem.map((item) => ItemModel.getItem(item)).toList();
  }
}
