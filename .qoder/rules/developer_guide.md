---
trigger: always_on
alwaysApply: true
---
import 'package:qoder/utils/notifier.dart';

use [context] .of() to access dependencies/repositories. 

use [Notifier] and [NotifierProvider] utils from /lib/utils folder. it's for the state management
one to one relation of StatelessWidget and the Notifier. use feature first folder struture to develop this project.
use feature first folder struture to develop this project.

also use domain folder for Models and Repositories, for the injection of Repositories use ListenableProvider/Provider in main method. so its accessible to all the app from everywhere.
Never use StatefulWidget and State. use StatelessWidget and Notifier.

use [navigator] from utils has api for imperative navigation. use it for navigation.
 
[event_bus] from utils maybe used to communicate between repositories for cross cutting concerns.

use [Collection] and [InMemoryCollection<T>] for repositories of data/T. use it for repositories. can be injected using ListenableProvider/Provider.

data/T models can be created in /lib/domain/models folder use [Model] available from utils.



