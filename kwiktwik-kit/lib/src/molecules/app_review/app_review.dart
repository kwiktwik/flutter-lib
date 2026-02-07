import 'package:flutter/material.dart';
import 'package:kwiktwik_kit/kwiktwik_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class KwikAppReview extends StatefulWidget {
  final int highRatingThreshold;
  final VoidCallback? onHighRating;
  final ValueChanged<int>? onLowRating;
  final String? storeUrl;
  const KwikAppReview({
    super.key,
    this.highRatingThreshold = 4,
    this.onHighRating,
    this.onLowRating,
    this.storeUrl,
  });

  @override
  State<KwikAppReview> createState() => _KwikAppReviewState();
}

class _KwikAppReviewState extends State<KwikAppReview> {
  int _rating = 0;

  void _submitRating() {
    Navigator.pop(context);
    if (_rating >= widget.highRatingThreshold) {
      widget.onHighRating?.call();
      if (widget.storeUrl != null) {
        launchUrl(Uri.parse(widget.storeUrl!));
      }
    } else {
      widget.onLowRating?.call(_rating);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Rate Our App', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              return IconButton(
                icon: Icon(
                  starIndex <= _rating ? Icons.star : Icons.star_border,
                  color: theme.primaryColor,
                ),
                onPressed: () => setState(() => _rating = starIndex),
              );
            }),
          ),
          const SizedBox(height: 16),
          KwikButton(text: 'Submit', onPressed: _submitRating),
        ],
      ),
    );
  }
}

// Helper to show rating bottom sheet
void showAppReviewBottomSheet(
  BuildContext context, {
  int highRatingThreshold = 4,
  VoidCallback? onHighRating,
  ValueChanged<int>? onLowRating,
  String? storeUrl,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => KwikAppReview(
      highRatingThreshold: highRatingThreshold,
      onHighRating: onHighRating,
      onLowRating: onLowRating,
      storeUrl: storeUrl,
    ),
  );
}