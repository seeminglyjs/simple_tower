import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:simple_tower/simple_tower.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();

  SimpleTower game = SimpleTower();
  runApp(GameWidget(game: game));
}
