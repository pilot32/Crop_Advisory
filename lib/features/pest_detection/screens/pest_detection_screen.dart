/// Pest Detection Screen
///
/// Upload and analyze images for pest and disease detection


import 'package:crop_advisory/core/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/pest_detection_provider.dart';

class PestDetectionScreen extends ConsumerStatefulWidget {
  const PestDetectionScreen({super.key});

  @override
  ConsumerState<PestDetectionScreen> createState() => _PestDetectionScreenState();
}

class _PestDetectionScreenState extends ConsumerState<PestDetectionScreen> {
  Future<void> _pickImage(ImageSource source) async {
    // Let the provider handle picking the image
    await ref.read(pestDetectionProvider.notifier).pickImage(source);
    
    // Automatically trigger analysis if an image was selected
    if (ref.read(pestDetectionProvider).selectedImage != null) {
      ref.read(pestDetectionProvider.notifier).analyzeImage();
    }
  }

  void _reset() {
    ref.read(pestDetectionProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pestDetectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pest Detection'),
        actions: [
          if (state.selectedImage != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _reset,
              tooltip: 'Reset',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('Identify Pests & Diseases', style: AppTextStyles.h3),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Take or upload a photo of the affected plant for AI-powered pest identification.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXL),

            // ========== IMAGE PREVIEW ==========
            if (state.selectedImage != null) ...[
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                  child: Image.network(
                    state.selectedImage!.path,
                    fit: BoxFit.cover,
                     errorBuilder: (_, __, ___) => const Center(
    child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),)
                ),
              ),
              const SizedBox(height: AppDimensions.paddingMD),

              // ========== LOADING STATE ==========
                            // ========== LOADING STATE ==========
              if (state.isAnalyzing) ...[
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingLG),
                  child: Column(
                    children: [
                      const LinearProgressIndicator(),
                      const SizedBox(height: AppDimensions.paddingMD),
                      Text(
                        'Analyzing your plant image...',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingMD),
                      // Shimmer skeleton for result preview
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimensions.paddingMD),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  ShimmerBox(width: 150, height: 18),
                                  ShimmerBox(width: 50, height: 24),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const ShimmerBox(width: 80, height: 16),
                              const SizedBox(height: 12),
                              const ShimmerBox(width: double.infinity, height: 14),
                              const SizedBox(height: 8),
                              const ShimmerBox(width: double.infinity, height: 14),
                              const SizedBox(height: 8),
                              const ShimmerBox(width: 200, height: 14),
                              const SizedBox(height: 16),
                              const ShimmerBox(width: double.infinity, height: 60),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppDimensions.paddingXL),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: AppDimensions.paddingMD),
                        Text('Analyzing your plant image...'),
                      ],
                    ),
                  ),
                ),
              ]

              // ========== ERROR STATE ==========
              else if (state.errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingMD),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error),
                      const SizedBox(width: AppDimensions.paddingSM),
                      Expanded(
                        child: Text(
                          state.errorMessage!,
                          style: AppTextStyles.body.copyWith(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingMD),
              ]

              // ========== RESULT DISPLAY ==========
              else if (state.detectionResult != null) ...[
                _buildResultCard(state.detectionResult!),
                const SizedBox(height: AppDimensions.paddingMD),
              ],

              const SizedBox(height: AppDimensions.paddingSM),
            ],

            // ========== PICK BUTTONS ==========
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.isAnalyzing ? null : () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(AppDimensions.paddingMD),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMD),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: state.isAnalyzing ? null : () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(AppDimensions.paddingMD),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingXL),

            // Info Cards
            Text('Common Pests & Diseases', style: AppTextStyles.h4),
            const SizedBox(height: AppDimensions.paddingMD),
            _buildPestCard(
              title: 'Aphids',
              description: 'Small insects that suck plant sap',
              icon: Icons.bug_report,
            ),
            _buildPestCard(
              title: 'Leaf Blight',
              description: 'Fungal disease causing leaf spots',
              icon: Icons.local_florist,
            ),
            _buildPestCard(
              title: 'Root Rot',
              description: 'Root disease from excess moisture',
              icon: Icons.grass,
            ),
          ],
        ),
      ),
    );
  }

  // ========== REAL RESULT CARD (replaces hardcoded dialog) ==========
  Widget _buildResultCard(result) {
    // Extract values safely
    final name = result.pestOrDiseaseName ?? 'Unknown';
    final confidence = result.confidence ?? 0.0;
    final severity = result.severity ?? 'Unknown';
    final description = result.description ?? 'No description available';
    final symptoms = result.symptoms ?? [];
    final treatments = result.treatments ?? [];

    // Severity color
    Color severityColor;
    switch (severity.toLowerCase()) {
      case 'high':
        severityColor = AppColors.error;
        break;
      case 'medium':
        severityColor = Colors.orange;
        break;
      default:
        severityColor = AppColors.success;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Disease name + confidence
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: AppTextStyles.h4.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSM,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: severityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                  ),
                  child: Text(
                    '${(confidence * 100).toStringAsFixed(1)}%',
                    style: AppTextStyles.caption.copyWith(
                      color: severityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSM),

            // Severity badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSM,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: severityColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
              ),
              child: Text(
                'Severity: $severity',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMD),

            // Description
            Text('Description', style: AppTextStyles.bodyLarge),
            const SizedBox(height: 4),
            Text(description, style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
            )),
            const SizedBox(height: AppDimensions.paddingMD),

            // Symptoms
            if (symptoms.isNotEmpty) ...[
              Text('Symptoms', style: AppTextStyles.bodyLarge),
              const SizedBox(height: 4),
              ...symptoms.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: AppTextStyles.body),
                    Expanded(child: Text(s, style: AppTextStyles.body)),
                  ],
                ),
              )),
              const SizedBox(height: AppDimensions.paddingMD),
            ],

            // Treatments
            if (treatments.isNotEmpty) ...[
              Text('Recommended Treatment', style: AppTextStyles.bodyLarge),
              const SizedBox(height: 4),
              ...treatments.map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingSM),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.name ?? '', style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                      if (t.description != null)
                        Text(t.description!, style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        )),
                    ],
                  ),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPestCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMD),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingSM),
          decoration: BoxDecoration(
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          child: Icon(icon, color: AppColors.error),
        ),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}