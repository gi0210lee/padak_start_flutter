import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/comment_page.dart';
import 'package:flutter_application_1/src/model/data/dummys_repository.dart';
import 'package:flutter_application_1/src/model/response/comment_response.dart';
import 'package:flutter_application_1/src/model/response/movie_response.dart';
import 'package:flutter_application_1/src/widget/star_rating_bar.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_application_1/model/response/comment_response.dart';
// import 'package:flutter_application_1/model/response/movie_response.dart';

class DetailPage extends StatefulWidget {
  final String movieId;

  const DetailPage({
    required this.movieId,
    super.key,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String _movieId;
  late MovieResponse _movieResponse;
  late CommentsResponse _commentsResponse;

  // 임시코드
  _buildAfter() {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommentPage(
                title: _movieResponse.title, id: _movieResponse.id)));
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _movieId = widget.movieId;
    _movieResponse = DummysRepository.loadDummyMovie(_movieId);
    _commentsResponse = DummysRepository.loadDummyComments(_movieId);

    _buildAfter();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildMovieSummaryTextColumn() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _movieResponse.title,
            style: const TextStyle(fontSize: 22),
          ),
          Text(
            '${_movieResponse.date} 개봉',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            '${_movieResponse.genre} / ${_movieResponse.duration}분',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
    }

    Widget _buildReservationRate() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            '예매율',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            '${_movieResponse.reservationGrade}위 ${_movieResponse.reservationRate.toString()}%',
          ),
        ],
      );
    }

    Widget _buildVerticalDivider() {
      return Container(width: 1, height: 50, color: Colors.grey);
    }

    Widget _buildUserRating() {
      return Column(
        children: [
          const Text(
            '평점',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${_movieResponse.userRating / 2}',
          ),
        ],
      );
    }

    Widget _buildAudience() {
      final fmt = NumberFormat.decimalPattern();
      return Column(
        children: [
          const Text(
            '누적관객수',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(fmt.format(_movieResponse.audience)),
        ],
      );
    }

    Widget _buildMovieSummary() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                _movieResponse.image,
                height: 180,
              ),
              const SizedBox(
                width: 10,
              ),
              _buildMovieSummaryTextColumn(),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildReservationRate(),
              _buildVerticalDivider(),
              _buildUserRating(),
              _buildVerticalDivider(),
              _buildAudience()
            ],
          )
        ],
      );
    }

    Widget _buildMovieSynopsis() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 10,
          color: Colors.grey.shade400,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            '줄거리',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, top: 10, bottom: 5),
          child: Text(_movieResponse.synopsis),
        )
      ]);
    }

    Widget _buildMovieCast() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 10,
          color: Colors.grey.shade400,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            '감독/출연',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, top: 10, bottom: 5),
          child: Column(
            children: [
              Row(children: [
                const Text(
                  '감독',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(_movieResponse.director),
              ]),
              const SizedBox(height: 5),
              Row(children: [
                const Text(
                  '출연',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(_movieResponse.actor))
              ]),
            ],
          ),
        )
      ]);
    }

    void _presentCommentPage(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              CommentPage(title: _movieResponse.title, id: _movieResponse.id)));
    }

    Widget _buildCommentListItem({required Comment comment}) {
      String _convertTimeStampToDateTime(int timestamp) {
        final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
        return fmt
            .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
      }

      return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.person_pin),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(comment.writer),
                    const SizedBox(
                      width: 5,
                    ),
                    StarRatingBar(
                      rating: comment.rating.toInt(),
                      isUserInteractionEnabled: false,
                      size: 20,
                      onRatingChanged: (rating) {},
                    )
                  ],
                ),
                Text(_convertTimeStampToDateTime(comment.timestamp)),
                const SizedBox(height: 5),
                Text(comment.contents)
              ],
            )
          ],
        ),
      );
    }

    Widget _buildCommentListView() {
      return ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: _commentsResponse.comments.length,
        itemBuilder: (_, index) =>
            _buildCommentListItem(comment: _commentsResponse.comments[index]),
      );
    }

    Widget _buildComment() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 10,
            color: Colors.grey.shade400,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('한줄평',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => _presentCommentPage(context),
                  icon: const Icon(Icons.create),
                  color: Colors.blue,
                )
              ],
            ),
          ),
          _buildCommentListView()
        ],
      );
    }

    Widget _bulidContents() {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          _buildMovieSummary(),
          _buildMovieSynopsis(),
          _buildMovieCast(),
          _buildComment()
        ]),
      );
    }

    return Scaffold(
        appBar: AppBar(title: Text(_movieResponse.title)),
        body: _bulidContents());
  }
}
