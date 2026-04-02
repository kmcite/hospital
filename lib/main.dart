import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' show MaterialApp, ThemeData, ThemeMode;
import 'package:flutter/widgets.dart' show BuildContext, Widget, runApp;
// import 'package:flutter/material.dart';
import 'package:hospital/components/dark_mode.dart';
import 'package:hospital/components/ui.dart';
import 'package:hospital/signals/game_state.dart';
import 'package:hospital/signals/navigation.dart';
import 'package:signals/signals.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/rendering.dart';

class HospitalGame extends UI {
  const HospitalGame({super.key});
  @override
  void init(BuildContext context) {
    gameStateEffect();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: dark() ? ThemeMode.dark : ThemeMode.light,
      home: GameWidget(
        game: RouterGame(),
      ),
    );
  }
}

void main() {
  try {
    SignalsObserver.instance = null;
  } finally {
    runApp(const HospitalGame());
  }
}

class RouterGame extends FlameGame {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        routes: {
          'home': Route(StartPage.new),
          'level1': WorldRoute(GameScreen.new),
          'level2': WorldRoute(Level2Page.new, maintainState: false),
          'pause': PauseRoute(),
        },
        initialRoute: 'home',
      ),
    );
  }
}

class StartPage extends Component with HasGameReference<RouterGame> {
  StartPage() {
    addAll([
      _logo = TextComponent(
        text: 'Hospital',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontWeight: FontWeight.w800,
          ),
        ),
        anchor: Anchor.center,
      ),
      _startGameButton = RoundedButton(
        text: 'Start Game',
        action: () => game.router.pushNamed('level1'),
        color: const Color(0xffadde6c),
        borderColor: const Color.fromARGB(255, 198, 250, 9),
      ),
      _optionsButton = RoundedButton(
        text: 'Options',
        action: () => game.router.pushNamed('level2'),
        color: const Color.fromARGB(255, 201, 10, 10),
        borderColor: const Color.fromARGB(255, 224, 179, 0),
      ),
    ]);
  }

  late final TextComponent _logo;
  late final RoundedButton _startGameButton;
  late final RoundedButton _optionsButton;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 3);
    _startGameButton.position = Vector2(size.x / 2, _logo.y + 80);
    _optionsButton.position = Vector2(size.x / 2, _logo.y + 140);
  }
}

class Background extends Component {
  Background(this.color);
  final Color color;

  @override
  void render(Canvas canvas) {
    canvas.drawColor(color, BlendMode.srcATop);
  }
}

class RoundedButton extends PositionComponent with TapCallbacks {
  RoundedButton({
    required this.text,
    required this.action,
    required Color color,
    required Color borderColor,
    super.position,
    super.anchor = Anchor.center,
  }) : _textDrawable = TextPaint(
         style: const TextStyle(
           fontSize: 20,
           color: Color(0xFF000000),
           fontWeight: FontWeight.w800,
         ),
       ).toTextPainter(text) {
    size = Vector2(150, 40);
    _textOffset = Offset(
      (size.x - _textDrawable.width) / 2,
      (size.y - _textDrawable.height) / 2,
    );
    _rrect = RRect.fromLTRBR(0, 0, size.x, size.y, Radius.circular(size.y / 2));
    _bgPaint = Paint()..color = color;
    _borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = borderColor;
  }

  final String text;
  final void Function() action;
  final TextPainter _textDrawable;
  late final Offset _textOffset;
  late final RRect _rrect;
  late final Paint _borderPaint;
  late final Paint _bgPaint;

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(_rrect, _bgPaint);
    canvas.drawRRect(_rrect, _borderPaint);
    _textDrawable.paint(canvas, _textOffset);
  }

  @override
  void onTapDown(TapDownEvent event) {
    scale = Vector2.all(1.05);
  }

  @override
  void onTapUp(TapUpEvent event) {
    scale = Vector2.all(1.0);
    action();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    scale = Vector2.all(1.0);
  }
}

abstract class SimpleButton extends PositionComponent with TapCallbacks {
  SimpleButton(this._iconPath, {super.position}) : super(size: Vector2.all(40));

  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0x66ffffff);
  final Paint _iconPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xffaaaaaa)
    ..strokeWidth = 7;
  final Path _iconPath;

  void action();

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)),
      _borderPaint,
    );
    canvas.drawPath(_iconPath, _iconPaint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _iconPaint.color = const Color(0xffffffff);
  }

  @override
  void onTapUp(TapUpEvent event) {
    _iconPaint.color = const Color(0xffaaaaaa);
    action();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _iconPaint.color = const Color(0xffaaaaaa);
  }
}

// class BackButton extends SimpleButton with HasGameReference<RouterGame> {
//   BackButton()
//     : super(
//         Path()
//           ..moveTo(22, 8)
//           ..lineTo(10, 20)
//           ..lineTo(22, 32)
//           ..moveTo(12, 20)
//           ..lineTo(34, 20),
//         position: Vector2.all(10),
//       );

//   @override
//   void action() => game.router.pop();
// }

class PauseButton extends SimpleButton with HasGameReference<RouterGame> {
  PauseButton()
    : super(
        Path()
          ..moveTo(14, 10)
          ..lineTo(14, 30)
          ..moveTo(26, 10)
          ..lineTo(26, 30),
        position: Vector2(60, 10),
      );

