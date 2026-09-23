import 'package:flutter/material.dart';

class PhotoViewScreen extends StatelessWidget {
  final String imagePath;
  final String? title;

  const PhotoViewScreen({super.key, required this.imagePath, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: title != null ? Text(title!, style: TextStyle(color: Colors.white, fontSize: 16)) : null,
        centerTitle: true,
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
