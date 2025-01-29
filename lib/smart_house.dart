import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';

class SmartHouse extends FlameGame with TapDetector {
  late BulbComponent bulb;

  @override
  Future<void> onLoad() async {
    bulb = BulbComponent();
    add(bulb);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (bulb.containsPoint(info.eventPosition.global)) {
      bulb.toggleState();
    }
  }
}

class BulbComponent extends PositionComponent {
  bool isOn = false;
  late TextPaint textPaint;

  BulbComponent() {
    size = Vector2(100, 100);
    position = Vector2(150, 200);
    textPaint = TextPaint(
      style: const TextStyle(fontSize: 24, color: Colors.white),
    );
  }

  void toggleState() {
    isOn = !isOn;
  }

  @override
  void render(Canvas canvas) {
    // Use colors from MyPalette
    final bulbColor = isOn ? Colors.yellow : Colors.grey;
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      Paint()..color = bulbColor,
    );

    // Render the text
    textPaint.render(
      canvas,
      isOn ? 'ON' : 'OFF',
      Vector2(size.x / 4, size.y / 2),
    );
  }

  @override
  bool containsPoint(Vector2 point) {
    // Check if the point is within the bounds of the bulb
    return (point - position).length <= (size.x / 2);
  }
}
