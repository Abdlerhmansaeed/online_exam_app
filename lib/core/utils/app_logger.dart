import 'dart:developer' as dev;

import 'package:online_exam_app/Features/home/presentation/cubit/home_state.dart';
import 'package:online_exam_app/core/base_states/app_states.dart';

class AppLogger {
  static void logState(String bloc, Object oldState, Object newState) {
    dev.log(
      '\n[$bloc] 🔄 STATE CHANGE\n'
      '            ➡️ FROM: ${_formatState(oldState)}\n'
      '            ➡️ TO: ${_formatState(newState)}',
      name: bloc,
    );
  }

  static String _formatState(Object state) {
    if (state is SuccessState) {
      final list = _extractListFromState(state);
      if (list != null) {
        return '$state (${list.length} items)';
      }
    }

    return state.toString();
  }

  static List<dynamic>? _extractListFromState(Object state) {
    try {
      if (state is SuccessState && state.data is List) {
        return state.data as List;
      }

      if (state is HomeState && state.homeTabStates is SuccessState) {
        final successState = state.homeTabStates as SuccessState;
        if (successState.data is List) {
          return successState.data as List;
        }
      }

      return null;
    } catch (e) {
      dev.log('++++++++onError -- AppLogger, $e');
      return null;
    }
  }
}
