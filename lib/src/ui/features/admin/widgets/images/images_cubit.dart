import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit({required ImagesService imagesService}) : _imagesService = imagesService, super(ImagesState());

  // no
  // ignore: unused_field
  final ImagesService _imagesService;
}
