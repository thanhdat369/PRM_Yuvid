import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prm_yuvid/blocs/account/edit_avt/editavt_bloc.dart';
import 'package:prm_yuvid/screens/user/components_screen/user_screen_back_button.dart';

class EditAvtScreen extends StatelessWidget {
  const EditAvtScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditavtBloc(),
      child: EditAvtScreenChild(),
    );
  }
}

class EditAvtScreenChild extends StatefulWidget {
  EditAvtScreenChild({Key key}) : super(key: key);

  @override
  _EditAvtScreenChildState createState() => _EditAvtScreenChildState();
}

class _EditAvtScreenChildState extends State<EditAvtScreenChild> {
  EditavtBloc _editavtBloc;
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    _editavtBloc = BlocProvider.of<EditavtBloc>(context);
    return UserScreenBackButton(
      title: "Edit avt",
      child: BlocListener<EditavtBloc, EditavtState>(
        listener: (context, state) {
          if (state is EditavtSuccessState) {
            Navigator.pop(context);
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (_image != null)
                Image.file(_image)
              else
                Text(
                  "Click on Pick Image to select an Image",
                  style: TextStyle(fontSize: 18.0),
                ),
              RaisedButton(
                onPressed: () {
                  _pickImageFromGallery();
                  // or
                  // _pickImageFromCamera();
                  // use the variables accordingly
                },
                child: Text("Pick Image From Gallery"),
              ),
              RaisedButton(
                onPressed: _editAvt,
                child: Text("Update"),
              ),
              BlocBuilder<EditavtBloc, EditavtState>(
                builder: (context, state) {
                  if (state is EditavtLoadingState) {
                    return CircularProgressIndicator();
                  } else
                    return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pickImageFromGallery() async {
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image = File(pickedFile.path);

    setState(() {
      _image = image;
    });
  }

  _editAvt() {
    if (this._image != null) {
      this._editavtBloc.add(EditavtClickEvent(imageFile: this._image));
    }
  }
}
