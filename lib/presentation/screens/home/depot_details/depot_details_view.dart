import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fuel/core/theme/app_theme.dart';
import 'package:fuel/logic/cubit/depot_details/depot_details_cubit.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class DepotDetailsView extends StatelessWidget {
  const DepotDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'en_ZA', symbol: 'R');

    return Scaffold(
      backgroundColor: themeData.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primaryContainer,
        leading: IconButton(
          // TODO: Add loader for logging out
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(backgroundColor: Colors.transparent),
        ),
        title: Text(
          context.read<DepotDetailsCubit>().state.depot.name,
          style: themeData.textTheme.titleMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            height: 1.1,
            letterSpacing: 0.1,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<DepotDetailsCubit>().getAccountBalance();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: BlocBuilder<DepotDetailsCubit, DepotDetailsState>(
                  buildWhen: (previous, current) => previous.status != current.status || previous.accountBalance != current.accountBalance,
                  builder: (context, state) {
                    if (state.status.isInProgress) {
                      return SliverToBoxAdapter(
                        child: Shimmer.fromColors(
                          baseColor: themeData.shimmerBaseColor,
                          highlightColor: themeData.shimmerBaseColor,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.surfaceContainerLowest,
                          border: Border.all(color: themeData.colorScheme.surfaceDim),
                          boxShadow: [
                            themeData.customBoxShadowTop,
                            themeData.customBoxShadowBottom,
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              "Available Credit: ${currencyFormatter.format(state.accountBalance.availableCredit)}",
                              style: themeData.textTheme.bodyLarge?.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Text(
                              "Pending Orders: ${state.accountBalance.pendingOrders}",
                              style: themeData.textTheme.bodyLarge?.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
