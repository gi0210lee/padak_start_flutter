import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/widget/star_rating_bar.dart';

class CommentPage extends StatefulWidget {
  final String title;
  final String id;

  const CommentPage({required this.title, required this.id, super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late String _title;
  late String _id;
  late String _writer;
  late String _contents;
  late int _rating = 3;

  @override
  void initState() {
    super.initState();

    _title = widget.title;
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldState,
      appBar: AppBar(
        title: const Text('한줄평 작성'),
        actions: [_buildSubmitButton()],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          Navigator.of(context).pop();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildMovieTitle(),
              _buildUserRating(),
              _buildHorizontalDivider(),
              _buildNickNameInpuitForm(),
              _buildCommentInputForm()
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentInputForm() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20,
        bottom: 10,
      ),
      child: TextField(
        onChanged: (text) => _contents = text,
        maxLines: null,
        maxLength: 100,
        decoration: InputDecoration(
          hintText: '한줄평을 작성해주세요',
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }

  Widget _buildNickNameInpuitForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        onChanged: (text) => _writer = text,
        maxLines: 1,
        maxLength: 20,
        decoration: InputDecoration(
          hintText: '닉네임을 입력해주세요',
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide()),
        ),
      ),
    );
  }

  Widget _buildHorizontalDivider() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        width: double.infinity,
        height: 10,
        color: Colors.grey.shade400);
  }

  Widget _buildUserRating() {
    return Column(
      children: [
        StarRatingBar(onRatingChanged: (rating) {
          setState(() {
            _rating = rating;
          });
        }),
        Text((_rating / 2.0).toString())
      ],
    );
  }

  Widget _buildMovieTitle() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        _title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSubmitButton() {
    const sendIcon = Icon(
      Icons.send,
      color: Colors.white,
      size: 25,
    );
    return IconButton(
        icon: sendIcon,
        onPressed: () {
          if (_writer.isEmpty || _contents.isEmpty) {
            _showSnackBar('모든 정보를 입력해주세요');
          } else {
            Navigator.of(context).pop(true);
          }
        });
  }

  Widget _showSnackBar(String text) {
    return Text(text);
  }
}
