import 'dart:developer' as dev;

class AppLogger {
  static void logState(
      String blocName, dynamic currentState, dynamic nextState) {
    dev.log(
      '🔄 STATE CHANGE\n'
      '➡️ FROM: ${_formatState(currentState)}\n'
      '➡️ TO: ${_formatState(nextState)}',
      name: blocName,
    );
  }

  static String _formatState(dynamic state) {
    if (state.toString().contains('List<') &&
        state.toString().contains('data:')) {
      // Extract the list from the state
      final list = _extractListFromState(state);
      if (list != null && list.isNotEmpty) {
        final itemCount = list.length;
        final preview = list.take(3).join(', ');
        return '${state.toString().split('data:')[0]}data: [$preview${itemCount > 3 ? ', ... and ${itemCount - 3} more]' : ']'}';
      }
    }
    return state.toString();
  }

  static List<dynamic>? _extractListFromState(dynamic state) {
    // This is a simplified approach - adjust based on your actual state structure
    if (state.data is List) {
      return state.data;
    }
    return null;
  }
}
