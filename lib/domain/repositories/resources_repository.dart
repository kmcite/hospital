import 'package:hospital/main.dart';

import '../models/resource.dart';

final resourcesRepository = ResourcesRepository();

class ResourcesRepository extends CRUD<Resource> {
  Resource getOrCreateResource(String name, ResourceType type,
      {int defaultTotal = 0}) {
    var resource = getAll().firstWhere(
      (r) => r.name == name && r.type == type,
      orElse: () {
        final newResource = Resource(
          name: name,
          total: defaultTotal,
          available: defaultTotal,
        )..type = type;
        put(newResource);
        return newResource;
      },
    );
    return resource;
  }

  bool allocateResource(String name, ResourceType type) {
    var resource = getOrCreateResource(name, type);
    if (resource.available > 0) {
      resource.available--;
      put(resource);
      return true;
    }
    return false;
  }

  void releaseResource(String name, ResourceType type) {
    var resource = getOrCreateResource(name, type);
    if (resource.available < resource.total) {
      resource.available++;
      put(resource);
    }
  }

  void addResource(String name, ResourceType type, int amount) {
    var resource = getOrCreateResource(name, type);
    resource.total += amount;
    resource.available += amount;
    put(resource);
  }

  Iterable<Resource> getByType(ResourceType type) {
    return getAll().where((r) => r.type == type);
  }
}
