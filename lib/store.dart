import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore store = FirebaseFirestore.instance;

class storedata
{
  Future<String> adddata({
    required String sent,
})
  async{
    String result = "no data";
    try{
      await store.
      collection("senddata").
      doc("datas").
    set({'senditems':sent});
      result ="success";
    }
        catch(error){
      result= error.toString();
        }
    return result;
  }
}

// program file
// void sendget () async
// {
//   String s = _controller.text;
//   String st = await storedata().adddata(sent: s);
// }