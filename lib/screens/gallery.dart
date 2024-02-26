import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late File? _image = null; // Change to nullable File

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Hero(
                tag:
                    'selected_image_hero_tag', // Unique tag for the selected image
                child: Image.file(
                  _image!, // Use null check operator ! to access nullable _image
                  width: 300,
                  height: 300,
                ),
              ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Hero(
            tag: 'camera_fab_hero_tag', // Unique tag for the camera FAB
            child: FloatingActionButton(
              onPressed: () => _getImage(ImageSource.camera),
              tooltip: 'Take Picture',
              child: Icon(Icons.camera_alt),
            ),
          ),
          SizedBox(height: 16),
          Hero(
            tag: 'gallery_fab_hero_tag', // Unique tag for the gallery FAB
            child: FloatingActionButton(
              onPressed: () => _getImage(ImageSource.gallery),
              tooltip: 'Choose from Gallery',
              child: Icon(Icons.photo_library),
            ),
          ),
        ],
      ),
    );
  }
}
