import 'package:flutter/material.dart';
import 'package:image_search/data/api.dart';

import '../../model/photo.dart';

//depth 가 깊어질 경우, 데이터를 밑에까지 전달해야함
//원하는 곳으로 데이터를 전달하는 inherited widget 사용
class PhotoWidget extends StatelessWidget {
  final Photo photo;

  const PhotoWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(photo.previewURL),
          )
      ),
    );
  }
}
