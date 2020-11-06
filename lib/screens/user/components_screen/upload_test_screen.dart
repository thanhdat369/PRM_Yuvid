import 'package:flutter/material.dart';

class UploadScreenTest extends StatelessWidget {
  const UploadScreenTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.add_a_photo),
        onPressed: upload_click,
      ),
    );
  }

  void upload_click() {
    print("hello");
  }
}
