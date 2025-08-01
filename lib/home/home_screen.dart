import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:send_money/common_ui/sm_logout_fab.dart';
import 'package:send_money/home/bloc/home_bloc.dart';
import 'package:send_money/home/bloc/home_state.dart';
import 'package:send_money/utils/constants.dart';
import 'package:send_money/utils/extensions.dart';
import 'package:send_money/utils/sm_text_style.dart';

import '../common_ui/sm_common_button.dart';
import 'bloc/home_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return Scaffold(
      floatingActionButton: const SMLogoutFAB(),
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
                        BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                          return state.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  isVisible
                                      ? formatMoney(state.walletMoney)
                                      : "₱●●●●●●",
                                  style: SMTextStyle.moneyTitle(context),
                                );
                        }),
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
                            onTap: () async {
                              await context.push(SMRoute.sendMoney.path);
                              homeBloc.add(GetWalletMoney());
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: SMCommonButton(
                            height: context.height * 0.05,
                            width: double.infinity,
                            title: 'View Transactions',
                            isFilled: false,
                            onTap: () async {
                              await context.push(SMRoute.transaction.path);
                              homeBloc.add(GetWalletMoney());
                            },
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
}
