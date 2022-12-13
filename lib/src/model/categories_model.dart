import 'package:uuid/uuid.dart';

class CategoriesModel {
  final String id = const Uuid().v4();
  final double supermerc;
  final double lazer;
  final double transpor;
  final double gastosex;
  final double pagament;

  CategoriesModel(
      {this.supermerc = 0,
      this.lazer = 0,
      this.transpor = 0,
      this.gastosex = 0,
      this.pagament = 0});
}
