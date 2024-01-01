import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:simple_tower/simple_tower.dart';

enum EnemyState { idle, running, jumping, falling }

enum EnemyDirection { left, right }

class Enemy extends SpriteAnimationGroupComponent
    with HasGameReference<SimpleTower>, CollisionCallbacks {
  String character;
  Enemy({
    position,
    this.character = 'Ninja Frog',
  });
  static const enemySize = 50.0;
  final double stepTime = 0.05;
  late final SpriteAnimation idleAnimation; //가만히 있는 캐릭터
  late final SpriteAnimation runningAnimation; //뛰는 캐릭터
  late final SpriteAnimation jumpingAnimation; //점프하는 캐릭터
  late final SpriteAnimation fallingAnimation; //떨어지는 캐릭터

  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _loadAllAnimations();
    add(TimerComponent(
        period: 3,
        repeat: true,
        onTick: () => {
              // print('${this.hashCode} ---- move'),
              velocity.x = moveSpeed,
              position.x += velocity.x * 0.3,
            }));

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    debugMode = true;
    // position.y += dt * 250;

    // if (position.y > game.size.y) {
    //   removeFromParent();
    // }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    // if (other is Bullet) {
    //   removeFromParent();
    //   other.removeFromParent();
    //   game.add(Explosion(position: position));
    // }
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);

    //모든 애니매이션의 리스트
    animations = {
      EnemyState.idle: idleAnimation, //가만히 있는 캐릭터
      EnemyState.running: runningAnimation, // 뛰는 캐릭터
      EnemyState.jumping: jumpingAnimation,
      EnemyState.falling: fallingAnimation,
    };

    //현재의 애니매이션 셋팅
    current = EnemyState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache(
          'Main Characters/$character/$state (32x32).png'), //캐시에서 이미지 찾기 HasGameReference 인 메인 실행클래스에서 캐시로 저장해두어서 찾을 수 있음
      SpriteAnimationData.sequenced(
        amount: amount, // 하나의 이미지에 있는 랜딩 이미지 숫자
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
