import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_search/ui/widget/photo_widget.dart';
import '../data/api.dart';
import '../data/photo_provider.dart';
import '../model/photo.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose(){
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 상태 관리 Provider
    final viewModel = PhotoProvider.of(context).viewModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("이미지 검색 앱",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        //그림자 없애기
        elevation: 0,
      ),
      body: Column(
        //const는 변수를 사용하지 않고 위젯을 사용할 경우, 컴파일 타임에 만들어지고 재사용되는 메모리로 아껴줌
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: IconButton(
                    onPressed: () async {
                      viewModel.fetch(_controller.text);
                }, icon: const Icon(Icons.search))
              ),
            ),
          ),
          StreamBuilder<List<Photo>>(
            stream: viewModel.photoStream,
            // 데이터가 snapshot을 통해 들어옴
            builder: (context, snapshot) {

              if(!snapshot.hasData){
                return const CircularProgressIndicator();
              }

              final photos = snapshot.data!;

              return Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: photos.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index){
                      final photo = photos[index];
                      return PhotoWidget(
                          photo: photo,
                      );
                    }
                    ),
              );
            }
          )
        ],
      )
    );
  }
}
