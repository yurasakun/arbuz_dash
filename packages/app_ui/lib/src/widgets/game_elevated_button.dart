import 'package:flutter/material.dart';

/// {@template game_button}
/// Common elevated button for the screens in the game.
/// {@endtemplate}
class GameElevatedButton extends StatelessWidget {
  /// {@macro game_button}
  GameElevatedButton({
    required String label,
    VoidCallback? onPressed,
    this.gradient,
    super.key, this.color,
  }) : _child = FilledButton(
          onPressed: onPressed,
          child: Text(label),
        );

  /// {@macro game_button}
  GameElevatedButton.icon({
    required String label,
    required Icon icon,
    VoidCallback? onPressed,
    this.gradient,
    super.key, this.color,
  }) : _child = FilledButton.icon(
          icon: icon,
          label: Text(label),
          onPressed: onPressed,
        );

  final Widget _child;

  /// The gradient to use for the background.
  final Gradient? gradient;

  ///
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF001C34),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: theme.copyWith(
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 22),
              textStyle: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        child: _child,
      ),
    );
  }
}
