// typedef UI = api.ReactiveStatelessWidget;
// typedef Modifier<T> = T Function([T?]);
// Injected<T> signal<T>(T value) => Injected(value);
// Injected<T> stream<T>(Stream<T> stream) => Injected.stream(stream);

// class Injected<T> {
//   late final api.Injected<T> valueRM;
//   Injected(
//     T value, {
//     PersistState<T> Function()? persist,
//   }) {
//     valueRM = api.RM.inject(
//       () => value,
//       persist: persist,
//     );
//   }
//   T call([T? value]) {
//     if (value != null) {
//       valueRM
//         ..state = value
//         ..notify();
//     }
//     return valueRM.state;
//   }

//   Injected.stream(
//     Stream<T> stream, {
//     T? initialState,
//   }) {
//     valueRM = api.RM.injectStream(
//       () => stream,
//       initialState: initialState,
//     );
//   }
//   bool get loading => valueRM.isWaiting;
// }

// extension DynamicX on dynamic {
//   Widget text() => Text(toString());
// }

// extension PaddingX on Widget {
//   Widget pad() {
//     return Padding(
//       padding: EdgeInsets.all(8),
//       child: this,
//     );
//   }

//   Widget center() {
//     return Center(child: this);
//   }
// }
