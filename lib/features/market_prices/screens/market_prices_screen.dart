/// Market Prices Screen
/// 
/// Display real-time crop market prices and trends

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class MarketPricesScreen extends ConsumerWidget {
  const MarketPricesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Prices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter options coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('Today\'s Crop Prices', style: AppTextStyles.h3),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Real-time market prices for major crops',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLG),

            // Price List
            _buildPriceCard(
              cropName: 'Rice',
              currentPrice: '₹2,150',
              priceChange: '+5.2%',
              isPositive: true,
              unit: 'per quintal',
            ),
            _buildPriceCard(
              cropName: 'Wheat',
              currentPrice: '₹1,950',
              priceChange: '-2.1%',
              isPositive: false,
              unit: 'per quintal',
            ),
            _buildPriceCard(
              cropName: 'Cotton',
              currentPrice: '₹6,200',
              priceChange: '+8.5%',
              isPositive: true,
              unit: 'per quintal',
            ),
            _buildPriceCard(
              cropName: 'Sugarcane',
              currentPrice: '₹3,100',
              priceChange: '+1.8%',
              isPositive: true,
              unit: 'per quintal',
            ),
            _buildPriceCard(
              cropName: 'Maize',
              currentPrice: '₹1,750',
              priceChange: '-0.5%',
              isPositive: false,
              unit: 'per quintal',
            ),
            _buildPriceCard(
              cropName: 'Soybean',
              currentPrice: '₹4,500',
              priceChange: '+3.2%',
              isPositive: true,
              unit: 'per quintal',
            ),

            const SizedBox(height: AppDimensions.paddingLG),

            // Info Banner
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.info),
                  const SizedBox(width: AppDimensions.paddingMD),
                  Expanded(
                    child: Text(
                      'Prices are indicative and may vary by location. Contact local mandis for accurate rates.',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard({
    required String cropName,
    required String currentPrice,
    required String priceChange,
    required bool isPositive,
    required String unit,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMD),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        child: Row(
          children: [
            // Crop Icon
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              ),
              child: Icon(Icons.agriculture, color: AppColors.success),
            ),
            const SizedBox(width: AppDimensions.paddingMD),

            // Crop Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cropName, style: AppTextStyles.bodyLarge),
                  Text(
                    unit,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Price Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currentPrice,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSM,
                    vertical: AppDimensions.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositive ? AppColors.success : AppColors.error)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                  ),
                  child: Text(
                    priceChange,
                    style: AppTextStyles.caption.copyWith(
                      color: isPositive ? AppColors.success : AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
