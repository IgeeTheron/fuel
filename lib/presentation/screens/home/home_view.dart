import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fuel/core/theme/app_theme.dart';
import 'package:fuel/data/models/depot/depot_model.dart';
import 'package:fuel/data/models/depot/depot_price_model.dart';
import 'package:fuel/logic/bloc/authentication/authentication_bloc.dart';
import 'package:fuel/logic/cubit/home/home_cubit.dart';
import 'package:fuel/presentation/screens/home/depot_details/depot_details_page.dart';
import 'package:fuel/presentation/widgets/cards/depot_price_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primaryContainer,
        title: Text(
          "Home",
          style: themeData.textTheme.titleMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            height: 1.1,
            letterSpacing: 0.1,
          ),
        ),
        actions: [
          IconButton(
            // TODO: Add loader for logging out
            onPressed: () => context.read<AuthenticationBloc>().add(const AppLogoutRequested()),
            icon: const Icon(Icons.logout),
            style: IconButton.styleFrom(backgroundColor: Colors.transparent),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<HomeCubit>().getDepotsAndPrices();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) => previous.status != current.status || previous.depots != current.depots || previous.depotPrices != current.depotPrices,
                  builder: (context, state) {
                    if (state.status.isInProgress) {
                      return SliverList.separated(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Shimmer.fromColors(
                            baseColor: themeData.shimmerBaseColor,
                            highlightColor: themeData.shimmerBaseColor,
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 16);
                        },
                      );
                    }

                    if (state.depots.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "There are currently no depots",
                              style: themeData.textTheme.titleLarge?.copyWith(
                                fontSize: 18.sp,
                                height: 1.1,
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return SliverList.separated(
                      itemCount: state.depots.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DepotModel depot = state.depots[index];

                        final List<DepotPriceModel> depotPrices = state.depotPrices.where((price) => price.depotName == depot.name).toList();

                        return DepotPriceCard(
                          depot: state.depots[index],
                          depotPrices: depotPrices,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DepotDetailsPage(depot: state.depots[index]))),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 16);
                      },
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
