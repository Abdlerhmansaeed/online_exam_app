import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class AppState extends Equatable {
  final bool isLoggedIn;
  int bottomNavBarIndex = 0;
  AppState({this.isLoggedIn = false, this.bottomNavBarIndex = 0});

  factory AppState.initial() {
    return AppState(
      isLoggedIn: false,
      bottomNavBarIndex: 0,
    );
  }
  AppState copyWith({
    bool? isLoggedIn,
    int? bottomNavBarIndex,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      bottomNavBarIndex: bottomNavBarIndex ?? this.bottomNavBarIndex,
    );
  }

  @override
  List<Object?> get props => [
        isLoggedIn,
        bottomNavBarIndex,
      ];
}
