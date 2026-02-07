import 'package:flutter/material.dart';
import '../../atoms/button/button.dart';
import '../../atoms/safe_area/safe_area.dart';

/// Onboarding chat component (configurable flow)
/// Props:
/// - questions: List of question maps {question, type: text/select, options?}
/// - onComplete: Callback with collected answers Map
/// - redirectTo: Optional widget to navigate after (default home)
/// Usage example: OnboardingPage(questions: [...], onComplete: (answers) => print(answers))
class OnboardingPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final ValueChanged<Map<String, String>> onComplete;
  final Widget? redirectTo;
  const OnboardingPage({
    super.key,
    required this.questions,
    required this.onComplete,
    this.redirectTo,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<Map<String, String>> _chatHistory = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentQuestionIndex = 0;
  // ignore: prefer_final_fields
  Map<String, String> _answers = {};

  @override
  void initState() {
    super.initState();
    // Start with first bot question
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _chatHistory.add({'bot': widget.questions[0]['question'] as String});
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendAnswer(String answer) {
    final q = widget.questions[_currentQuestionIndex];
    _answers[q['question'] as String] = answer;
    setState(() {
      _chatHistory.add({'user': answer});
    });
    _scrollToBottom();
    _inputController.clear();
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() => _currentQuestionIndex++);
      // Next bot question
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _chatHistory.add({'bot': widget.questions[_currentQuestionIndex]['question'] as String});
          });
          _scrollToBottom();
        }
      });
    } else {
      widget.onComplete(_answers);
      final redirect = widget.redirectTo ?? const Center(child: Text('Onboarding Complete'));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => redirect));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentQ = widget.questions[_currentQuestionIndex];
    final isSelect = currentQ['type'] == 'select';
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Onboarding Chat')),
      body: KwikSafeArea(
        child: Column(
          children: [
            // Scrollable middle chat history (WhatsApp style bottom-up)
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true, // new messages at bottom
                padding: const EdgeInsets.all(16),
                itemCount: _chatHistory.length,
                itemBuilder: (context, i) {
                  final msg = _chatHistory[_chatHistory.length - 1 - i]; // reverse index
                  final isUser = msg.containsKey('user');
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? theme.primaryColor : theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(msg.values.first, style: isUser ? const TextStyle(color: Colors.white) : null),
                    ),
                  );
                },
              ),
            ),
            // Bottom input or select actions
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.scaffoldBackgroundColor,
              child: isSelect
                  ? Row(
                      children: (currentQ['options'] as List<String>)
                          .map((opt) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: KwikButton(
                                    text: opt,
                                    onPressed: () => _sendAnswer(opt),
                                  ),
                                ),
                              ))
                          .toList(),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _inputController,
                            decoration: const InputDecoration(hintText: 'Type answer...'),
                            onSubmitted: _sendAnswer,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () => _sendAnswer(_inputController.text),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}