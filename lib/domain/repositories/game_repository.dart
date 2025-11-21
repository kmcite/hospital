import 'package:hospital/utils/in_memory_collection.dart';
import 'package:hospital/utils/model.dart';

class Games extends InMemoryCollection<GameModel> {}

typedef GameId = int;

class GameModel extends Model {
  @override
  GameId id = 0;
}