  bool isPaused = false;

  @override
  void action() {
    if (isPaused) {
      game.router.pop();
    } else {
      game.router.pushNamed('pause');
    }
    isPaused = !isPaused;
  }
}

class GameScreen extends DecoratedWorld with HasGameReference<RouterGame> {
  @override
  Future<void> onLoad() async {
    addAll([
      Background(const Color.fromARGB(186, 103, 35, 176)),
      Planet(
        radius: 25,
        color: const Color(0xfffff188),
        children: [
          Orbit(
            radius: 110,
            revolutionPeriod: 6,
            planet: Planet(
              radius: 10,
              color: const Color(0xff54d7b1),
              children: [
                Orbit(
                  radius: 25,
                  revolutionPeriod: 5,
                  planet: Planet(radius: 3, color: const Color(0xFFcccccc)),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  final hudComponents = <Component>[];

  @override
  void onMount() {
    hudComponents.addAll([
      RoundedButton(
        text: 'back',
        action: () => game.router.pop(),
        color: Color.fromARGB(255, 122, 207, 3),
        borderColor: Color.fromARGB(255, 252, 22, 22),
        position: Vector2(game.size.x / 2, game.size.y / 2),
      ),
      PauseButton(),
    ]);
    game.camera.viewport.addAll(hudComponents);
  }

  @override
  void onRemove() {
    game.camera.viewport.removeAll(hudComponents);
    super.onRemove();
  }
}

class Level2Page extends DecoratedWorld with HasGameReference {
  @override
  Future<void> onLoad() async {
    addAll([
      Background(const Color(0xff052b44)),
      Planet(
        radius: 30,
        color: const Color(0xFFFFFFff),
        children: [
          Orbit(
            radius: 60,
            revolutionPeriod: 5,
            planet: Planet(radius: 10, color: const Color(0xffc9ce0d)),
          ),
          Orbit(
            radius: 110,
            revolutionPeriod: 10,
            planet: Planet(
              radius: 14,
              color: const Color(0xfff32727),
              children: [
                Orbit(
                  radius: 26,
                  revolutionPeriod: 3,
                  planet: Planet(radius: 5, color: const Color(0xffffdb00)),
                ),
                Orbit(
                  radius: 35,
                  revolutionPeriod: 4,
                  planet: Planet(radius: 3, color: const Color(0xffdc00ff)),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  final hudComponents = <Component>[];

  @override
  void onMount() {
    hudComponents.addAll([
      // BackButton(),
      PauseButton(),
    ]);
    game.camera.viewport.addAll(hudComponents);
  }

  @override
  void onRemove() {
    game.camera.viewport.removeAll(hudComponents);
    super.onRemove();
  }
}

class Planet extends PositionComponent {
  Planet({
    required this.radius,
    required this.color,
    super.position,
    super.children,
  }) : _paint = Paint()..color = color;

  final double radius;
  final Color color;
  final Paint _paint;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, radius, _paint);
  }
}

class Orbit extends PositionComponent {
  Orbit({
    required this.radius,
    required this.planet,
    required this.revolutionPeriod,
    double initialAngle = 0,
  }) : _paint = Paint()
         ..style = PaintingStyle.stroke
         ..color = const Color(0x888888aa),
       _angle = initialAngle {
    add(planet);
  }

  final double radius;
  final double revolutionPeriod;
  final Planet planet;
  final Paint _paint;
  double _angle;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, radius, _paint);
  }

  @override
  void update(double dt) {
    _angle += dt / revolutionPeriod * tau;
    planet.position = Vector2(radius, 0)..rotate(_angle);
  }
}

class PauseRoute extends Route {
  PauseRoute() : super(PausePage.new, transparent: true);

  @override
  void onPush(Route? previousRoute) {
    if (previousRoute is WorldRoute && previousRoute.world is DecoratedWorld) {
      (previousRoute.world! as DecoratedWorld).timeScale = 0;
      (previousRoute.world! as DecoratedWorld).decorator =
          PaintDecorator.grayscale(opacity: 0.5)..addBlur(3.0);
    }
  }

  @override
  void onPop(Route nextRoute) {
    if (nextRoute is WorldRoute && nextRoute.world is DecoratedWorld) {
      (nextRoute.world! as DecoratedWorld).timeScale = 1;
      (nextRoute.world! as DecoratedWorld).decorator = null;
    }
  }
}

class PausePage extends Component
    with TapCallbacks, HasGameReference<RouterGame> {
  @override
  Future<void> onLoad() async {
    // final game = findGame()!;
    addAll([
      TextComponent(
        text: 'PAUSED',
        position: game.canvasSize / 2,
        anchor: Anchor.center,
        children: [
          ScaleEffect.to(
            Vector2.all(1.1),
            EffectController(
              duration: 0.3,
              alternate: true,
              infinite: true,
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) => game.router.pop();
}

class DecoratedWorld extends World with HasTimeScale {
  PaintDecorator? decorator;

  @override
  void renderFromCamera(Canvas canvas) {
    if (decorator == null) {
      super.renderFromCamera(canvas);
    } else {
      decorator!.applyChain(super.renderFromCamera, canvas);
    }
  }
}
