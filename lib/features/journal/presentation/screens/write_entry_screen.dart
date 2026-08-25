import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/journal/data/models/journal_entry_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/journal_media_model.dart';
import 'package:hybrid_tracker/features/journal/domain/providers/journal_providers.dart';
import 'package:hybrid_tracker/shared/widgets/xp_float_overlay.dart';

const _moodTags = ['😔', '😐', '🙂', '😄', '🤩'];
const _draftPrefsKey = 'ryve_journal_draft';

class WriteEntryScreen extends ConsumerStatefulWidget {
  const WriteEntryScreen({super.key, this.entryId});
  final String? entryId;

  @override
  ConsumerState<WriteEntryScreen> createState() => _WriteEntryScreenState();
}

class _WriteEntryScreenState extends ConsumerState<WriteEntryScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _moodTag;
  final List<JournalMediaModel> _pendingMedia = [];
  Timer? _autosaveTimer;
  bool _loadedExisting = false;
  late String _entryId;
  late DateTime _createdAt;

  @override
  void initState() {
    super.initState();
    _entryId = widget.entryId ?? const Uuid().v4();
    _createdAt = DateTime.now();
    if (widget.entryId == null) {
      _restoreDraft();
      _autosaveTimer = Timer.periodic(const Duration(seconds: 30), (_) => _saveDraft());
    }
  }

  Future<void> _restoreDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final draft = prefs.getString(_draftPrefsKey);
    if (draft != null && mounted) {
      _contentController.text = draft;
    }
  }

  Future<void> _saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_draftPrefsKey, _contentController.text);
  }

  Future<void> _clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftPrefsKey);
  }

  void _prefillFromExisting(JournalEntryModel entry) {
    if (_loadedExisting) return;
    _loadedExisting = true;
    _titleController.text = entry.title ?? '';
    _contentController.text = entry.content;
    _moodTag = entry.moodTag;
    _createdAt = entry.createdAt;
    _pendingMedia.addAll(entry.media);
  }

  void _wrapSelection(String token) {
    final text = _contentController.text;
    final selection = _contentController.selection;
    if (!selection.isValid) return;
    final start = selection.start;
    final end = selection.end;
    final newText = text.replaceRange(start, end, '$token${text.substring(start, end)}$token');
    _contentController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: end + token.length * 2),
    );
  }

  void _insertLinePrefix(String prefix) {
    final text = _contentController.text;
    final selection = _contentController.selection;
    final lineStart = text.lastIndexOf('\n', (selection.start - 1).clamp(0, text.length)) + 1;
    final newText = text.replaceRange(lineStart, lineStart, prefix);
    _contentController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.end + prefix.length),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (file == null) return;
    setState(() {
      _pendingMedia.add(JournalMediaModel(
        id: const Uuid().v4(),
        entryId: _entryId,
        mediaType: 'image',
        fileUrl: file.path,
        createdAt: DateTime.now(),
      ));
    });
  }

  Future<void> _save() async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    if (_contentController.text.trim().isEmpty) {
      if (mounted) context.pop();
      return;
    }
    final entry = JournalEntryModel(
      id: _entryId,
      userId: userId,
      entryDate: _createdAt,
      title: _titleController.text.trim().isEmpty ? null : _titleController.text.trim(),
      content: _contentController.text,
      moodTag: _moodTag,
      createdAt: _createdAt,
      updatedAt: DateTime.now(),
    );
    await ref
        .read(journalNotifierProvider.notifier)
        .saveEntry(entry, isNew: widget.entryId == null);
    for (final media in _pendingMedia) {
      await ref.read(journalNotifierProvider.notifier).addMedia(media);
    }
    await _clearDraft();
    if (mounted) {
      if (widget.entryId == null) XpFloatOverlay.show(context, 8);
      context.pop();
    }
  }

  @override
  void dispose() {
    _autosaveTimer?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    if (widget.entryId != null) {
      final existingAsync = ref.watch(journalEntryByIdProvider(widget.entryId!));
      existingAsync.whenData((e) {
        if (e != null) _prefillFromExisting(e);
      });
    }

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text(
          widget.entryId == null ? 'New Entry' : 'Edit Entry',
          style: AppTypography.titleLarge(onBg),
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text('Save', style: AppTypography.labelLarge(gold)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                TextField(
                  controller: _titleController,
                  style: AppTypography.titleMedium(onBg),
                  decoration: InputDecoration(
                    hintText: 'Title (optional)',
                    hintStyle: AppTypography.titleMedium(muted),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: _moodTags
                      .map((m) => Padding(
                            padding: const EdgeInsets.only(right: AppSpacing.sm),
                            child: GestureDetector(
                              onTap: () => setState(() => _moodTag = m),
                              child: Container(
                                padding: const EdgeInsets.all(AppSpacing.xs),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _moodTag == m ? gold : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Text(m, style: const TextStyle(fontSize: 22)),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _contentController,
                  style: AppTypography.bodyMedium(onBg),
                  maxLines: null,
                  minLines: 10,
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    hintStyle: AppTypography.bodyMedium(muted),
                    border: InputBorder.none,
                  ),
                ),
                if (_pendingMedia.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: _pendingMedia
                        .map((m) => ClipRRect(
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              child: Image.file(
                                File(m.fileUrl),
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
          Container(
            color: surface,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.format_bold, color: onBg),
                    onPressed: () => _wrapSelection('**'),
                  ),
                  IconButton(
                    icon: Icon(Icons.format_italic, color: onBg),
                    onPressed: () => _wrapSelection('_'),
                  ),
                  IconButton(
                    icon: Icon(Icons.format_list_bulleted, color: onBg),
                    onPressed: () => _insertLinePrefix('- '),
                  ),
                  IconButton(
                    icon: Icon(Icons.format_list_numbered, color: onBg),
                    onPressed: () => _insertLinePrefix('1. '),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.image_outlined, color: onBg),
                    onPressed: _pickImage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
