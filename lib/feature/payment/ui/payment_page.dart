import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mimi_shope/feature/payment/logic/payment_cubit.dart';
import 'package:mimi_shope/feature/payment/logic/payment_state.dart';

class PaymentPage extends StatelessWidget {
  final double amount;

  const PaymentPage({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            context.pop(true);
          }

          if (state is PaymentFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is PaymentLoading;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Payment Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                Text(
                  'Amount: \$${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 30),

                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Expiry Date',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<PaymentCubit>().pay(amount: amount);
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Pay Now'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
