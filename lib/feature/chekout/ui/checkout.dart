import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';

import 'package:mimi_shope/core/theme/theme_extention.dart';

import 'package:mimi_shope/feature/chekout/logic/checkout_cubit.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_state.dart';
import 'package:mimi_shope/feature/chekout/ui/widget/adress_card.dart';
import 'package:mimi_shope/feature/chekout/ui/widget/order_item.dart';
import 'package:mimi_shope/feature/chekout/ui/widget/payment_method.dart';
import 'package:mimi_shope/feature/chekout/ui/widget/place_order_button.dart';
import 'package:mimi_shope/feature/chekout/ui/widget/price_detailes.dart';
import 'package:mimi_shope/feature/chekout/ui/widget/section_title.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final colorScheme = Theme.of(context).colorScheme;
    final scaafold = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: colors.mainText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.mainText),
      ),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listener: (context, state) async {
          if (state is CheckoutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully')),
            );
            context.push(ConstRouter.home);
          }
          if (state is CheckoutPaymentRequired) {
            final paymentSuccess = await context.push<bool>(
              ConstRouter.payment,
              extra: context.read<CheckoutCubit>().totalPrice,
            );

            if (paymentSuccess == true && context.mounted) {
              await context.read<CheckoutCubit>().completePaidOrder();
            }
          }

          if (state is CheckoutError) {
            scaafold.showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is CheckoutValidationError) {
            scaafold.showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is CheckoutCartClearError) {
            scaafold.showSnackBar(
              SnackBar(
                content: Text('Order created, but cart could not be cleared.'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CheckoutError) {
            return Center(
              child: Column(
                children: [
                  Text(state.message),
                  const Icon(Icons.error, color: Colors.red),
                ],
              ),
            );
          }

          if (state is CheckoutLoaded ||
              state is CheckoutPlacingOrder ||
              state is CheckoutCartClearError) {
            final cubit = context.read<CheckoutCubit>();

            final locationError = state is CheckoutLoaded
                ? state.locationError
                : null;

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(title: 'Order Summary', colors: colors),

                      const SizedBox(height: 12),

                      OrderItems(cubit: cubit, colors: colors),

                      const SizedBox(height: 28),

                      SectionTitle(title: 'Delivery Address', colors: colors),

                      const SizedBox(height: 12),

                      AddressCard(
                        cubit: cubit,
                        colors: colors,
                        colorScheme: colorScheme,
                        locationError: locationError,
                      ),

                      const SizedBox(height: 28),

                      SectionTitle(title: 'Payment Method', colors: colors),

                      const SizedBox(height: 12),

                      PaymentMethodCard(
                        cubit: cubit,
                        colors: colors,
                        colorScheme: colorScheme,
                      ),

                      const SizedBox(height: 28),

                      SectionTitle(title: 'Price Details', colors: colors),

                      const SizedBox(height: 12),

                      PriceDetails(cubit: cubit, colors: colors),
                    ],
                  ),
                ),

                // Bottom button
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: PlaceOrderButton(
                    cubit: cubit,
                    colors: colors,
                    colorScheme: colorScheme,
                    isLoading: state is CheckoutPlacingOrder,
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
