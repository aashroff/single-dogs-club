import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/widgets/app_logo.dart';

class LandingNavBar extends StatefulWidget {
  final void Function(String section)? onNavTap;

  const LandingNavBar({super.key, this.onNavTap});

  @override
  State<LandingNavBar> createState() => _LandingNavBarState();
}

class _LandingNavBarState extends State<LandingNavBar> {
  double _scrollOffset = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Listen to scroll notifications from parent.
  }

  bool get _isScrolled => _scrollOffset > 60;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() => _scrollOffset = notification.metrics.pixels);
        }
        return false;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _isScrolled
              ? AppColors.cream.withOpacity(0.92)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: _isScrolled
                  ? AppColors.coral.withOpacity(0.08)
                  : Colors.transparent,
            ),
          ),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: _isScrolled
                ? ColorFilter.mode(
                    Colors.white.withOpacity(0.1), BlendMode.srcOver)
                : ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: AppBreakpoints.desktop),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.lg,
                    ),
                    child: Row(
                      children: [
                        // Logo
                        _Logo(),
                        const Spacer(),
                        // Nav links (hidden on mobile)
                        if (MediaQuery.of(context).size.width >
                            AppBreakpoints.mobile) ...[
                          ..._navItems.map((item) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                child: _NavLink(
                                  label: item,
                                  onTap: () => widget.onNavTap?.call(item),
                                ),
                              )),
                          const SizedBox(width: 8),
                        ],
                        // CTA
                        _JoinButton(
                          onTap: () => context.go('/register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const _navItems = ['How It Works', 'Features', 'About', 'Contact'];

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AppLogo(size: 42, showText: true);
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const _NavLink({required this.label, this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTypography.labelMedium.copyWith(
            color: _hovering ? AppColors.coral : AppColors.textSecondary,
            fontSize: 14,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _JoinButton extends StatefulWidget {
  final VoidCallback onTap;

  const _JoinButton({required this.onTap});

  @override
  State<_JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<_JoinButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..translate(0.0, _hovering ? -2.0 : 0.0),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.coralGradient,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            boxShadow: [
              BoxShadow(
                color: AppColors.coral.withOpacity(_hovering ? 0.4 : 0.3),
                blurRadius: _hovering ? 20 : 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'Join Free',
            style: AppTypography.labelMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
