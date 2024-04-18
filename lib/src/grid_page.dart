import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/detail_page.dart';
import 'package:flutter_application_1/src/model/data/dummys_repository.dart';
import 'package:flutter_application_1/src/model/response/movies_response.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridPage extends StatefulWidget {
  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  final List<Movie> movies = DummysRepository.loadDummyMovies();

  Widget _buildGradeImage(int grade) {
    switch (grade) {
      case 0:
        return SvgPicture.asset(
          'assets/images/ic_age_all.svg',
          height: 18,
        );
      case 12:
        return SvgPicture.asset('assets/images/ic_age_12.svg', height: 18);
      case 15:
        return SvgPicture.asset('assets/images/ic_age_15.svg', height: 18);
      case 19:
        return SvgPicture.asset('assets/images/ic_age_19.svg', height: 18);
      default:
        return SvgPicture.asset('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: (9 / 16)),
      itemCount: movies.length,
      itemBuilder: (context, index) => _buildGridItem(context, index: index),
    );
  }

  Widget _buildGridItem(BuildContext context, {required int index}) {
    Movie movie = movies[index];
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: Stack(alignment: Alignment.topRight, children: [
              Image.network(
                movie.thumb,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: _buildGradeImage(movie.grade),
              ),
            ])),
            const SizedBox(
              height: 8,
            ),
            FittedBox(
              child: Text(
                movie.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
                '${movie.reservationGrade} 위 ( ${movie.userRating} ) / ${movie.reservationRate} %'),
            const SizedBox(height: 8),
            Text(movie.date)
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailPage(
            movieId: movie.id,
          ),
        ));
      },
    );
  }
}
