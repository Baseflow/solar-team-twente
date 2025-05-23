import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ioc/flutter_ioc.dart';

import '../../../../../../core.dart';
import 'images_cubit.dart';

class ImagesFormField extends StatelessWidget {
  const ImagesFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImagesCubit>(
      create: (BuildContext context) => ImagesCubit(imagesService: Ioc.container.get<ImagesService>()),
      child: Center(child: Container()),
    );
  }
}
