import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "Join the early wlthy list" (Figma 213:154): intro on the left, a light
/// form with label-above underline fields and a taupe CTA on the right.
class WaitlistSection extends StatefulWidget {
  const WaitlistSection({super.key});

  @override
  State<WaitlistSection> createState() => _WaitlistSectionState();
}

class _WaitlistSectionState extends State<WaitlistSection> {
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();
  bool _consent = false;
  bool _submitting = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final firstName = _firstNameController.text.trim();
    final email = _emailController.text.trim();
    final country = _countryController.text.trim();

    if (firstName.isEmpty || email.isEmpty || country.isEmpty) {
      _alert('Please fill in all fields.');
      return;
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      _alert('Please enter a valid email address.');
      return;
    }
    if (!_consent) {
      _alert('Please agree to receive wlthy updates to join the waitlist.');
      return;
    }

    setState(() => _submitting = true);
    try {
      final normalizedEmail = email.toLowerCase();
      final waitlist = FirebaseFirestore.instance.collection('waitlist');
      final existing =
          await waitlist.where('email', isEqualTo: normalizedEmail).limit(1).get();

      if (existing.docs.isNotEmpty) {
        _alert("You're already on the waitlist!");
        return;
      }

      await waitlist.add({
        'firstName': firstName,
        'email': normalizedEmail,
        'country': country,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _firstNameController.clear();
      _emailController.clear();
      _countryController.clear();
      setState(() => _consent = false);
      _alert("You've been added to the waitlist!");
    } catch (e) {
      _alert('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _alert(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      background: AppColors.cream,
      child: ResponsiveLayout(
        mobile: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_intro(context), const SizedBox(height: 32), _form(context)],
        ),
        desktop: (_) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 350, child: _intro(context)),
            const SizedBox(width: 160),
            Expanded(flex: 6, child: _form(context)),
          ],
        ),
      ),
    );
  }

  Widget _intro(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(Waitlist.title, style: FigmaText.h2(AppColors.ink)),
          const SizedBox(height: 12),
          WlthyText(Waitlist.body,
              style: FigmaText.cardBody(const Color(0xFF5C5C58))),
          const SizedBox(height: 14),
          WlthyText(Waitlist.disclaimer,
              style: FigmaText.fineprintInter9(const Color(0xFF9C9C97))),
        ],
      );

  Widget _form(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          const gap = 28.0;
          // All three fields share one width: half the form column on desktop,
          // full width on mobile.
          final fieldW = context.isMobile
              ? constraints.maxWidth
              : (constraints.maxWidth - gap) / 2;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: gap,
                runSpacing: 20,
                children: [
                  SizedBox(
                      width: fieldW,
                      child: _field('First name', _firstNameController)),
                  SizedBox(
                      width: fieldW,
                      child: _field('Email address', _emailController,
                          keyboardType: TextInputType.emailAddress)),
                  SizedBox(
                      width: fieldW,
                      child:
                          _field('Country of residence', _countryController)),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => setState(() => _consent = !_consent),
                      child: Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: _consent ? AppColors.taupe : AppColors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: AppColors.hairline),
                        ),
                        child: _consent
                            ? const Icon(Icons.check,
                                size: 11, color: AppColors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: WlthyText(Waitlist.consent,
                        style:
                            FigmaText.fineprintInter9b(const Color(0xFF9C9C97))),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _taupeButton(_submitting ? 'Joining…' : Waitlist.cta,
                  onTap: _submitting ? null : _submit),
            ],
          );
        },
      );

  Widget _field(String label, TextEditingController controller,
          {TextInputType? keyboardType}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(label, style: FigmaText.fieldLabel(const Color(0xFF5C5C58))),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppType.sans(
                const TextStyle(fontSize: 14, color: AppColors.ink)),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.hairline),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.ink),
              ),
            ),
          ),
        ],
      );

  Widget _taupeButton(String label, {VoidCallback? onTap}) => MouseRegion(
        cursor: onTap == null
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.taupe.withValues(alpha: onTap == null ? 0.6 : 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: WlthyText(label, style: FigmaText.button(AppColors.white)),
          ),
        ),
      );
}
