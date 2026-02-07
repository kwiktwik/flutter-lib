import 'package:flutter/material.dart';
import '../../atoms/button/button.dart';
import '../../atoms/input/input.dart';

class KwikForm extends StatelessWidget {
  const KwikForm({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.scaffoldBackgroundColor,
      child: Column(children: [KwikInput(hint: 'Name'), KwikButton(text: 'Submit', onPressed: (){})]),
    );
  }
}