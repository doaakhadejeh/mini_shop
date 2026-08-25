import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_cubit.dart';

class PaymentMethodCard extends StatelessWidget {
  final CheckoutCubit cubit;
  final AppColors colors;
  final ColorScheme colorScheme;

  const PaymentMethodCard({
    super.key,
    required this.cubit,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        children: [
          _PaymentOption(
            title: 'Cash on Delivery',
            subtitle: 'Pay when your order arrives',
            icon: Icons.payments_outlined,
            value: 'cash',
            selectedValue: cubit.selectedPaymentMethod,
            colors: colors,
            colorScheme: colorScheme,
            onTap: () {
              cubit.selectPaymentMethod('cash');
            },
          ),

          Divider(height: 1, color: colors.cardBorder),

          _PaymentOption(
            title: 'Credit / Debit Card',
            subtitle: 'Pay securely with your card',
            icon: Icons.credit_card_outlined,
            value: 'card',
            selectedValue: cubit.selectedPaymentMethod,
            colors: colors,
            colorScheme: colorScheme,
            onTap: () {
              cubit.selectPaymentMethod('card');
            },
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String selectedValue;
  final AppColors colors;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.selectedValue,
    required this.colors,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedValue;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? colorScheme.primary : colors.subText,
              size: 26,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.mainText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(color: colors.subText, fontSize: 12),
                  ),
                ],
              ),
            ),
            RadioGroup<String>(
              groupValue: selectedValue,
              onChanged: (value) {
                if (value != null) {
                  onTap();
                }
              },
              child: Radio<String>(value: value),
            ),
          ],
        ),
      ),
    );
  }
}
