---

## Solid rules for building such interactions in code

These rules will help you decompose any real‑world interaction into clean, decoupled Dart classes without external packages.

### Rule 1 – Find the *actors* and make them classes
Every real‑world role becomes a class.  
- Patient  
- Receptionist  
- Register (the book)  
- DoctorRoom  

Don’t lump everything into one mega‑class; split responsibilities.

---

### Rule 2 – Identify the **immutable value objects** (tokens / tickets / slips)
The physical “chit” is an immutable data holder. It doesn’t *do* anything, it just carries data.  
- Mark fields as `final`.  
- Don’t allow modification after creation.  
- Override `toString()` for easy printing.  

```dart
class Chit {
  final int number;
  final String patientName;
  final DateTime timestamp;

  const Chit({required this.number, required this.patientName, required this.timestamp});
}
```

---

### Rule 3 – Separate the **state bookkeeping** into its own class
The register book is a stateful object that **only** manages numbering and log history.  
- It should never know about payment, patients, or streams.  
- Provide a clean method like `createChit(name)` that returns a new `Chit`.  

```dart
class Register {
  int _next = 1;
  final List<Chit> _log = [];

  Chit createChit(String name) {
    final chit = Chit(number: _next++, patientName: name, timestamp: DateTime.now());
    _log.add(chit);
    return chit;
  }
}
```

---

### Rule 4 – Pick **one** orchestrator (the “controller”)
The receptionist is the orchestrator. It owns the `Register`, handles payment, and emits events.  
- Orchestrators call other objects in order.  
- They decide *when* things happen (first pay, then register, then emit).  
- They don’t do the low‑level work themselves (number assignment is delegated to `Register`).  

---

### Rule 5 – Use **streams or ChangeNotifiers** to decouple the event from the listener
The doctor room should **not** be directly called by the receptionist.  
- The receptionist publishes an event (`onNewChit` stream).  
- The doctor room subscribes to that stream.  
- This lets you add more listeners (a display board, a statistics logger) without touching the receptionist.  

In Dart without Flutter: `StreamController.broadcast()`  
In Flutter: `ChangeNotifier` + `addListener` or streams.  

**Key**: The producer never knows who listens.

---

### Rule 6 – Errors should be thrown, not silently swallowed
If the patient can’t pay, the orchestrator throws an exception. The caller (UI/main) handles it (shows error message). This keeps the stream clean of error‑states.  

```dart
if (!patient.pay(fee)) {
  throw Exception('Cannot afford');
}
```

---

### Rule 7 – The **physical hand‑over** is the **return value**
The receptionist returns the `Chit` to the caller. That’s how you model “giving the chit to the patient.”  
- The returned object is the patient’s copy.  
- The stream is the announcement.  

```dart
Chit processPatient(Patient patient) {
  patient.pay(...);
  final chit = _register.createChit(patient.name);
  _controller.add(chit);   // announce
  return chit;             // hand to patient
}
```

---

### Rule 8 – Keep side effects explicit and testable
- The `Register` is pure‑ish (just creates a chit and logs it).  
- The `Receptionist` has side effects (payment modifies patient, emits on stream).  
- This separation makes unit testing trivial: you can test `Register` in isolation, and mock the stream for `Receptionist`.

---

### Rule 9 – Never expose internal mutable state if not needed
The `Register`’s log is exposed as `List.unmodifiable(_log)`. This prevents external code from tampering with the history.  
- Provide read‑only views of collections.  
- Use `Stream` (which is read‑only) instead of handing out the `StreamController`.

---

### Rule 10 – Clean up your controllers
When the widget/page/flow is disposed, close the `StreamController` and cancel subscriptions to avoid memory leaks.  
```dart
void dispose() {
  _controller.close();
}
```

---

### Rule 11 – Model time explicitly (timestamp)
Always capture when an event happened (`DateTime.now()` in the `Chit`). It costs nothing and is invaluable later for debugging or real‑world logging.

---

## Summary cheat‑sheet

| Real‑world item | Code counterpart |
|----------------|-----------------|
| Physical chit   | Immutable `Chit` object |
| Register book   | `Register` class with internal counter |
| Receptionist    | Orchestrator class that uses `Register`, validates payment, emits stream |
| Payment         | Method on `Patient` that modifies wallet and returns success |
| Announcement to doctor | `Stream<Chit>` |
| Doctor’s room   | Subscriber to the stream |
| Handing chit to patient | Return value from `processPatient()` |

If you internalise these rules, you’ll be able to model practically any counter, ticketing, or workflow interaction with clean, decoupled Dart code – with or without Flutter.