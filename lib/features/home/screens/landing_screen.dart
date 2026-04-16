import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/strings.dart';
import '../../../core/widgets/sdc_button.dart';
import '../../../core/widgets/section_header.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/features_section.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/about_section.dart';
import '../widgets/cta_section.dart';
import '../widgets/landing_nav_bar.dart';
import '../widgets/landing_footer.dart';
import '../widgets/search_your_way_section.dart';
import '../widgets/extra_sections.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _scrollController = ScrollController();

  // Section keys for scroll targeting
  final _howItWorksKey = GlobalKey();
  final _featuresKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = switch (section) {
      'How It Works' => _howItWorksKey,
      'Features' => _featuresKey,
      'About' => _aboutKey,
      'Contact' => _contactKey,
      _ => null,
    };
    if (key?.currentContext == null) return;

    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero with integrated tagline and swipe demo
              const SliverToBoxAdapter(child: SizedBox(height: 72)),
              SliverToBoxAdapter(child: HeroSection()),
              const SliverToBoxAdapter(child: _StatsBar()),
              SliverToBoxAdapter(
                child: HowItWorksSection(key: _howItWorksKey),
              ),
              // Search Your Way
              const SliverToBoxAdapter(child: SearchYourWaySection()),
              SliverToBoxAdapter(
                child: FeaturesSection(key: _featuresKey),
              ),
              const SliverToBoxAdapter(child: TestimonialsSection()),
              // Not a dating site disclaimer
              const SliverToBoxAdapter(child: NotADatingSiteSection()),
              SliverToBoxAdapter(
                child: AboutSection(key: _aboutKey),
              ),
              SliverToBoxAdapter(
                child: CtaSection(key: _contactKey),
              ),
              // Contact form
              const SliverToBoxAdapter(child: ContactFormSection()),
              const SliverToBoxAdapter(child: LandingFooter()),
            ],
          ),
          // Floating nav bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LandingNavBar(onNavTap: _scrollToSection),
          ),
        ],
      ),
    );
  }
}

class _StatsBar extends StatelessWidget {
  const _StatsBar();

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('2,400+', 'Dogs Registered'),
      ('850+', 'Matches Made'),
      ('15K+', 'Walks Logged'),
      ('4.9\u2605', 'App Rating'),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.mobile;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.xxxl),
        constraints: const BoxConstraints(maxWidth: 900),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppSpacing.xl : 40,
          vertical: 28,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColors.sage.withOpacity(0.1),
          ),
        ),
        child: Wrap(
          spacing: 40,
          runSpacing: 20,
          alignment: WrapAlignment.spaceAround,
          children: stats.map((s) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(s.$1, style: AppTypography.headlineLarge.copyWith(
                  color: AppColors.coral,
                )),
                const SizedBox(height: 4),
                Text(s.$2, style: AppTypography.bodySmall),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
