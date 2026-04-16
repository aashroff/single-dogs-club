import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/dimensions.dart';

// ──────────────────────────────────
// "Not a Dating Site" Disclaimer
// ──────────────────────────────────

class NotADatingSiteSection extends StatelessWidget {
  const NotADatingSiteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppBreakpoints.tablet;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: isMobile ? 60 : AppSpacing.sectionLarge,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContent),
          child: isMobile
              ? Column(children: [_Image(), const SizedBox(height: 32), _Text()])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _Image()),
                    const SizedBox(width: 48),
                    Expanded(flex: 6, child: _Text()),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        image: const DecorationImage(
          image: AssetImage('assets/images/dog3.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Just to be clear, we\'re not a dating site',
          style: AppTypography.displaySmall.copyWith(
            fontStyle: FontStyle.italic,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '(well, not on purpose anyway..)',
          style: AppTypography.headlineSmall.copyWith(
            fontStyle: FontStyle.italic,
            color: AppColors.coral,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Listen, we can\'t help it if two like-minded dog owners meet '
          'via our site, fall in love and live happily ever after '
          '(We DO however expect an invitation to the wedding if that '
          'happens...)',
          style: AppTypography.bodyLarge.copyWith(height: 1.8),
        ),
        const SizedBox(height: 16),
        Text(
          'BUT that\'s not our primary aim, so you can filter whether or '
          'not you\'re open to that sort of shenanigans in your search, '
          'and you can opt to look to meet new friends as well.',
          style: AppTypography.bodyLarge.copyWith(height: 1.8),
        ),
      ],
    );
  }
}

// ──────────────────────────────────
// Contact Form Section
// ──────────────────────────────────

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppBreakpoints.tablet;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: isMobile ? 60 : AppSpacing.sectionLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDim,
        border: Border(
          top: BorderSide(color: AppColors.sage.withOpacity(0.1)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContent),
          child: isMobile
              ? Column(
                  children: [
                    _ContactImage(),
                    const SizedBox(height: 32),
                    _ContactForm(
                      nameCtrl: _nameController,
                      emailCtrl: _emailController,
                      msgCtrl: _messageController,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _ContactImage()),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 6,
                      child: _ContactForm(
                        nameCtrl: _nameController,
                        emailCtrl: _emailController,
                        msgCtrl: _messageController,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ContactImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact us', style: AppTypography.displaySmall.copyWith(
          color: AppColors.coral,
          fontStyle: FontStyle.italic,
        )),
        const SizedBox(height: 24),
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            image: const DecorationImage(
              image: AssetImage('assets/images/dog4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;

  const _ContactForm({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Text('Name', style: AppTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        )),
        const SizedBox(height: 8),
        TextField(
          controller: nameCtrl,
          decoration: const InputDecoration(hintText: 'Your name'),
        ),
        const SizedBox(height: 20),
        Text('Email address', style: AppTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        )),
        const SizedBox(height: 8),
        TextField(
          controller: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'you@example.com'),
        ),
        const SizedBox(height: 20),
        Text('Your message', style: AppTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w600,
        )),
        const SizedBox(height: 8),
        TextField(
          controller: msgCtrl,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'How can we help?',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Submit contact form
            },
            child: const Text('Submit'),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Your details won\'t be shared. Never submit passwords.',
          style: AppTypography.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textHint,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
