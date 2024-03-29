import 'package:arms/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_kit/x_kit.dart';

import '../../domain/payment_summary.dart';

class SelectCreditCardWidget extends StatelessWidget {
  const SelectCreditCardWidget({
    Key? key,
    required this.paymentSummary,
  }) : super(key: key);

  final PaymentSummary paymentSummary;

  @override
  Widget build(BuildContext context) {
    final title = paymentSummary.creditCard == null
        ? const Text('Add credit card',
            style: TextStyle(color: Colors.blue))
        : Text('••••${paymentSummary.creditCard!.last4} ');
    final subTitle = paymentSummary.creditCard == null
        ? const SizedBox()
        : Text('${paymentSummary.creditCard!.expMonth}/${paymentSummary.creditCard!.expYear}',);

    return ListTile(
      onTap: () {
        context.pushNamed(AppRoute.paymentMethodsScreen.name);
      },
      leading: Icon(
        XIcons.creditCard2,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: title,
      // subtitle: subTitle,
      trailing: const Icon(Icons.arrow_forward_ios, size: Sizes.p12),
    );
  }
}
