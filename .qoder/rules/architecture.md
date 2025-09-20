---
trigger: always_on
alwaysApply: true
---

use official flutter recommendations for architecture

- use repository pattern
- repository is used to manage the CRUD of a model
- repository can only manage a single model
- repository provides a reactive interface, which can be subscribed by bloc
- use services to access database/network api
- repository can depend on zero or more services
- services are the first order objects
- repositories can not have sibling dependencies
- blocs can depend on zero or more repositories
- view should only have one to one relationship with bloc
- views are composable meaning they can be reused in any view
- `navigator` is available as a global instance and can be reused anywhere in the app
- 'features' is directory under lib
- `feature` means pair of view and bloc
- `domain` is directory under lib
- `domain` means repositories and models.



