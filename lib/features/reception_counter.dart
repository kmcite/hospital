import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital/api/receptionist.dart';
import 'package:hospital/features/administration_office.dart';
import 'package:hospital/business/money_system.dart';
import 'package:hospital/utils/navigation.dart';

////////////////////////////////////////////////////////////////////////////////
// SCREEN
////////////////////////////////////////////////////////////////////////////////

class ReceptionCounter extends StatelessWidget {
  const ReceptionCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reception Terminal'),
        actions: [
          MoneyBadge(),
          const SizedBox(width: 12),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'statistics':
                  _showStatistics(context);
                  break;
                case 'rest_all':
                  _confirmRestAll(context);
                  break;
                case 'nav_to_admin':
                  navigateTo(AdministrationOffice());
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'statistics',
                child: Row(
                  children: [
                    Icon(Icons.analytics),
                    SizedBox(width: 8),
                    Text('Statistics'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'rest_all',
                child: Row(
                  children: [
                    Icon(Icons.hotel),
                    SizedBox(width: 8),
                    Text('Rest All Staff'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'nav_to_admin',
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(width: 8),
                    Text('Navigate to Admin Panel'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Implement refresh logic
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // StatusCard(
                    //   isOpen: receptionController.counterOpen,
                    //   onToggle: receptionController.toggleCounter,
                    // ),
                    const SizedBox(height: 16),
                    // StaffSummaryCard(
                    //   totalCount: receptionController.staffCount,
                    //   onDutyCount: receptionController.onDutyCount,
                    //   averageEfficiency: receptionController.averageEfficiency,
                    // ),
                    const SizedBox(height: 16),
                    // if (receptionController.activeReceptionist != null)
                    //   ActiveReceptionistCard(
                    //     receptionist: receptionController.activeReceptionist!,
                    //     onRemove: receptionController.removeFromDuty,
                    //     onRest: () => receptionController.sendForRest(
                    //       receptionController.activeReceptionist!.id,
                    //     ),
                    //   ),
                    const SizedBox(height: 16),
                    // StaffList(
                    //   staff: receptionController.listOfReceptionists,
                    //   activeId: receptionController.activeReceptionist?.id,
                    //   onAssign: receptionController.assignOnDuty,
                    //   onRest: receptionController.sendForRest,
                    //   onFire: _confirmFireStaff,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          ActionPanel(
            onRecruit: () => _handleRecruitment(context),
            onAddFunds: () => _showAddFundsDialog(context),
          ),
        ],
      ),
    );
  }

  void _handleRecruitment(BuildContext context) {
    try {
      // receptionController.recruitReceptionist();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New receptionist recruited successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recruitment failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAddFundsDialog(BuildContext context) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Funds'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount',
            prefixText: '\$ ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final amount = int.tryParse(amountController.text);
              if (amount != null && amount > 0) {
                // receptionController.rewardMoney(amount);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('\$$amount added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  void _confirmFireStaff(BuildContext context, String id) {
    // final receptionist = receptionController.receptionists[id];
    // if (receptionist == null) return;

    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Fire Staff'),
    //     content: Text(
    //       'Are you sure you want to fire ${receptionist.name}?\n\n'
    //       'A severance pay of \$500 will be processed.',
    //     ),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context),
    //         child: const Text('Cancel'),
    //       ),
    //       FilledButton(
    //         onPressed: () {
    //           receptionController.fireReceptionist(id);
    //           Navigator.pop(context);
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               content: Text('${receptionist.name} has been fired.'),
    //               backgroundColor: Colors.orange,
    //             ),
    //           );
    //         },
    //         style: FilledButton.styleFrom(backgroundColor: Colors.red),
    //         child: const Text('Fire'),
    //       ),
    //     ],
    //   ),
    // );
  }

  void _confirmRestAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rest All Staff'),
        content: const Text(
          'Send all staff members for rest?\n'
          'Their efficiency will be restored to 100%.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // receptionController.restAllStaff();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All staff sent for rest.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Rest All'),
          ),
        ],
      ),
    );
  }

  void _showStatistics(BuildContext context) {
    // final stats = receptionController.getStatistics();

    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Reception Statistics'),
    //     content: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         StatItem('Total Staff', '${stats['totalStaff']}'),
    //         StatItem('On Duty', '${stats['onDuty']}'),
    //         StatItem('Exhausted', '${stats['exhausted']}'),
    //         StatItem('Avg Efficiency', '${stats['averageEfficiency']}%'),
    //         StatItem('Patients Served', '${stats['totalPatientsServed']}'),
    //         StatItem('Counter Status', '${stats['counterStatus']}'),
    //       ],
    //     ),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context),
    //         child: const Text('Close'),
    //       ),
    //     ],
    //   ),
    // );
  }
}

////////////////////////////////////////////////////////////////////////////////
// UI COMPONENTS
////////////////////////////////////////////////////////////////////////////////

class StatusCard extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onToggle;

  const StatusCard({
    super.key,
    required this.isOpen,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isOpen
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isOpen ? Icons.check_circle : Icons.cancel,
                color: isOpen ? Colors.green : Colors.red,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isOpen ? 'Reception Operational' : 'Reception Closed',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isOpen ? 'Serving patients' : 'No patients being served',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Switch(
              value: isOpen,
              onChanged: (_) => onToggle(),
            ),
          ],
        ),
      ),
    );
  }
}

