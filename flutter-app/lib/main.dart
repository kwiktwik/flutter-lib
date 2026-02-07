import 'package:flutter/material.dart';
import 'package:kwiktwik_kit/kwiktwik_kit.dart';

void main() {
  runApp(const MyApp());
}

// Theme state holder for runtime changes (supports 7+ variants)
class ThemeController extends ChangeNotifier {
  ThemeVariant _variant = ThemeVariant.blue;
  Brightness _brightness = Brightness.light;

  ThemeVariant get variant => _variant;
  Brightness get brightness => _brightness;

  void toggleTheme() {
    _brightness = _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  void setVariant(ThemeVariant variant) {
    _variant = variant;
    notifyListeners();
  }

  void setBrightness(Brightness brightness) {
    _brightness = brightness;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController();

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeController,
      builder: (context, child) {
        final themeData = KwikTheme.getTheme(_themeController.variant, _themeController.brightness);
        return MaterialApp(
          title: 'KwikTwik Kit Demo',
          theme: themeData,
          darkTheme: themeData,
          themeMode: ThemeMode.system, // overridden by our controller
          home: MyHomePage(themeController: _themeController),
        );
      },
    );
  }
}

// Component in flutter-app to consume/select tokens (7 variants) with radios for runtime adapt
class KwikThemeSelector extends StatelessWidget {
  final ThemeController controller;
  const KwikThemeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final tokens = KwikColorTokens.getColors(controller.variant, controller.brightness);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Design Tokens', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text('Variant: ${controller.variant}', style: Theme.of(context).textTheme.bodySmall),
            Text('Primary: ${tokens.primary}', style: Theme.of(context).textTheme.bodySmall),
            Text('Background: ${tokens.background}', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            // Radios for 7 theme variants
            Column(
              children: ThemeVariant.values
                  .map((variant) => Row(
                        children: [
                          // ignore: deprecated_member_use
                          Radio<ThemeVariant>(
                            value: variant,
                            // ignore: deprecated_member_use
                            groupValue: controller.variant,
                            // ignore: deprecated_member_use
                            onChanged: (val) => controller.setVariant(val!),
                          ),
                          Text(variant.name),
                        ],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => controller.setBrightness(Brightness.light),
                  child: const Text('Light'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => controller.setBrightness(Brightness.dark),
                  child: const Text('Dark'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom tab theme component (uses controlled KwikBottomNav to show theme selector screen with radios)
class KwikThemeBottomTab extends StatefulWidget {
  final ThemeController controller;
  const KwikThemeBottomTab({super.key, required this.controller});

  @override
  State<KwikThemeBottomTab> createState() => _KwikThemeBottomTabState();
}

class _KwikThemeBottomTabState extends State<KwikThemeBottomTab> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Themes'),
      const BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'UI Elements'),
      const BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Masonry'),
      const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Onboarding'),
    ];
    final pages = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Tab - Components adapt to selected theme',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            // Button to trigger review popup
            KwikButton(
              text: 'Rate Our App',
              onPressed: () => showAppReviewBottomSheet(
                context,
                highRatingThreshold: 4,
                onHighRating: () {
                  // Example: high rating logic (hide popup, open store)
                  // copy rating if possible (simulated)
                },
                onLowRating: (rating) {
                  // Example: low rating logic (get feedback, post to backend)
                  // simulated
                  // ignore: avoid_print
                  print('Low rating $rating - send feedback to backend');
                },
                storeUrl: 'https://play.google.com/store/apps/details?id=com.example.flutter_app&reviewId=0',
              ),
            ),
            const SizedBox(height: 10),
            // Button to test Paywall
            KwikButton(
              text: 'Show Paywall',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SafeArea(child: PaywallPage(
                    title: 'KwikTwik Premium',
                    price: '₹199/year',
                    subtitle: 'Ad-free + Exclusive',
                    features: const [
                      '🔔 Instant voice alerts',
                      '📱 Works with all UPI apps',
                      '🚫 100% ad-free',
                      '📊 Daily collection summary',
                    ],
                    videoAssetPath: 'assets/telgu_paywall.mp4',
                    autoPlay: true,
                    showControls: true,
                    strikePrice: '₹299/year',
                    onPayNow: () {
                      // ignore: avoid_print
                      print('Pay now clicked - process payment');
                    },
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
      Center(child: KwikThemeSelector(controller: widget.controller)),
      const UiElementsPage(),
      // Masonry page (data from app)
      MasonryPage(
        imagePaths: const [
          'assets/1.webp',
          'assets/2.webp',
          'assets/3.webp',
          'assets/4.webp',
          'assets/5.webp',
        ],
      ),
      // Onboarding chat demo (configurable, ends redirect to home)
      OnboardingPage(
        questions: const [
          {'question': 'What is your name?', 'type': 'text'},
          {'question': 'What is your age?', 'type': 'text'},
          {'question': 'What is your gender?', 'type': 'select', 'options': ['Male', 'Female']},
          {'question': 'Where do you live?', 'type': 'text'},
        ],
        onComplete: (answers) {
          // ignore: avoid_print
          print('Onboarding complete: $answers');
        },
        redirectTo: const Center(child: Text('Welcome to Home!')),
      ),
    ];
    return Scaffold(
      body: KwikSafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: KwikBottomNav(
        items: items,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ThemeController themeController;
  const MyHomePage({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return KwikThemeBottomTab(controller: themeController);
  }
}
