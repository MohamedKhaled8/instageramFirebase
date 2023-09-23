import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class CloudFireBaseStorge {
  getImgURL({
    required String imgName,
    required Uint8List imgPath,
  }) async {
    final storageRef = FirebaseStorage.instance.ref("profileIMG/$imgName");

    UploadTask uploadTask = storageRef.putData(imgPath);
    TaskSnapshot snap = await uploadTask;

    String urll = await snap.ref.getDownloadURL();

    return urll;
  }
}
