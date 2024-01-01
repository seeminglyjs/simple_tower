import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:simple_tower/component/enemy.dart';

class Maps extends World {
  final String mapName;
  final List<Enemy> enemys;
  Maps({
    required this.mapName,
    required this.enemys,
  });

  late TiledComponent tiledComponent;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;
    tiledComponent = await TiledComponent.load('$mapName.tmx', Vector2(16, 16));
    add(tiledComponent);

    final spawnEnemyArea =
        tiledComponent.tileMap.getLayer<ObjectGroup>('start');

    add(TimerComponent(
        period: 5,
        repeat: true,
        onTick: () {
          if (spawnEnemyArea != null) {
            Enemy enemy = Enemy();
            for (final spawnPoint in spawnEnemyArea.objects) {
              switch (spawnPoint.class_) {
                case 'Player':
                  enemy.position = Vector2(spawnPoint.x, spawnPoint.y);
                  enemys.add(enemy);
                  add(enemy);
                  break;
                default:
                  enemy.position = Vector2(spawnPoint.x, spawnPoint.y);
                  enemys.add(enemy);
                  add(enemy);
                  break;
              }
            }
          }
          print('total enemy -> ${enemys.length}');
        }));

    return super.onLoad();
  }
}
