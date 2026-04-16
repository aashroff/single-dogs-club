import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/app_logo.dart';
import 'swipe_card_demo.dart';

class HeroSection extends StatelessWidget {
  HeroSection({super.key});

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.tablet;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl, 0, AppSpacing.xl, isMobile ? 40 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.desktop),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroContent(
                      emailController: _emailController,
                      isMobile: true,
                    ),
                    const SizedBox(height: 36),
                    const Center(child: SwipeCardDemo()),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: _HeroContent(
                        emailController: _emailController,
                        isMobile: false,
                      ),
                    ),
                    const SizedBox(width: 40),
                    const Flexible(
                      flex: 7,
                      child: SwipeCardDemo(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─── Hero Left Content ───

class _HeroContent extends StatefulWidget {
  final TextEditingController emailController;
  final bool isMobile;

  const _HeroContent({
    required this.emailController,
    required this.isMobile,
  });

  @override
  State<_HeroContent> createState() => _HeroContentState();
}

class _HeroContentState extends State<_HeroContent>
    with TickerProviderStateMixin {
  late AnimationController _typeController;
  late AnimationController _floatController;

  static const _line1 = 'DOGGY DATES';
  static const _line2 = 'And Playmates.';

  @override
  void initState() {
    super.initState();
    _typeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Typing tagline ──
        _buildTypingTagline(),
        const SizedBox(height: 20),

        // ── Subtitle ──
        RichText(
          text: TextSpan(
            style: (widget.isMobile
                    ? AppTypography.headlineLarge
                    : AppTypography.displaySmall)
                .copyWith(height: 1.15),
            children: [
              const TextSpan(text: 'Find canine friends '),
              TextSpan(
                text: 'near you',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = AppColors.coralGradient.createShader(
                      const Rect.fromLTWH(0, 0, 300, 60),
                    ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Badge ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.sage.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulsingDot(),
              const SizedBox(width: 8),
              Text(
                'Now open for early access',
                style: AppTypography.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.sageDark,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Description ──
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Text(
            'Connecting like-minded dog owners for walks, cafe '
            'meet-ups, playdates, and lasting friendships. '
            'For your dog and for you.',
            style: AppTypography.bodyMedium.copyWith(height: 1.65),
          ),
        ),
        const SizedBox(height: 28),

        // ── Email capture ──
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: AppColors.borderCoral),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18),
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textHint,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.coralGradient,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.coral.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 12,
                        ),
                        child: Text(
                          'Get Early Access',
                          style: AppTypography.labelMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Free to join. No spam, ever. Unsubscribe anytime.',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textHint,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTypingTagline() {
    final total = _line1.length + _line2.length;

    return AnimatedBuilder(
      animation: _typeController,
      builder: (context, _) {
        final progress = _typeController.value;
        final chars = (progress * total).floor();
        final c1 = chars.clamp(0, _line1.length);
        final c2 = (chars - _line1.length).clamp(0, _line2.length);
        final typing = progress < 1.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Line 1
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.coral, AppColors.coralDark],
                  ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    _line1.substring(0, c1),
                    style: GoogleFonts.fraunces(
                      fontSize: widget.isMobile ? 36 : 46,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                if (typing && c2 == 0) _Cursor(),
              ],
            ),
            // Line 2
            if (c2 > 0 || (!typing))
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.coralLight, AppColors.coral],
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      _line2.substring(0, c2),
                      style: GoogleFonts.fraunces(
                        fontSize: widget.isMobile ? 30 : 38,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        height: 1.15,
                      ),
                    ),
                  ),
                  if (typing && c2 > 0) _Cursor(),
                ],
              ),

            // Floating emoji trail after typing
            if (!typing) ...[
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _floatController,
                builder: (context, _) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < 5; i++)
                      Transform.translate(
                        offset: Offset(
                          0,
                          sin(_floatController.value * pi * 2 + i * 0.9) * 3,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            ['\uD83D\uDC3E', '\uD83D\uDC36', '\uD83E\uDDAE', '\uD83D\uDC15', '\u2764\uFE0F'][i],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

// ─── Blinking cursor ───

class _Cursor extends StatefulWidget {
  @override
  State<_Cursor> createState() => _CursorState();
}

class _CursorState extends State<_Cursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _blink;

  @override
  void initState() {
    super.initState();
    _blink = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blink,
      builder: (_, __) => Opacity(
        opacity: _blink.value > 0.5 ? 1.0 : 0.0,
        child: Container(
          width: 3,
          height: 36,
          margin: const EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
            color: AppColors.coral,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// ─── Pulsing dot ───

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.sageDark.withOpacity(0.4 + _ctrl.value * 0.6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
