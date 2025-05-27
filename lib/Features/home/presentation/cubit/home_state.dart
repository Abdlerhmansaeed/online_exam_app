import 'package:equatable/equatable.dart';
import 'package:online_exam_app/core/base_states/app_states.dart';

class HomeState extends Equatable {
final AppStates ? homeTabStates;
  const HomeState({this.homeTabStates});
  
  HomeState copyWith({AppStates? homeTabStates}) {
    return HomeState(
      homeTabStates: homeTabStates ?? this.homeTabStates,
    );
  }
  @override
  List<Object?> get props => [
    homeTabStates,
  ];
}
