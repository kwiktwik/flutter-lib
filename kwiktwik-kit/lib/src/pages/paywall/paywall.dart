import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../atoms/button/button.dart';

// Dynamic Paywall component
class PaywallPage extends StatefulWidget {
  final String title;
  final String price;
  final String subtitle;
  final List<String> features;
  final String videoAssetPath;
  final bool autoPlay;
  final bool showControls;
  final String? strikePrice;
  final VoidCallback onPayNow;
  const PaywallPage({
    super.key,
    this.title = 'Unlock Premium',
    this.price = '₹99/month',
    this.subtitle = 'Cancel anytime',
    this.features = const ['Feature 1', 'Feature 2', 'Feature 3'],
    this.videoAssetPath = 'assets/telgu_paywall.mp4',
    this.autoPlay = true,
    this.showControls = true,
    this.strikePrice,
    required this.onPayNow,
  });

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        if (mounted) setState(() {});
        _controller.setLooping(true);
        if (widget.autoPlay) _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Video top (fixed height to avoid overlap)
          if (_controller.value.isInitialized)
            SizedBox(
              height: 250,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          else
            const SizedBox(height: 250, child: Center(child: CircularProgressIndicator())),
          // Content below video
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 250), // video space
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: theme.textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (widget.strikePrice != null)
                            Text(
                              widget.strikePrice!,
                              style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                            ),
                          const SizedBox(width: 8),
                          Text(widget.price, style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(widget.subtitle, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 24),
                      const Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...widget.features.map((f) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(children: [const Icon(Icons.check, size: 20), const SizedBox(width: 8), Text(f)]),
                          )),
                      const SizedBox(height: 100), // space for sticky
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Sticky full-width PayNow (visible always)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PayNow(onPay: widget.onPayNow),
          ),
          // Video controls overlay if enabled
          if (widget.showControls && _controller.value.isInitialized)
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: VideoProgressIndicator(_controller, allowScrubbing: true),
            ),
        ],
      ),
    );
  }
}

// PayNow component (big bold full-width, UPI selection, more opens sheet)
class PayNow extends StatelessWidget {
  final VoidCallback onPay;
  const PayNow({super.key, required this.onPay});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          // Preselected PhonePe
          Row(
            children: [
              const Icon(Icons.payment, size: 40),
              const SizedBox(width: 16),
              const Expanded(child: Text('PhonePe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
              const Text('Preselected', style: TextStyle(color: Colors.green)),
            ],
          ),
          const SizedBox(height: 16),
          // More options button
          GestureDetector(
            onTap: () => _showPaymentSheet(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'More UPI Options',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Big bold Pay Now
          KwikButton(
            text: 'Pay Now',
            onPressed: onPay,
          ),
        ],
      ),
    );
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(leading: Icon(Icons.payment), title: Text('PhonePe'), trailing: Text('Preselected')),
            ListTile(leading: Icon(Icons.payment), title: Text('Google Pay')),
            ListTile(leading: Icon(Icons.payment), title: Text('Paytm')),
            ListTile(leading: Icon(Icons.payment), title: Text('BHIM')),
          ],
        ),
      ),
    );
  }
}