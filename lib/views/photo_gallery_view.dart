import 'package:bloc_test_project/bloc/app_bloc.dart';
import 'package:bloc_test_project/bloc/app_event.dart';
import 'package:bloc_test_project/bloc/app_state.dart';
import 'package:bloc_test_project/views/main_popup_menu.dart';
import 'package:bloc_test_project/views/storage_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class PhotoGalleryView extends StatelessWidget {
  const PhotoGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(
      () {
        return ImagePicker();
      },
      [key],
    );
    final images = (context.read<AppBloc>().state as AppStateLoggedIn).images;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                context.read<AppBloc>().add(
                      AppEventUploadImage(filePathToUpload: image.path),
                    );
              }
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
          const MainPopupMenu(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children:
            images.map((img) => StorageImageView(reference: img)).toList(),
      ),
    );
  }
}
