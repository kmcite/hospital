import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:hospital/domain/models/resource.dart';
import 'package:hospital/domain/repositories/resources_repository.dart';
import 'package:hospital/main.dart';
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
    return FScaffold(
      header: FHeader(
        title: const Text('Resource Management'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: navigator.back,
        // ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildResourceSection(
            'Hospital Beds',
            FIcons.hospital,
            beds,
            ResourceType.bed,
            theme,
          ),
          const SizedBox(height: 24),
          _buildResourceSection(
            'Medical Equipment',
            FIcons.medal,
            equipment,
            ResourceType.equipment,
            theme,
          ),
          const SizedBox(height: 24),
          _buildResourceSection(
            'Medicines',
            FIcons.briefcaseMedical,
            medicines,
            ResourceType.medicine,
            theme,
          ),
        ],
      ),
      sidebar: FSidebar(
        header: FButton.icon(
          onPress: () => _showAddResourceDialog(context),
          child: const Icon(Icons.add),
        ),
        children: [],
        width: 50,
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
          FCard(
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
          ...resources
              .where(
            (resource) => resource.type == type,
          )
              .map(
            (resource) {
              return FTile(
                title: Text(resource.name),
                subtitle: FProgress(value: resource.available / resource.total),
                suffixIcon: Column(
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
                onPress: () => navigator.to(
                  ResourcePage(resource),
                ),
              );
            },
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
              items: List.generate(
                ResourceType.values.length,
                (i) {
                  return DropdownMenuItem(
                    value: ResourceType.values[i],
                    child:
                        Text(ResourceType.values[i].toString().split('.').last),
                  );
                },
              ),
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

class ResourcePage extends UI {
  final Resource resource;

  ResourcePage(this.resource);
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        prefixes: [
          FButton.icon(
            onPress: navigator.back,
            child: const Icon(Icons.arrow_back),
          ),
        ],
        title: 'RESOURCE ${resource.id}'.text(),
      ),
      child: ListView(
        children: [
          resource.name.text(),
          resource.available.text(),
          resource.total.text(),
          resource.type.text(),
          FButton(
            onPress: () => toggleType(resource),
            child: 'to equipment'.text(),
          ),
        ],
      ),
    );
  }
}

void toggleType(Resource r) {
  resourcesRepository.put(r..type = ResourceType.equipment);
}
