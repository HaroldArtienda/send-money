import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:send_money/utils/constants.dart';
import 'package:send_money/utils/extensions.dart';
import 'package:send_money/utils/sm_text_style.dart';

import '../common_ui/sm_common_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            child: Card(
              elevation: 1.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          isVisible ? formatMoney(124563.80) : "₱●●●●●●",
                          style: SMTextStyle.moneyTitle(context),
                        ),
                        IconButton(
                            icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey),
                            onPressed: () =>
                                setState(() => isVisible = !isVisible))
                      ],
                    ),
                    Text(
                      "Wallet Balance",
                      style: SMTextStyle.balanceTitle(),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: SMCommonButton(
                            height: context.height * 0.05,
                            width: double.infinity,
                            title: 'Send Money',
                            isFilled: true,
                            onTap: () => context.push(SMRoute.sendMoney.path),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: SMCommonButton(
                            height: context.height * 0.05,
                            width: double.infinity,
                            title: 'View Transactions',
                            isFilled: false,
                            onTap: () => context.push(SMRoute.transaction.path),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatMoney(double amount) {
    final formatCurrency = NumberFormat.currency(
      locale: 'en_PH',
      symbol: '₱',
      decimalDigits: 2,
    );
    return formatCurrency.format(amount);
  }
}