class StaffSummaryCard extends StatelessWidget {
  final int totalCount;
  final int onDutyCount;
  final double averageEfficiency;

  const StaffSummaryCard({
    super.key,
    required this.totalCount,
    required this.onDutyCount,
    required this.averageEfficiency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryItem(
              icon: Icons.groups,
              label: 'Total Staff',
              value: '$totalCount',
              color: Colors.blue,
            ),
            _SummaryItem(
              icon: Icons.person,
              label: 'On Duty',
              value: '$onDutyCount',
              color: Colors.green,
            ),
            _SummaryItem(
              icon: Icons.trending_up,
              label: 'Avg Efficiency',
              value: '${(averageEfficiency * 100).toStringAsFixed(0)}%',
              color: _getEfficiencyColor(averageEfficiency),
            ),
          ],
        ),
      ),
    );
  }

  Color _getEfficiencyColor(double efficiency) {
    if (efficiency > 0.7) return Colors.green;
    if (efficiency > 0.4) return Colors.orange;
    return Colors.red;
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class ActiveReceptionistCard extends StatelessWidget {
  final Receptionist receptionist;
  final VoidCallback onRemove;
  final VoidCallback onRest;

  const ActiveReceptionistCard({
    super.key,
    required this.receptionist,
    required this.onRemove,
    required this.onRest,
  });

  @override
  Widget build(BuildContext context) {
    final efficiencyPercent = receptionist.efficiencyPercentage;

    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    receptionist.name[0].toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receptionist.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Currently Serving',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(receptionist.status),
                  backgroundColor: _getStatusColor(receptionist.status),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: receptionist.efficiency,
                minHeight: 12,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getEfficiencyColor(receptionist.efficiency),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Efficiency: ${efficiencyPercent.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Patients: ${receptionist.patientsServed}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onRest,
                  icon: const Icon(Icons.hotel),
                  label: const Text('Send to Rest'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onRemove,
                  icon: const Icon(Icons.remove_circle_outline),
                  label: const Text('Remove'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getEfficiencyColor(double efficiency) {
    if (efficiency > 0.7) return Colors.green;
    if (efficiency > 0.4) return Colors.orange;
    return Colors.red;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Excellent':
        return Colors.green;
      case 'Good':
        return Colors.blue;
      case 'Tiring':
        return Colors.orange;
      case 'Needs Rest':
        return Colors.red;
      case 'Exhausted':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

class StaffList extends StatelessWidget {
  final List<Receptionist> staff;
  final String? activeId;
  final Function(String id) onAssign;
  final Function(String id) onRest;
  final Function(BuildContext context, String id) onFire;

  const StaffList({
    super.key,
    required this.staff,
    required this.activeId,
    required this.onAssign,
    required this.onRest,
    required this.onFire,
  });

  @override
  Widget build(BuildContext context) {
    if (staff.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No Staff Members',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Recruit receptionists to get started',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: staff.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final receptionist = staff[index];
          final isActive = receptionist.id == activeId;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isActive ? Colors.green : Colors.grey[300],
              child: Text(
                receptionist.name[0].toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.white : Colors.black87,
                ),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    receptionist.name,
                    style: TextStyle(
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (receptionist.isExhausted)
                  const Icon(Icons.warning, color: Colors.red, size: 20),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: receptionist.efficiency,
                  minHeight: 4,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getEfficiencyColor(receptionist.efficiency),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Efficiency: ${receptionist.efficiencyPercentage.toStringAsFixed(0)}% | '
                  'Patients: ${receptionist.patientsServed}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'assign':
                    try {
                      onAssign(receptionist.id);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                    break;
                  case 'rest':
                    onRest(receptionist.id);
                    break;
                  case 'fire':
                    onFire(context, receptionist.id);
                    break;
                }
              },
              itemBuilder: (context) => [
                if (!receptionist.isExhausted && !receptionist.isOnDuty)
                  const PopupMenuItem(
                    value: 'assign',
                    child: Row(
                      children: [
                        Icon(Icons.assignment_ind),
                        SizedBox(width: 8),
                        Text('Assign to Duty'),
                      ],
                    ),
                  ),
                if (receptionist.isExhausted || receptionist.needsRest)
                  const PopupMenuItem(
                    value: 'rest',
                    child: Row(
                      children: [
                        Icon(Icons.hotel),
                        SizedBox(width: 8),
                        Text('Send to Rest'),
                      ],
                    ),
                  ),
                const PopupMenuItem(
                  value: 'fire',
                  child: Row(
                    children: [
                      Icon(Icons.person_remove, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Fire', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getEfficiencyColor(double efficiency) {
    if (efficiency > 0.7) return Colors.green;
    if (efficiency > 0.4) return Colors.orange;
    return Colors.red;
  }
}

class ActionPanel extends StatelessWidget {
  final VoidCallback onRecruit;
  final VoidCallback onAddFunds;

  const ActionPanel({
    super.key,
    required this.onRecruit,
    required this.onAddFunds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: onRecruit,
              icon: const Icon(Icons.person_add),
              label: const Text('Recruit Staff'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onAddFunds,
              icon: const Icon(Icons.attach_money),
              label: const Text('Add Funds'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoneyBadge extends StatelessWidget {
  const MoneyBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final moneySystem = context.watch<MoneyBloc>();

    return ListenableBuilder(
      listenable: adminController,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.attach_money,
                size: 18,
                // color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                moneySystem.state.toString(),
                style: const TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final String value;

  const StatItem(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
