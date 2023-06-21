// ignore_for_file: unnecessary_this

class Cart {
  int? id;
  int? qty;

  Cart({this.id, this.qty});
  Cart.fromMap(Map map)        // This Function helps to convert our Map into our User Object
      : this.id = map["id"],
        this.qty = map["qty"];

  Map toMap() {               // This Function helps to convert our User Object into a Map.
    return {
      "id": this.id,
      "qty": this.qty,
    };
  }
}