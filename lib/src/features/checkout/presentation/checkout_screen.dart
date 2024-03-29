import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/authentication/domain/app_user.dart';
import 'package:arms/src/features/cart/presentation/shopping_cart/shopping_cart_page.dart';
import 'package:arms/src/features/checkout/presentation/checkout_screen_controller.dart';
import 'package:arms/src/features/checkout/presentation/checkout_screen_state.dart';
import 'package:arms/src/features/checkout/presentation/payment_summary/payment_sunmmary_widget.dart';
import 'package:arms/src/features/checkout/presentation/delivery_option/delivery_options_widget.dart';
import 'package:arms/src/features/checkout/presentation/place_order_button.dart';
import 'package:arms/src/features/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_kit/x_kit.dart';

import '../../cart/domain/cart.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CartItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appUserStateProvider);
    ref.listen<AppUser?>(appUserStateProvider, (previous, next) {
      ref.read(checkoutScreenControllerProvider.notifier).setCreditCard(next!);
    });
    ref.listen<CheckoutScreenState>(checkoutScreenControllerProvider,
        (previous, next) {
      if (next.asyncValue.hasError) {
        next.asyncValue.showAlertDialogOnError(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: backPageButton(context: context),
        title: const Text('Checkout'),
      ),
      body: LoadingOverlay(
        loadingWidget: const LoadingWidget(),
        isLoading:
            ref.watch(checkoutScreenControllerProvider).asyncValue.isLoading,
        child: ListView(
          children: [
            const DeliveryOptionsWidget(),
            PaymentSummaryWidget(items: items),
          ],
        ),
      ),
      bottomSheet: PlaceOrderButton(items: items),
    );
  }
}
