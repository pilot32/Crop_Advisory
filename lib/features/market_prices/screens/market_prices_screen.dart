/// Market Prices Screen
///
/// Displays real-time crop market prices from AGMARKNET (data.gov.in).
/// Features:
/// - Commodity selection with horizontal scrollable chips
/// - State/market filtering
/// - Price trend indicators
/// - AI-powered market advice via Gemini
/// - Pull-to-refresh support
/// - Responsive cards with min/max/modal prices
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/market_price_provider.dart';
import '../../../models/market_price_model.dart';

class MarketPricesScreen extends ConsumerStatefulWidget {
  const MarketPricesScreen({super.key});

  @override
  ConsumerState<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends ConsumerState<MarketPricesScreen> {
  @override
  void initState() {
    super.initState();
    // Initial data fetch is triggered by the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(marketPricesProvider.notifier).fetchPrices();
      ref.read(marketPricesProvider.notifier).fetchPriceTrend();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(marketPricesProvider);
    final commodities = ref.watch(commodityListProvider);
    final states = ref.watch(stateListProvider);
    final currencyFormat = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 0,
      locale: 'en_IN',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Prices'),
        actions: [
          // State filter button
          PopupMenuButton<String>(
            icon: const Icon(Icons.location_on_outlined),
            tooltip: 'Filter by State',
            onSelected: (selectedState) {
              ref.read(marketPricesProvider.notifier).selectState(selectedState);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: '__clear__',
                child: Row(
                  children: [
                    Icon(Icons.clear, size: 18, color: AppColors.error),
                    SizedBox(width: 8),
                    Text('Clear Filter', style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              ...states.map((s) => PopupMenuItem(
                    value: s,
                    child: Row(
                      children: [
                        Icon(
                          state.selectedState == s
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          size: 18,
                          color: state.selectedState == s
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(s),
                      ],
                    ),
                  )),
            ],
          ),
          // AI advice button
          IconButton(
            icon: const Icon(Icons.auto_awesome_outlined),
            tooltip: 'Get AI Market Advice',
            onPressed: state.aiAdvice != null
                ? () => _showAiAdviceSheet(context, state.aiAdvice!)
                : () {
                    if (!state.isAdviceLoading) {
                      ref.read(marketPricesProvider.notifier).fetchAiAdvice();
                    }
                  },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(marketPricesProvider.notifier).refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Trend Summary Card ----
              if (state.priceTrend != null) _buildTrendCard(state, currencyFormat),
              const SizedBox(height: AppDimensions.paddingMD),

              // ---- Commodity Selection Chips ----
              _buildSectionHeader('Select Commodity'),
              const SizedBox(height: AppDimensions.paddingSM),
              _buildCommodityChips(commodities, state.selectedCommodity),
              const SizedBox(height: AppDimensions.paddingMD),

              // ---- State Filter Badge ----
              if (state.selectedState != null) _buildStateFilterBadge(state, ref),
              if (state.selectedState != null) const SizedBox(height: AppDimensions.paddingSM),

              // ---- AI Advice Banner ----
              if (state.isAdviceLoading) _buildLoadingAdviceBanner(),
              if (state.aiAdvice != null && !state.isAdviceLoading)
                _buildAiAdvicePreview(state.aiAdvice!),
              const SizedBox(height: AppDimensions.paddingMD),

              // ---- Price List ----
              if (state.isLoading)
                _buildLoadingState()
              else if (state.errorMessage != null)
                _buildErrorState(state.errorMessage!)
              else if (state.prices.isEmpty)
                _buildEmptyState()
              else
                _buildPriceList(state.prices, currencyFormat),

              const SizedBox(height: AppDimensions.paddingLG),

              // ---- Info Banner ----
              _buildInfoBanner(),
            ],
          ),
        ),
      ),
      // FAB to trigger AI advice
      floatingActionButton: state.aiAdvice == null && !state.isAdviceLoading
          ? FloatingActionButton.extended(
              onPressed: state.prices.isNotEmpty
                  ? () => ref.read(marketPricesProvider.notifier).fetchAiAdvice()
                  : null,
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.auto_awesome, color: AppColors.textLight),
              label: const Text(
                'AI Market Advice',
                style: TextStyle(color: AppColors.textLight),
              ),
            )
          : null,
    );
  }

  // ============================================================================
  // TREND CARD
  // ============================================================================

  Widget _buildTrendCard(MarketPricesState state, NumberFormat currencyFormat) {
    final trend = state.priceTrend!;
    final isRising = trend.trend == 'rising';
    final isFalling = trend.trend == 'falling';
    final color = isRising
        ? AppColors.success
        : isFalling
            ? AppColors.error
            : AppColors.warning;
    final icon = isRising
        ? Icons.trending_up
        : isFalling
            ? Icons.trending_down
            : Icons.trending_flat;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMD),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: AppDimensions.paddingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.selectedCommodity} Price Trend',
                  style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '7-day trend: ${trend.trend?.toUpperCase()} (${trend.percentageChange != null ? (trend.percentageChange! > 0 ? '+' : '') + '${trend.percentageChange}%' : 'N/A'})',
                  style: AppTextStyles.bodyMedium.copyWith(color: color),
                ),
                if (trend.priceHistory.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildMiniTrendChart(trend, currencyFormat, color),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// A simple inline mini chart showing price points
  Widget _buildMiniTrendChart(PriceTrend trend, NumberFormat format, Color color) {
    if (trend.priceHistory.length < 2) return const SizedBox.shrink();

    final prices = trend.priceHistory.map((p) => p.price).toList();
    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    final chartHeight = 40.0;

    return SizedBox(
      height: chartHeight + 16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(
              height: chartHeight,
              child: CustomPaint(
                painter: _TrendLinePainter(
                  prices: prices,
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(format.format(maxPrice), style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
              Text(format.format(minPrice), style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // COMMODITY CHIPS
  // ============================================================================

  Widget _buildSectionHeader(String title) {
    return Text(title, style: AppTextStyles.h4);
  }

  Widget _buildCommodityChips(
      List<Map<String, String>> commodities, String selectedCommodity) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: commodities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final commodity = commodities[index];
          final isSelected = commodity['name'] == selectedCommodity;

          return _CommodityChip(
            name: commodity['name']!,
            emoji: commodity['emoji']!,
            isSelected: isSelected,
            onTap: () {
              ref.read(marketPricesProvider.notifier).selectCommodity(commodity['name']!);
            },
          );
        },
      ),
    );
  }

  // ============================================================================
  // STATE FILTER BADGE
  // ============================================================================

  Widget _buildStateFilterBadge(MarketPricesState state, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSM,
        vertical: AppDimensions.paddingXS,
      ),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, size: 14, color: AppColors.info),
          const SizedBox(width: 4),
          Text(
            'Filtered: ${state.selectedState}',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.info,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => ref.read(marketPricesProvider.notifier).clearStateFilter(),
            child: Icon(Icons.close, size: 14, color: AppColors.info),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // AI ADVICE
  // ============================================================================

  Widget _buildLoadingAdviceBanner() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          SizedBox(width: AppDimensions.paddingMD),
          Expanded(
            child: Text(
              'Generating AI market advice...',
              style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiAdvicePreview(String advice) {
    return InkWell(
      onTap: () => _showAiAdviceSheet(context, advice),
      borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMD),
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
              ),
              child: const Icon(Icons.auto_awesome, color: AppColors.accent, size: 20),
            ),
            const SizedBox(width: AppDimensions.paddingMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Market Analysis Ready',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    advice.length > 120 ? '${advice.substring(0, 120)}...' : advice,
                    style: AppTextStyles.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.accent),
          ],
        ),
      ),
    );
  }

  void _showAiAdviceSheet(BuildContext context, String advice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(AppDimensions.paddingLG),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppDimensions.paddingMD),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.accent),
                  const SizedBox(width: 8),
                  Text('AI Market Advice', style: AppTextStyles.h4),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingMD),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: SelectableText(
                    advice,
                    style: AppTextStyles.bodyLarge.copyWith(height: 1.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // PRICE LIST
  // ============================================================================

  Widget _buildLoadingState() {
    return Column(
      children: List.generate(
        5,
        (index) => _buildShimmerCard(index),
      ),
    );
  }

    Widget _buildShimmerCard(int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[600]! : Colors.grey[100]!,
      child: Card(
        margin: const EdgeInsets.only(bottom: AppDimensions.paddingMD),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 80,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 60,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 40,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          children: [
            Icon(Icons.cloud_off, size: 64, color: AppColors.textSecondary.withOpacity(0.5)),
            const SizedBox(height: AppDimensions.paddingMD),
            Text(
              message,
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingMD),
            ElevatedButton.icon(
              onPressed: () => ref.read(marketPricesProvider.notifier).fetchPrices(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          children: [
            Icon(Icons.storefront, size: 64, color: AppColors.textSecondary.withOpacity(0.5)),
            const SizedBox(height: AppDimensions.paddingMD),
            Text(
              'No market data available',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Select a commodity or change the state filter',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceList(List<MarketPriceModel> prices, NumberFormat format) {
    // Sort by modal price (highest first) to show best markets
    final sortedPrices = List<MarketPriceModel>.from(prices)
      ..sort((a, b) => b.modalPrice.compareTo(a.modalPrice));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results count
        Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
          child: Text(
            '${sortedPrices.length} markets found',
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
          ),
        ),
        // Price cards
        ...sortedPrices.map((price) => _buildPriceCard(price, format)),
      ],
    );
  }

  Widget _buildPriceCard(MarketPriceModel price, NumberFormat format) {
    // Determine if this is the highest price market
    final isHighest = price == ref
        .read(marketPricesProvider)
        .prices
        .reduce((a, b) => a.modalPrice > b.modalPrice ? a : b);

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        onTap: () => _showMarketDetailSheet(price, format),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          child: Row(
            children: [
              // Market icon
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingSM),
                decoration: BoxDecoration(
                  color: isHighest
                      ? AppColors.accent.withOpacity(0.15)
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                ),
                child: Icon(
                  isHighest ? Icons.star : Icons.store,
                  color: isHighest ? AppColors.accent : AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMD),

              // Market details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          price.market,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isHighest) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                            ),
                            child: const Text(
                              'BEST',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${price.district}, ${price.state}',
                      style: AppTextStyles.caption,
                    ),
                    if (price.variety != 'Common')
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          price.variety,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Price info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    format.format(price.modalPrice),
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isHighest ? AppColors.accent : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        format.format(price.minPrice),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        ' - ${format.format(price.maxPrice)}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price.unit ?? 'per Quintal',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textHint,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMarketDetailSheet(MarketPriceModel price, NumberFormat format) {
    final trend = ref.read(marketPricesProvider).priceTrend;
    final priceChange = trend?.percentageChange ?? 0.0;
    final isPositive = priceChange >= 0;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Market name
            Row(
              children: [
                const Icon(Icons.store, color: AppColors.primary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(price.market, style: AppTextStyles.h4),
                      Text(
                        '${price.district}, ${price.state}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingLG),
            // Price breakdown
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Commodity', price.cropName),
                  _buildDetailRow('Variety', price.variety ?? 'Common'),
                  const Divider(),
                  _buildDetailRow(
                    'Modal Price',
                    format.format(price.modalPrice),
                    valueStyle: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  _buildDetailRow('Min Price', format.format(price.minPrice)),
                  _buildDetailRow('Max Price', format.format(price.maxPrice)),
                  const Divider(),
                  _buildDetailRow('Unit', price.unit ?? '₹ per Quintal'),
                  if (price.arrivalDate != null)
                    _buildDetailRow(
                      'Arrival Date',
                      DateFormat('dd MMM yyyy').format(price.arrivalDate!),
                    ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: isPositive ? AppColors.success : AppColors.error,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${isPositive ? '+' : ''}$priceChange% (7-day)',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isPositive ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMD),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
          Text(value, style: valueStyle ?? AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ============================================================================
  // INFO BANNER
  // ============================================================================

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppColors.info, size: 20),
          const SizedBox(width: AppDimensions.paddingMD),
          Expanded(
            child: Text(
              'Prices sourced from AGMARKNET (Govt. of India). Data may vary by mandi and time of day. Contact local markets for exact rates.',
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
  // COMMODITY CHIP WIDGET
  // ============================================================================

class _CommodityChip extends StatelessWidget {
  final String name;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const _CommodityChip({
    required this.name,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 4)]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 6),
            Text(
              name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.textLight : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
  // MINI TREND CHART PAINTER
  // ============================================================================

class _TrendLinePainter extends CustomPainter {
  final List<double> prices;
  final double minPrice;
  final double maxPrice;
  final Color color;

  _TrendLinePainter({
    required this.prices,
    required this.minPrice,
    required this.maxPrice,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (prices.length < 2 || maxPrice == minPrice) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final dx = size.width / (prices.length - 1);

    for (int i = 0; i < prices.length; i++) {
      final x = i * dx;
      final y = size.height - ((prices[i] - minPrice) / (maxPrice - minPrice)) * (size.height - 4) - 2;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw dots at each price point
    for (int i = 0; i < prices.length; i++) {
      final x = i * dx;
      final y = size.height - ((prices[i] - minPrice) / (maxPrice - minPrice)) * (size.height - 4) - 2;

      canvas.drawCircle(
        Offset(x, y),
        i == prices.length - 1 ? 4 : 2.5,
        Paint()..color = i == prices.length - 1 ? color : color.withOpacity(0.7),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TrendLinePainter oldDelegate) {
    return oldDelegate.prices != prices || oldDelegate.color != color;
  }
}
