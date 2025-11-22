import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:forui/forui.dart';
import 'package:rearch/rearch.dart';

class StatisticsScreen extends RearchConsumer {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, use) {
    final api = use(statistics);
    return Column(
      spacing: 8,
      children: [
        Text("Available Funds: ${api.funds}"),
        FButton(
          onPress: () => api.increment(),
          child: const Text("Invest in Other projects"),
        ),
        FButton(
          onPress: () {
            api.decrement();
          },
          child: const Text("Request for Funds"),
        ),
      ],
    );
  }
}

final statistics = capsule(
  (use) {
    // Lifecycle-safe state
    final (funds, setFunds) = use.state(0);

    return (
      funds: funds,
      increment: () => setFunds(funds + 1),
      decrement: () => setFunds(funds - 1),
    );
  },
);
