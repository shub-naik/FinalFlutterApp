import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:toast/toast.dart';

class CameraDiseasePredictionTab extends StatefulWidget {
  @override
  _CameraDiseasePredictionTabState createState() =>
      _CameraDiseasePredictionTabState();
}

class _CameraDiseasePredictionTabState
    extends State<CameraDiseasePredictionTab> {
  // Image Upload Functions Starts here

// To store the file provided by the image_picker
  File _imageFile;

  // To track the file uploading state
  bool _isUploading = false;
  bool _showDiseaseDataBoolean = false;

  String baseUrl = 'http://08a3cec33497.ngrok.io/predict';

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = image;
    });

    // Closes the bottom sheet
    Navigator.pop(context);
  }

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    print('Uploading');

    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');

    // Intilize the multipart request
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(baseUrl));

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('plant_image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.fields['ext'] = mimeTypeData[1];
    imageUploadRequest.files.add(file);

    try {
      final streamedResponse = await imageUploadRequest.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        return null;
      }
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);

      return responseData;
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> response;
  void _startUploading() async {
    print('Uploading');
    response = await _uploadImage(_imageFile);
    // Check if any error occured
    if (response == null) {
      Toast.show("Image Upload Failed!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      setState(() {
        _imageFile = null;
        _showDiseaseDataBoolean = true;
      });
      Toast.show("Image Uploaded Successfully!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
            child: OutlineButton(
              onPressed: () => _openImagePickerModal(context),
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Add Image'),
                ],
              ),
            ),
          ),
          _imageFile == null
              ? Text('Please pick an image')
              : Image.file(
                  _imageFile,
                  fit: BoxFit.cover,
                  height: 300.0,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                ),
          _imageFile != null
              ? Container(
                  child: RaisedButton(
                    splashColor: Colors.blue,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40),
                      side: new BorderSide(color: Colors.red),
                    ),
                    onPressed: () async {
                      if (_imageFile != null) {
                        _startUploading();
                      }
                    },
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Send Leaf Image',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(child: Text(' ')),
          _showDiseaseDataBoolean
              ? Text("Predicated Disease " + response['predicted'])
              : Text('')
        ],
      ),
    );
  }
}
