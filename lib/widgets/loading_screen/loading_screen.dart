import 'dart:async';

import 'package:bloc_test_project/widgets/loading_screen/loading_screen_controller.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  //Singleton pattern
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;
  LoadingScreenController? _controller;
  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_controller?.updateLoadingScreen(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.closeLoadingScreen();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textController = StreamController<String>();
    textController.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: ((context) {
        return Material(
          color: Colors.black.withOpacity(0.7),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CircularProgressIndicator(),
                  StreamBuilder<String>(
                    stream: textController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      }
                      return Container();
                    },
                  ),
                ],
              )),
            ),
          ),
        );
      }),
    );
    state?.insert(overlay);
    return LoadingScreenController(
      closeLoadingScreen: () {
        textController.close();
        overlay.remove();
        return true;
      },
      updateLoadingScreen: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
