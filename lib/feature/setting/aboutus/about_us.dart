import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/setting/aboutus/widget/build_info_row.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(color: colors.mainText, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: colors.cardBorder),
              ),
              child: Icon(
                Icons.local_cafe_rounded,
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'coffee Shop',
              style: TextStyle(
                color: colors.mainText,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your little coffee corner',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.subText, fontSize: 14),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About coffee Shop',
                    style: TextStyle(
                      color: colors.mainText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'coffee Shop is a coffee shop application that makes '
                    'discovering your favorite coffee, managing your cart, '
                    'and placing orders simple and enjoyable.',
                    style: TextStyle(
                      color: colors.subText,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.cardBorder),
              ),
              child: Column(
                children: [
                  buildInfoRow(
                    context,
                    icon: Icons.shopping_bag_outlined,
                    title: 'Easy Shopping',
                    subtitle: 'Browse and order your favorite coffee.',
                  ),

                  const SizedBox(height: 20),

                  buildInfoRow(
                    context,
                    icon: Icons.favorite_border_rounded,
                    title: 'Favorites',
                    subtitle: 'Keep your favorite drinks in one place.',
                  ),

                  const SizedBox(height: 20),

                  buildInfoRow(
                    context,
                    icon: Icons.receipt_long_outlined,
                    title: 'Order Tracking',
                    subtitle: 'Keep track of your orders easily.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Version 1.0.0',
              style: TextStyle(color: colors.subText, fontSize: 12),
            ),

            const SizedBox(height: 10),

            Text(
              'Made with Flutter ☕',
              style: TextStyle(color: colors.subText, fontSize: 12),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
