import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../../../providers/pest_detection_provider.dart';

class PestDetectionScreen extends ConsumerStatefulWidget {
  const PestDetectionScreen({super.key});

  @override
  ConsumerState<PestDetectionScreen> createState() => _PestDetectionScreenState();
}

class _PestDetectionScreenState extends ConsumerState<PestDetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImageBytes;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pestDetectionProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pest Detection'),
        actions: [
          if (state.tfliteResult != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(pestDetectionProvider.notifier).reset();
                setState(() {
                  _selectedImageBytes = null;
                  _imagePath = null;
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Model status banner ──
            if (state.modelLoadError)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'On-device model unavailable. Cloud analysis only.',
                        style: TextStyle(color: Colors.orange.shade700),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // ── Image picker ──
            _buildImagePicker(state, isDark, theme),

            const SizedBox(height: 20),

            // ── Analyze button ──
            if (_selectedImageBytes != null) ...[
              FilledButton.icon(
                onPressed: state.isAnalyzing
                    ? null
                    : () => _analyzeImage(),
                icon: state.isAnalyzing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.search),
                label: Text(state.isAnalyzing ? 'Analyzing...' : 'Analyze Plant'),
              ),
              const SizedBox(height: 20),
            ],

            // ── Error message ──
            if (state.errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage!,
                        style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ── TFLite Quick Result ──
            if (state.tfliteResult != null) ...[
              _buildTfliteResultCard(state.tfliteResult!, theme),
              const SizedBox(height: 16),
            ],

            // ── Gemini Loading Shimmer ──
            if (state.isGeminiLoading) ...[
              _buildGeminiShimmer(isDark),
              const SizedBox(height: 16),
            ],

            // ── Gemini Detailed Report ──
            if (state.geminiReport != null) ...[
              _buildGeminiReportCard(state.geminiReport!, theme),
              const SizedBox(height: 16),
            ],

            // ── Request Gemini if only TFLite result exists ──
            if (state.tfliteResult != null &&
                state.geminiReport == null &&
                !state.isGeminiLoading &&
                _selectedImageBytes != null) ...[
              OutlinedButton.icon(
                onPressed: () => _requestGeminiAnalysis(),
                icon: const Icon(Icons.cloud_upload_outlined),
                label: const Text('Get Detailed Analysis (Cloud)'),
              ),
              const SizedBox(height: 8),
              Text(
                'Uses Gemini Vision for accurate diagnosis',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker(PestDetectionState state, bool isDark, ThemeData theme) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedImageBytes != null
                ? theme.colorScheme.primary
                : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
            width: _selectedImageBytes != null ? 2 : 1,
          ),
        ),
        child: _selectedImageBytes != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.memory(
                  _selectedImageBytes!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 48,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to capture or select plant image',
                    style: TextStyle(
                      color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Camera or Gallery',
                    style: TextStyle(
                      color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTfliteResultCard(TfliteResult result, ThemeData theme) {
    final isHealthy = result.isHealthy;
    final confidence = (result.confidence * 100).toStringAsFixed(1);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isHealthy
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isHealthy ? Icons.check_circle : Icons.warning,
                    color: isHealthy ? Colors.green : Colors.orange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Detection (On-Device)',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        result.displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Confidence bar
            Row(
              children: [
                Text(
                  'Confidence: $confidence%',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: LinearProgressIndicator(
                    value: result.confidence,
                    backgroundColor: (theme.brightness == Brightness.dark)
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                    color: isHealthy
                        ? Colors.green
                        : (result.confidence > 0.7 ? Colors.orange : Colors.red),
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isHealthy
                  ? 'No disease detected by on-device model. For detailed analysis, use cloud detection below.'
                  : 'Possible disease detected. Use cloud analysis for detailed diagnosis and treatment recommendations.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeminiShimmer(bool isDark) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Shimmer.fromColors(
        baseColor: isDark ? const Color(0xFF2A2A3C) : const Color(0xFFE0E0E0),
        highlightColor: isDark ? const Color(0xFF3A3A4C) : const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 180,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity * 0.8,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity * 0.6,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity * 0.9,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeminiReportCard(String report, ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detailed Report (Cloud)',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      'Gemini Vision Analysis',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              report,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(ctx);
                _captureImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                _captureImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _captureImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (picked != null) {
        final bytes = await File(picked.path).readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
          _imagePath = picked.path;
        });
        // Auto-analyze after picking
        _analyzeImage();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImageBytes == null) return;
    await ref.read(pestDetectionProvider.notifier).analyzeImageFull(_selectedImageBytes!);
  }

  Future<void> _requestGeminiAnalysis() async {
    if (_selectedImageBytes == null) return;
    await ref.read(pestDetectionProvider.notifier).analyzeWithGemini(
          imageBytes: _selectedImageBytes!,
          language: 'english', // TODO: use user's language preference
        );
  }
}