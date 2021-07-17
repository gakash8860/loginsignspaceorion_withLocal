import 'dart:async';

import 'package:flutter/material.dart';

import '../appliance.dart';

class ConnectedModel extends Model {
  bool switchval = true;
  Slider slider;
  static final List<Appliance> applianceList = [
    Appliance(
        title: 'A/C',
        subtitle: '24 C',
        leftIcon: Icons.ac_unit,
        topRightIcon: Icons.threesixty,
        bottomRightIcon: Icons.threesixty,
        isEnable: true,
        colors: Colors.black12),
    Appliance(
        title: 'Music',
        subtitle: 'Turned off',
        leftIcon: Icons.queue_music,
        topRightIcon: Icons.threesixty,
        bottomRightIcon: Icons.threesixty,
        isEnable: true),
    Appliance(
        title: 'Fan',
        subtitle: 'Sweet Home',
        leftIcon: Icons.connect_without_contact_rounded,
        topRightIcon: Icons.circle,
        bottomRightIcon: Icons.threesixty,
        isEnable: true),
    Appliance(
        title: 'Light',
        subtitle: '70 % brightness',
        leftIcon: Icons.lightbulb_outline,
        topRightIcon: Icons.threesixty,
        bottomRightIcon: Icons.threesixty,
        isEnable: true),
    Appliance(
        title: null,
        subtitle: '70 % brightness',
        leftIcon: Icons.threesixty,
        topRightIcon: Icons.threesixty,
        bottomRightIcon: Icons.threesixty,
        isEnable: true),
  ];
}

class Model extends Listenable {
  final Set<VoidCallback> _listeners = Set<VoidCallback>();
  int _version = 0;
  int _microtaskVersion = 0;

  /// [listener] will be invoked when the model changes.
  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// [listener] will no longer be invoked when the model changes.
  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// Returns the number of listeners listening to this model.
  int get listenerCount => _listeners.length;

  /// Should be called only by [Model] when the model has changed.
  @protected
  void notifyListeners() {
    // We schedule a microtask to debounce multiple changes that can occur
    // all at once.
    if (_microtaskVersion == _version) {
      _microtaskVersion++;
      scheduleMicrotask(() {
        _version++;
        _microtaskVersion = _version;

        // Convert the Set to a List before executing each listener. This
        // prevents errors that can arise if a listener removes itself during
        // invocation!
        _listeners.toList().forEach((VoidCallback listener) => listener());
      });
    }
  }
}

class ApplianceModel extends ConnectedModel {
  List<Appliance> get allYatch {
    return List.from(ConnectedModel.applianceList);
  }
}
