import 'package:arms/src/common_widget/common_widget.dart';
import 'package:arms/src/features/payment/presentation/add_credit_card/add_credit_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

class AddCreditCardScreen extends ConsumerWidget {
  const AddCreditCardScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addCreditCardController.notifier);
    final state = ref.watch(addCreditCardController);
    ref.listen<AsyncValue>(addCreditCardController, (_, state) {
      if (state.hasError) {
        state.showAlertDialogOnError(context);
      }
    });
    return LoadingOverlay(
      bgColor: SystemColors.grey900,
      loadingWidget: const LoadingWidget(),
      isLoading: state.isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: backPageButton(context: context),
          title: const Text('Add credit card'),
          actions: [
            TextButton(
              onPressed: () async {
                await controller.addCreditCard().then((_) {
                  context.pop();
                });
              },
              child: const Text('Done'),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH32,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
                child: Text('Enter your card information'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                child: CardField(
                  onCardChanged: (card) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
