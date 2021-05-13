import 'package:sell_streams/data/models/genres_model.dart';

abstract class GenresRepository {
  Future<List<GenresModel>> getAllGenres();
}