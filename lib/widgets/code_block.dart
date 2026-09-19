import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

class CodeBlock extends StatefulWidget {
  final String code;

  const CodeBlock({super.key, required this.code});

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code.trim()));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: AppTheme.codeBackground, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header bar
          _Header(copied: _copied, onCopy: _copy),
          // Code content
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SelectableText(
              widget.code.trim(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.5,
                height: 1.6,
                color: AppTheme.codeForeground,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool copied;
  final VoidCallback onCopy;

  const _Header({required this.copied, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(
            'dart',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: AppTheme.codeComment, letterSpacing: 0.5),
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: copied
                ? _iconChip(Icons.check, l10n.codeCopied, const Color(0xFF4CAF50))
                : _iconChip(Icons.copy_rounded, l10n.codeCopy, AppTheme.codeComment),
          ),
        ],
      ),
    );
  }

  Widget _iconChip(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: copied ? null : onCopy,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}
