import 'package:flutter/material.dart';
import 'package:hospital/api/resources_repository.dart';
import 'package:hospital/main.dart';
import 'package:hospital/models/resource.dart';
import 'package:hospital/navigator.dart';

mixin ResourceManagementBloc {
  void addResource(String name, ResourceType type, int amount) {
    resourcesRepository.addResource(name, type, amount);
  }

  Iterable<Resource> get beds {
    return resourcesRepository.getByType(ResourceType.bed);
  }

  Iterable<Resource> get equipment {
    return resourcesRepository.getByType(ResourceType.equipment);
  }

  Iterable<Resource> get medicines {
    return resourcesRepository.getByType(ResourceType.medicine);
  }
}

class ResourceManagementPage extends UI with ResourceManagementBloc {
  @override
  Widget build(context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Management'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: navigator.back,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildResourceSection(
            'Hospital Beds',
            Icons.bed,
            beds,
            ResourceType.bed,
            theme,
          ),
          const SizedBox(height: 24),
          _buildResourceSection(
            'Medical Equipment',
            Icons.medical_services,
            equipment,
            ResourceType.equipment,
            theme,
          ),
          const SizedBox(height: 24),
          _buildResourceSection(
            'Medicines',
            Icons.medication,
            medicines,
            ResourceType.medicine,
            theme,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddResourceDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildResourceSection(
    String title,
    IconData icon,
    Iterable<Resource> resources,
    ResourceType type,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (resources.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No $title available',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          )
        else
          ...resources.map(
            (resource) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(resource.name),
                subtitle: LinearProgressIndicator(
                  value: resource.available / resource.total,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${resource.available}/${resource.total}',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      'Available',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showAddResourceDialog(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    ResourceType selectedType = ResourceType.bed;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Resource'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Resource Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ResourceType>(
              value: selectedType,
              decoration: const InputDecoration(
                labelText: 'Resource Type',
                border: OutlineInputBorder(),
              ),
              items: ResourceType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  selectedType = value;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => navigator.back(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  amountController.text.isNotEmpty) {
                addResource(
                  nameController.text,
                  selectedType,
                  int.parse(amountController.text),
                );
                navigator.back();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
