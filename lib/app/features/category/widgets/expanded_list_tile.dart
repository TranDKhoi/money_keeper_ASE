import '../../../../data/models/category.dart';

class BasicTile {
  final String tileName;
  final List<Category> tiles;

  BasicTile({required this.tileName, this.tiles = const []});
}
