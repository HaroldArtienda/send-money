import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:send_money/common_ui/sm_common_button.dart';

import '../utils/constants.dart';

class SMBottomSheet extends StatelessWidget {
  bool isSuccess;
  String amount;

  SMBottomSheet({super.key, this.isSuccess = false, this.amount = "0"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            isSuccess ? 'Success' : 'Failed',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            isSuccess
                ? '₱$amount has been sent successfully!'
                : 'Sending ₱$amount failed. Please try again.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          SMCommonButton(
            title: 'Done',
            height: 50,
            width: double.infinity,
            isFilled: true,
            onTap: () {
              Navigator.of(context).pop();
              isSuccess ? context.pop() : null;
            },
          ),
        ],
      ),
    );
  }
}
