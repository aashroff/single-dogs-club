import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

class _DemoProfile {
  final String name;
  final String breed;
  final int age;
  final String owner;
  final String location;
  final String temperament;
  final String energy;
  final String image;

  const _DemoProfile({
    required this.name,
    required this.breed,
    required this.age,
    required this.owner,
    required this.location,
    required this.temperament,
    required this.energy,
    required this.image,
  });
}

const _profiles = [
  _DemoProfile(
    name: 'Petra',
    breed: 'Labrador',
    age: 2,
    owner: 'Sarah',
    location: 'Scunthorpe',
    temperament: 'Playful',
    energy: 'High',
    image: 'assets/images/dog1.jpg',
  ),
  _DemoProfile(
    name: 'Scout',
    breed: 'Australian Shepherd',
    age: 3,
    owner: 'Emma',
    location: 'Lincoln',
    temperament: 'Friendly',
    energy: 'High',
    image: 'assets/images/dog2.jpg',
  ),
  _DemoProfile(
    name: 'Biscuit',
    breed: 'Golden Retriever',
    age: 5,
    owner: 'Tom',
    location: 'Sheffield',
    temperament: 'Calm',
    energy: 'Medium',
    image: 'assets/images/dog3.jpg',
  ),
  _DemoProfile(
    name: 'Tyler',
    breed: 'Terrier Cross',
    age: 14,
    owner: 'Sarah',
    location: 'Scunthorpe',
    temperament: 'Gentle',
    energy: 'Low',
    image: 'assets/images/dog4.jpg',
  ),
];

class SwipeCardDemo extends StatefulWidget {
  const SwipeCardDemo({super.key});

  @override
  State<SwipeCardDemo> createState() => _SwipeCardDemoState();
}

