import 'package:flame/components.dart';

class StaticElement extends SpriteComponent {
  StaticElement(this.name, Vector2 size, Vector2 newPos)
      : super(size: size, position: newPos);

  String name;

  @override
  void onLoad() async {
    sprite = await Sprite.load("$name.png");
    super.onLoad();
  }
}
