import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smappy_store/ui/other/colors.dart';
import 'package:smappy_store/ui/widgets/if.dart';

class PhotoData {
  final String url;
  final bool local;

  const PhotoData({required this.url, required this.local});
}

class PhotoWidget extends StatelessWidget {

  final PhotoData photoData;

  const PhotoWidget(this.photoData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 95,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: AppColors.hint, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: If(
          photoData.local,
          Image.file(File(photoData.url), width: 95, height: 95, fit: BoxFit.cover),
          CachedNetworkImage(imageUrl: photoData.url, width: 95, height: 95, fit: BoxFit.cover),
        ),
      ),
    );
  }

}