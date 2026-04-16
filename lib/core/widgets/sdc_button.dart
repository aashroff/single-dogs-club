import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/dimensions.dart';

class SdcButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLarge;
  final bool isLoading;
  final IconData? icon;
  final Gradient? gradient;

  const SdcButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = true,
    this.isLarge = false,
    this.isLoading = false,
    this.icon,
    this.gradient,
  });

  @override
  State<SdcButton> createState() => _SdcButtonState();
}

class _SdcButtonState extends State<SdcButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final grad = widget.gradient ??
        (widget.isPrimary
            ? AppColors.coralGradient
            : AppColors.sageGradient);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _hovering ? -2.0 : 0.0),
        decoration: BoxDecoration(
          gradient: widget.isPrimary ? grad : null,
          border: widget.isPrimary
              ? null
              : Border.all(color: AppColors.coral, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          boxShadow: widget.isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.coral.withOpacity(_hovering ? 0.35 : 0.2),
                    blurRadius: _hovering ? 20 : 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            onTap: widget.isLoading ? null : widget.onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.isLarge ? 32 : 24,
                vertical: widget.isLarge ? 18 : 14,
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            size: 18,
                            color: widget.isPrimary
                                ? Colors.white
                                : AppColors.coral,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: widget.isLarge ? 16 : 14,
                            fontWeight: FontWeight.w700,
                            color: widget.isPrimary
                                ? Colors.white
                                : AppColors.coral,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
