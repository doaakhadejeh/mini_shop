import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/order/logic/order_cubit.dart';
import 'package:mimi_shope/feature/order/logic/order_state.dart';
import 'package:mimi_shope/feature/order/ui/widget/empty_order.dart';
import 'package:mimi_shope/feature/order/ui/widget/order_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(color: colors.mainText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.mainText),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (state is OrdersError) {
            return Center(
              child: Column(
                children: [
                  Text(state.message),
                  const Icon(Icons.error, color: Colors.red),
                ],
              ),
            );
          }
          if (state is OrdersSuccess) {
            if (state.orders.isEmpty) {
              return EmptyOrders(colors: colors, colorScheme: colorScheme);
            }
            return RefreshIndicator(
              color: colorScheme.primary,
              onRefresh: () {
                return context.read<OrdersCubit>().getOrders();
              },
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
                itemCount: state.orders.length,
                separatorBuilder: (_, _) {
                  return const SizedBox(height: 14);
                },
                itemBuilder: (context, index) {
                  final order = state.orders[index];

                  return OrderCard(
                    order: order,
                    colors: colors,
                    colorScheme: colorScheme,
                    onTap: () {
                      context.push(ConstRouter.detaileOrder, extra: order);
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
