import 'package:flutter/material.dart';

class RyveButton extends StatefulWidget {
  const RyveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;

  @override
  State<RyveButton> createState() => _RyveButtonState();
}

class _RyveButtonState extends State<RyveButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 80),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _scaleController.forward();
  void _onTapUp(TapUpDetails _) => _scaleController.reverse();
  void _onTapCancel() => _scaleController.reverse();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = widget.isSecondary
        ? Colors.transparent
        : (isDark ? const Color(0xFFC9A84C) : const Color(0xFF0D1F17));

    final Color fgColor = widget.isSecondary
        ? (isDark ? const Color(0xFFC9A84C) : const Color(0xFF0D1F17))
        : (isDark ? const Color(0xFF0D1F17) : const Color(0xFFF0EBE0));

    final BorderSide borderSide = widget.isSecondary
        ? BorderSide(
            color: isDark ? const Color(0xFFC9A84C) : const Color(0xFF0D1F17),
            width: 1.5,
          )
        : BorderSide.none;

    return GestureDetector(
      onTapDown: widget.onPressed != null ? _onTapDown : null,
      onTapUp: widget.onPressed != null ? _onTapUp : null,
      onTapCancel: widget.onPressed != null ? _onTapCancel : null,
      onTap: widget.onPressed != null && !widget.isLoading
          ? widget.onPressed
          : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(24),
            border: widget.isSecondary ? Border.fromBorderSide(borderSide) : null,
          ),
          alignment: Alignment.center,
          child: widget.isLoading
              ? SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                  ),
                )
              : Text(
                  widget.label,
                  style: TextStyle(
                    color: fgColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
        ),
      ),
    );
  }
}