class _SwipeCardDemoState extends State<SwipeCardDemo>
    with TickerProviderStateMixin {
  int _current = 0;
  double _dx = 0;
  double _dy = 0;
  late AnimationController _fling;
  double _flingDir = 0;

  @override
  void initState() {
    super.initState();
    _fling = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          setState(() {
            _current = (_current + 1) % _profiles.length;
            _dx = 0;
            _dy = 0;
            _fling.reset();
          });
        }
      });
  }

  @override
  void dispose() {
    _fling.dispose();
    super.dispose();
  }

  void _swipe(double dir) {
    _flingDir = dir;
    if (_dx.abs() < 30) _dx = dir * 30;
    _fling.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  // Back cards (visible stack)
                  _backCard(2),
                  _backCard(1),
                  // Front card
                  _frontCard(),
                  // Left arrow (Pass)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 60,
                    child: Center(
                      child: _ArrowBtn(
                        icon: Icons.chevron_left_rounded,
                        color: AppColors.coralDark,
                        bgColor: AppColors.coralPale,
                        onTap: () => _swipe(-1),
                      ),
                    ),
                  ),
                  // Right arrow (Like)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 60,
                    child: Center(
                      child: _ArrowBtn(
                        icon: Icons.chevron_right_rounded,
                        color: AppColors.sageDark,
                        bgColor: AppColors.sagePale,
                        onTap: () => _swipe(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _Buttons(
            onPass: () => _swipe(-1),
            onStar: () => _swipe(1),
            onLike: () => _swipe(1),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _backCard(int depth) {
    final idx = (_current + depth) % _profiles.length;
    final p = _profiles[idx];
    final scale = 1.0 - depth * 0.055;
    final yOff = depth * 20.0;
    final rot = depth * -0.018;

    return Positioned(
      top: yOff,
      left: 0,
      right: 0,
      child: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0008)
            ..scale(scale, scale)
            ..rotateZ(rot)
            ..rotateY(depth * 0.03),
          child: IgnorePointer(
            child: Opacity(
              opacity: 1.0 - depth * 0.18,
              child: _Card(profile: p, shadow: 8.0 - depth * 3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _frontCard() {
    final p = _profiles[_current];
    final v = _fling.value;

    double tx = _dx, ty = _dy, rz = _dx * 0.0006;
    if (_fling.isAnimating) {
      tx += _flingDir * 800 * v;
      ty -= 60 * v;
      rz = _flingDir * 0.28 * v;
    }

    final pct = (_dx.abs() / 120).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _fling,
      builder: (_, child) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Center(
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0008)
              ..translate(tx, ty)
              ..rotateZ(rz),
            child: child,
          ),
        ),
      ),
      child: GestureDetector(
        onPanUpdate: (d) {
          if (!_fling.isAnimating) {
            setState(() {
              _dx += d.delta.dx;
              _dy += d.delta.dy * 0.3;
            });
          }
        },
        onPanEnd: (_) {
          if (_dx.abs() > 90) {
            _swipe(_dx > 0 ? 1 : -1);
          } else {
            setState(() { _dx = 0; _dy = 0; });
          }
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _Card(profile: p, shadow: 16),
            if (pct > 0.2)
              Positioned(
                top: 28,
                left: _dx > 0 ? 28 : null,
                right: _dx < 0 ? 28 : null,
                child: Transform.rotate(
                  angle: _dx > 0 ? -0.18 : 0.18,
                  child: Opacity(
                    opacity: pct,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _dx > 0
                              ? AppColors.sageDark
                              : AppColors.coralDark,
                          width: 3.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: (_dx > 0
                                ? AppColors.sageDark
                                : AppColors.coralDark)
                            .withOpacity(0.06),
                      ),
                      child: Text(
                        _dx > 0 ? 'MATCH!' : 'PASS',
                        style: AppTypography.headlineMedium.copyWith(
                          color: _dx > 0
                              ? AppColors.sageDark
                              : AppColors.coralDark,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────
// Card
// ──────────────────────────────────

class _Card extends StatelessWidget {
  final _DemoProfile profile;
  final double shadow;

  const _Card({required this.profile, this.shadow = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04 + shadow * 0.004),
            blurRadius: shadow * 2.2,
            spreadRadius: shadow * 0.15,
            offset: Offset(0, shadow * 0.9),
          ),
          BoxShadow(
            color: AppColors.coral.withOpacity(0.03),
            blurRadius: 48,
            offset: const Offset(0, 20),
          ),
        ],
        border: Border.all(color: AppColors.coral.withOpacity(0.06)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Photo
          Expanded(
            flex: 6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  profile.image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
                // Bottom gradient
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),
                // Name + badge
                Positioned(
                  bottom: 16,
                  left: 22,
                  right: 22,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          profile.name,
                          style: AppTypography.displaySmall.copyWith(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Text(
                          '${profile.age} yrs',
                          style: AppTypography.labelMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Info
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.pets_rounded,
                          size: 15, color: AppColors.textMuted),
                      const SizedBox(width: 7),
                      Text(profile.breed,
                          style: AppTypography.bodyMedium
                              .copyWith(fontWeight: FontWeight.w500)),
                      const Spacer(),
                      const Icon(Icons.location_on_rounded,
                          size: 15, color: AppColors.sage),
                      const SizedBox(width: 4),
                      Text(profile.location,
                          style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.sageDark,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${profile.owner}\'s dog',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textHint)),
                  const Spacer(),
                  Row(
                    children: [
                      _Tag(profile.temperament, AppColors.sage),
                      const SizedBox(width: 8),
                      _Tag('${profile.energy} energy', AppColors.coral),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(label,
          style: AppTypography.tag.copyWith(color: color, fontSize: 12)),
    );
  }
}

// ──────────────────────────────────
// Action Buttons
// ──────────────────────────────────

class _Buttons extends StatelessWidget {
  final VoidCallback onPass;
  final VoidCallback onStar;
  final VoidCallback onLike;

  const _Buttons({
    required this.onPass,
    required this.onStar,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Btn(
          icon: Icons.close_rounded,
          size: 60,
          iconSize: 30,
          colors: [AppColors.coralPale, AppColors.coralPale.withOpacity(0.4)],
          iconColor: AppColors.coralDark,
          glow: AppColors.coral.withOpacity(0.15),
          onTap: onPass,
        ),
        const SizedBox(width: 22),
        _Btn(
          icon: Icons.star_rounded,
          size: 50,
          iconSize: 26,
          colors: const [Color(0xFFFFF3D0), Color(0xFFFFF8E1)],
          iconColor: AppColors.warning,
          glow: AppColors.warning.withOpacity(0.15),
          onTap: onStar,
        ),
        const SizedBox(width: 22),
        _Btn(
          icon: Icons.favorite_rounded,
          size: 60,
          iconSize: 30,
          colors: [AppColors.sage, AppColors.sageDark],
          iconColor: Colors.white,
          glow: AppColors.sage.withOpacity(0.25),
          onTap: onLike,
        ),
      ],
    );
  }
}

class _Btn extends StatefulWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final List<Color> colors;
  final Color iconColor;
  final Color glow;
  final VoidCallback onTap;

  const _Btn({
    required this.icon,
    required this.size,
    required this.iconSize,
    required this.colors,
    required this.iconColor,
    required this.glow,
    required this.onTap,
  });

  @override
  State<_Btn> createState() => _BtnState();
}

class _BtnState extends State<_Btn> {
  bool _h = false;
  bool _t = false;

  @override
  Widget build(BuildContext context) {
    final s = _t ? 0.88 : (_h ? 1.15 : 1.0);
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() { _h = false; _t = false; }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _t = true),
        onTapUp: (_) { setState(() => _t = false); widget.onTap(); },
        onTapCancel: () => setState(() => _t = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          width: widget.size,
          height: widget.size,
          transform: Matrix4.identity()..scale(s),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.colors,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.glow,
                blurRadius: _h ? 22 : 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(widget.icon,
              size: widget.iconSize, color: widget.iconColor),
        ),
      ),
    );
  }
}

// ──────────────────────────────────
// Side Arrow Buttons
// ──────────────────────────────────

class _ArrowBtn extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ArrowBtn({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  State<_ArrowBtn> createState() => _ArrowBtnState();
}

class _ArrowBtnState extends State<_ArrowBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          transform: Matrix4.identity()..scale(_hov ? 1.15 : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: _hov ? widget.bgColor : widget.bgColor.withOpacity(0.6),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(_hov ? 0.25 : 0.1),
                blurRadius: _hov ? 16 : 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: widget.color.withOpacity(_hov ? 0.3 : 0.12),
              width: 1.5,
            ),
          ),
          child: Icon(
            widget.icon,
            size: 28,
            color: widget.color.withOpacity(_hov ? 1.0 : 0.7),
          ),
        ),
      ),
    );
  }
}
