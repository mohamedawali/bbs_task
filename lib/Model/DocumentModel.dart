class SingleItem {

  int? itemPrice;

  String? itemName;
  int? itemQuantity;
  String? itemBareCode;
  SingleItem(this.itemName, this.itemQuantity,this.itemBareCode,this.itemPrice);
}
class ItemModel {

  String? itemName;
  String? itemBareCode;
  int? itemPrice;
  int? itemQuantity;

  ItemModel(
      {
      this.itemName,
      this.itemBareCode,
      this.itemPrice,
      this.itemQuantity});

  Map<String, dynamic> saveItem() {
    return {

      "ItemName": itemName,
      "ItemBareCode": itemBareCode,
      "ItemPrice": itemPrice,
      "ItemQuantity": itemQuantity,

    };
  }
  ItemModel.getItem(Map<String, dynamic>getMap){
   itemName=getMap['ItemName'];
   itemBareCode=getMap['ItemBareCode'];
   itemPrice=getMap['ItemPrice'];
   itemQuantity=getMap['ItemQuantity'];




 }

}
class StockModel {
  int ? documentNo;
  String? time;
  int? itemId;

  int? itemQuantity;

  StockModel(
  {this.documentNo,
          this.time,
          this.itemId,
          this.itemQuantity});

  Map<String, dynamic> saveStockRecord() {
      return {
        "DocumentNo": documentNo,
        "Time": time,

        "ItemId": itemId,
        "ItemQuantity": itemQuantity
      };
    }
  StockModel.getStock(Map<String, dynamic>getMap){
    documentNo=getMap['DocumentNo'];
    time=getMap['Time'];
    itemId=getMap['ItemId'];
    itemQuantity=getMap['ItemQuantity'];




  }

}
