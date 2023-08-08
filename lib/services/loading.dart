import 'package:flutter/material.dart';

import 'loading_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? controller;

  void show(BuildContext context) {
    controller = showOverlay(context);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay(BuildContext context) {
    final state = Overlay.of(context);
    final size = MediaQuery.of(context).size;
    final overlay = loadingOverlay(size);

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        overlay.remove();
        return true;
      },
    );
  }

  OverlayEntry loadingOverlay(Size size) {
    return OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    CircularProgressIndicator(color: Colors.blue),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
