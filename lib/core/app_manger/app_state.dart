import 'package:equatable/equatable.dart';

class AppManagerState extends Equatable {
  final bool isLoggedIn;
  final int bottomNavBarIndex;
 const  AppManagerState({this.isLoggedIn = false, this.bottomNavBarIndex = 0});

  factory AppManagerState.initial() {
    return const AppManagerState(
      isLoggedIn: false,
      bottomNavBarIndex: 0,
    );
  }
  AppManagerState copyWith({
    bool? isLoggedIn,
    int? bottomNavBarIndex,
  }) {
    return AppManagerState(
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
