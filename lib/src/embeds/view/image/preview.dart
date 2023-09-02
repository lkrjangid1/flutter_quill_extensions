import 'package:flutter/material.dart';

void showImagePreview(BuildContext context, Image image) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final size = MediaQuery.sizeOf(context);
      return Dialog(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: InteractiveViewer(
                  maxScale: 3,
                  minScale: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: image,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
