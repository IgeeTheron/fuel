import 'package:flutter/material.dart';
import 'package:fuel/core/theme/app_theme.dart';
import 'package:fuel/data/models/depot/depot_model.dart';
import 'package:fuel/data/models/depot/depot_price_model.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DepotPriceCard extends StatelessWidget {
  final DepotModel depot;
  final List<DepotPriceModel> depotPrices;
  final VoidCallback? onPressed;

  const DepotPriceCard({
    required this.depot,
    required this.depotPrices,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'en_ZA', symbol: 'R');

    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.surfaceContainerLowest,
        border: Border.all(color: themeData.colorScheme.surfaceDim),
        boxShadow: [
          themeData.customBoxShadowTop,
          themeData.customBoxShadowBottom,
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: themeData.colorScheme.primaryContainer,
          splashColor: themeData.colorScheme.primaryContainer,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  "Title: ${depot.name}",
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  (depot.address != null) ? 'Address: ${depot.address} ${depot.country}' : "Country: ${depot.country}",
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: depotPrices.isNotEmpty
                      ? depotPrices
                          .map(
                            (price) => Text(
                              "Price: ${currencyFormatter.format(price.price)}",
                              style: themeData.textTheme.bodyLarge?.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                          )
                          .toList()
                      : [
                          Text(
                            "No price currently available",
                            style: themeData.textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: themeData.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                ),
                Text(
                  'Meta:',
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  'Active: ${depot.active}',
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    fontSize: 14.sp,
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  'Description: ${depot.description}',
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    fontSize: 14.sp,
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
