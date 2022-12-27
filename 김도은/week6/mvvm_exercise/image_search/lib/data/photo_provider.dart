import 'package:flutter/material.dart';

import '../ui/home_view_model.dart';

//어떠한 위젯 트리에도 원하는 데이터를 넣어줄 수 있는 방법을 제공
//InHeritedWidget 안에는 불변 객체만 존재해야 함
class PhotoProvider extends InheritedWidget{
  final HomeViewModel viewModel;

  const PhotoProvider({
    Key? key,
    required this.viewModel,
    required Widget child,
  }) : super(key: key, child: child);

  static PhotoProvider of(BuildContext context) {
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    // assert는 조건이 맞지 않을 경우, 에러를 내주는 코드
    assert(result != null, 'No PixabayApi found in context');
    return result!;
  }


  // 이전 상태와 변경 상태를 비교해야 함
  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return true;
  }

}