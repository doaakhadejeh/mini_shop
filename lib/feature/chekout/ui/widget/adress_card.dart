import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimi_shope/core/routing/const_rout.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';
import 'package:mimi_shope/feature/chekout/logic/checkout_cubit.dart';
import 'package:mimi_shope/feature/location/data/model/location_model.dart';

class AddressCard extends StatelessWidget {
  final CheckoutCubit cubit;
  final AppColors colors;
  final ColorScheme colorScheme;
  final String? locationError;

  const AddressCard({
    super.key,
    required this.cubit,
    required this.colors,
    required this.colorScheme,
    this.locationError,
  });

  @override
  Widget build(BuildContext context) {
    final location = cubit.selectedLocation;

    return InkWell(
      onTap: () async {
        final result = await context.push<LocationModel>(
          ConstRouter.locationMap,
          extra: location,
        );
        if (result != null) {
          cubit.selectLocation(
            latitude: result.latitude!,
            longitude: result.longitude!,
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colorScheme.primary.withAlpha(12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Location',
                    style: TextStyle(
                      color: colors.mainText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    location?.address ?? 'Select delivery address',
                    style: TextStyle(
                      color: location == null
                          ? colors.subText
                          : colors.mainText,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (locationError != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      locationError!,
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),

            Icon(Icons.arrow_forward_ios, size: 16, color: colors.subText),
          ],
        ),
      ),
    );
  }
}
