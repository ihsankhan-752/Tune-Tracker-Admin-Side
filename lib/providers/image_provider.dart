import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadingProvider extends ChangeNotifier {
  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  uploadImage(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      notifyListeners();
    }
  }

  deleteUploadImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
