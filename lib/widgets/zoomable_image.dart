import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ZoomableImage extends StatefulWidget {
  final String imagePath;

  const ZoomableImage({
    super.key,
    required this.imagePath,
  });

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  final TransformationController _controller = TransformationController();
  late TapDownDetails _doubleTapDetails;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_controller.value != Matrix4.identity()) {
      _controller.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a better zoom effect
      _controller.value = Matrix4.identity()
        ..translateByVector3(
          Vector3(-position.dx * 2, -position.dy * 2, 0),
        )
        ..scaleByVector3(Vector3.all(3.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _controller,
        panEnabled: true,
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 0.5,
        maxScale: 4.0,
        child: Hero(
          tag: widget.imagePath,
          child: Image.asset(
            widget.imagePath,
            fit: BoxFit.contain,
            cacheWidth: 1920,
            cacheHeight: 1080,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[900],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Image not available',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
