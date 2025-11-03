/// Pest Detection Screen
/// 
/// Upload and analyze images for pest and disease detection

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class PestDetectionScreen extends ConsumerStatefulWidget {
  const PestDetectionScreen({super.key});

  @override
  ConsumerState<PestDetectionScreen> createState() => _PestDetectionScreenState();
}

class _PestDetectionScreenState extends ConsumerState<PestDetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() => _selectedImage = image);
        // TODO: Integrate with Gemini vision API
        _showAnalysisDialog();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pest Detection'),
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

            // Image Upload Options
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
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
                    onPressed: () => _pickImage(ImageSource.gallery),
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

  void _showAnalysisDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analysis Result'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detected: Aphid Infestation',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMD),
            const Text('Recommended Treatment:'),
            const SizedBox(height: AppDimensions.paddingSM),
            const Text('• Use neem oil spray'),
            const Text('• Apply insecticidal soap'),
            const Text('• Introduce ladybugs'),
            const SizedBox(height: AppDimensions.paddingMD),
            Text(
              'Note: This is a demo. AI integration coming soon!',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.info,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
