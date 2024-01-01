import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:simple_tower/component/enemy.dart';
import 'package:simple_tower/component/maps.dart';

class SimpleTower extends FlameGame {
  @override
  Color backgroundColor() =>
      const Color(0xff211f30); //백그라운드 색상을 게임의 빈공간과 같은 색상으로 지정한다.

  late final CameraComponent cam;
  List<Enemy> enemys = [];

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages(); // 사용하는 모든 이미지를 캐시로 불러온다.

    final map = Maps(
      mapName: 'base',
      enemys: enemys,
    );
    cam = CameraComponent.withFixedResolution(
        world: map, width: 360, height: 640);
    cam
      ..priority = 0
      ..viewfinder.anchor = Anchor.topLeft;

    // SpawnComponent enemySpawnComponent = SpawnComponent(
    //   factory: (index) {
    //     return Enemy();
    //   },
    //   period: 1,
    //   area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
    // );

    addAll([map, cam]);

    return super.onLoad();
  }
}
