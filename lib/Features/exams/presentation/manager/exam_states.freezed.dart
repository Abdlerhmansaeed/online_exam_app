// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExamStates {
  BaseStates<dynamic> get examStates => throw _privateConstructorUsedError;
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  Map<int, int> get selectedAnswers => throw _privateConstructorUsedError;
  int? get examDuration => throw _privateConstructorUsedError;
  bool? get examTimeOutState => throw _privateConstructorUsedError;
  bool? get isLastQuestion => throw _privateConstructorUsedError;
  bool? get isDangerTime => throw _privateConstructorUsedError;
  bool? get isInExam => throw _privateConstructorUsedError;
  BaseStates<dynamic>? get examOnSubjectStates =>
      throw _privateConstructorUsedError;
  BaseStates<dynamic>? get checkUserAnswersStates =>
      throw _privateConstructorUsedError;
  List<UserAnswers>? get userAnswers => throw _privateConstructorUsedError;
  String? get navigationState => throw _privateConstructorUsedError;

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExamStatesCopyWith<ExamStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamStatesCopyWith<$Res> {
  factory $ExamStatesCopyWith(
          ExamStates value, $Res Function(ExamStates) then) =
      _$ExamStatesCopyWithImpl<$Res, ExamStates>;
  @useResult
  $Res call(
      {BaseStates<dynamic> examStates,
      int currentQuestionIndex,
      Map<int, int> selectedAnswers,
      int? examDuration,
      bool? examTimeOutState,
      bool? isLastQuestion,
      bool? isDangerTime,
      bool? isInExam,
      BaseStates<dynamic>? examOnSubjectStates,
      BaseStates<dynamic>? checkUserAnswersStates,
      List<UserAnswers>? userAnswers,
      String? navigationState});

  $BaseStatesCopyWith<dynamic, $Res> get examStates;
  $BaseStatesCopyWith<dynamic, $Res>? get examOnSubjectStates;
  $BaseStatesCopyWith<dynamic, $Res>? get checkUserAnswersStates;
}

/// @nodoc
class _$ExamStatesCopyWithImpl<$Res, $Val extends ExamStates>
    implements $ExamStatesCopyWith<$Res> {
  _$ExamStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examStates = null,
    Object? currentQuestionIndex = null,
    Object? selectedAnswers = null,
    Object? examDuration = freezed,
    Object? examTimeOutState = freezed,
    Object? isLastQuestion = freezed,
    Object? isDangerTime = freezed,
    Object? isInExam = freezed,
    Object? examOnSubjectStates = freezed,
    Object? checkUserAnswersStates = freezed,
    Object? userAnswers = freezed,
    Object? navigationState = freezed,
  }) {
    return _then(_value.copyWith(
      examStates: null == examStates
          ? _value.examStates
          : examStates // ignore: cast_nullable_to_non_nullable
              as BaseStates<dynamic>,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedAnswers: null == selectedAnswers
          ? _value.selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      examDuration: freezed == examDuration
          ? _value.examDuration
          : examDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      examTimeOutState: freezed == examTimeOutState
          ? _value.examTimeOutState
          : examTimeOutState // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLastQuestion: freezed == isLastQuestion
          ? _value.isLastQuestion
          : isLastQuestion // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDangerTime: freezed == isDangerTime
          ? _value.isDangerTime
          : isDangerTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      isInExam: freezed == isInExam
          ? _value.isInExam
          : isInExam // ignore: cast_nullable_to_non_nullable
              as bool?,
      examOnSubjectStates: freezed == examOnSubjectStates
          ? _value.examOnSubjectStates
          : examOnSubjectStates // ignore: cast_nullable_to_non_nullable
              as BaseStates<dynamic>?,
      checkUserAnswersStates: freezed == checkUserAnswersStates
          ? _value.checkUserAnswersStates
          : checkUserAnswersStates // ignore: cast_nullable_to_non_nullable
              as BaseStates<dynamic>?,
      userAnswers: freezed == userAnswers
          ? _value.userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<UserAnswers>?,
      navigationState: freezed == navigationState
          ? _value.navigationState
          : navigationState // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BaseStatesCopyWith<dynamic, $Res> get examStates {
    return $BaseStatesCopyWith<dynamic, $Res>(_value.examStates, (value) {
      return _then(_value.copyWith(examStates: value) as $Val);
    });
  }

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BaseStatesCopyWith<dynamic, $Res>? get examOnSubjectStates {
    if (_value.examOnSubjectStates == null) {
      return null;
    }

    return $BaseStatesCopyWith<dynamic, $Res>(_value.examOnSubjectStates!,
        (value) {
      return _then(_value.copyWith(examOnSubjectStates: value) as $Val);
    });
  }

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BaseStatesCopyWith<dynamic, $Res>? get checkUserAnswersStates {
    if (_value.checkUserAnswersStates == null) {
      return null;
    }

    return $BaseStatesCopyWith<dynamic, $Res>(_value.checkUserAnswersStates!,
        (value) {
      return _then(_value.copyWith(checkUserAnswersStates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExamStatesImplCopyWith<$Res>
    implements $ExamStatesCopyWith<$Res> {
  factory _$$ExamStatesImplCopyWith(
          _$ExamStatesImpl value, $Res Function(_$ExamStatesImpl) then) =
      __$$ExamStatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BaseStates<dynamic> examStates,
      int currentQuestionIndex,
      Map<int, int> selectedAnswers,
      int? examDuration,
      bool? examTimeOutState,
      bool? isLastQuestion,
      bool? isDangerTime,
      bool? isInExam,
      BaseStates<dynamic>? examOnSubjectStates,
      BaseStates<dynamic>? checkUserAnswersStates,
      List<UserAnswers>? userAnswers,
      String? navigationState});

  @override
  $BaseStatesCopyWith<dynamic, $Res> get examStates;
  @override
  $BaseStatesCopyWith<dynamic, $Res>? get examOnSubjectStates;
  @override
  $BaseStatesCopyWith<dynamic, $Res>? get checkUserAnswersStates;
}

/// @nodoc
class __$$ExamStatesImplCopyWithImpl<$Res>
    extends _$ExamStatesCopyWithImpl<$Res, _$ExamStatesImpl>
    implements _$$ExamStatesImplCopyWith<$Res> {
  __$$ExamStatesImplCopyWithImpl(
      _$ExamStatesImpl _value, $Res Function(_$ExamStatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examStates = null,
    Object? currentQuestionIndex = null,
    Object? selectedAnswers = null,
    Object? examDuration = freezed,
    Object? examTimeOutState = freezed,
    Object? isLastQuestion = freezed,
    Object? isDangerTime = freezed,
    Object? isInExam = freezed,
    Object? examOnSubjectStates = freezed,
    Object? checkUserAnswersStates = freezed,
    Object? userAnswers = freezed,
    Object? navigationState = freezed,
  }) {
    return _then(_$ExamStatesImpl(
      examStates: null == examStates
          ? _value.examStates
          : examStates // ignore: cast_nullable_to_non_nullable
              as BaseStates<dynamic>,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedAnswers: null == selectedAnswers
          ? _value._selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      examDuration: freezed == examDuration
          ? _value.examDuration
          : examDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      examTimeOutState: freezed == examTimeOutState
          ? _value.examTimeOutState
          : examTimeOutState // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLastQuestion: freezed == isLastQuestion
          ? _value.isLastQuestion
          : isLastQuestion // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDangerTime: freezed == isDangerTime
          ? _value.isDangerTime
          : isDangerTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      isInExam: freezed == isInExam
          ? _value.isInExam
          : isInExam // ignore: cast_nullable_to_non_nullable
              as bool?,
      examOnSubjectStates: freezed == examOnSubjectStates
          ? _value.examOnSubjectStates
          : examOnSubjectStates // ignore: cast_nullable_to_non_nullable
              as BaseStates<dynamic>?,
      checkUserAnswersStates: freezed == checkUserAnswersStates
          ? _value.checkUserAnswersStates
          : checkUserAnswersStates // ignore: cast_nullable_to_non_nullable
              as BaseStates<dynamic>?,
      userAnswers: freezed == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<UserAnswers>?,
      navigationState: freezed == navigationState
          ? _value.navigationState
          : navigationState // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExamStatesImpl implements _ExamStates {
  const _$ExamStatesImpl(
      {required this.examStates,
      this.currentQuestionIndex = 0,
      final Map<int, int> selectedAnswers = const {},
      this.examDuration,
      this.examTimeOutState,
      this.isLastQuestion,
      this.isDangerTime,
      this.isInExam,
      this.examOnSubjectStates,
      this.checkUserAnswersStates,
      final List<UserAnswers>? userAnswers,
      this.navigationState})
      : _selectedAnswers = selectedAnswers,
        _userAnswers = userAnswers;

  @override
  final BaseStates<dynamic> examStates;
  @override
  @JsonKey()
  final int currentQuestionIndex;
  final Map<int, int> _selectedAnswers;
  @override
  @JsonKey()
  Map<int, int> get selectedAnswers {
    if (_selectedAnswers is EqualUnmodifiableMapView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedAnswers);
  }

  @override
  final int? examDuration;
  @override
  final bool? examTimeOutState;
  @override
  final bool? isLastQuestion;
  @override
  final bool? isDangerTime;
  @override
  final bool? isInExam;
  @override
  final BaseStates<dynamic>? examOnSubjectStates;
  @override
  final BaseStates<dynamic>? checkUserAnswersStates;
  final List<UserAnswers>? _userAnswers;
  @override
  List<UserAnswers>? get userAnswers {
    final value = _userAnswers;
    if (value == null) return null;
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? navigationState;

  @override
  String toString() {
    return 'ExamStates(examStates: $examStates, currentQuestionIndex: $currentQuestionIndex, selectedAnswers: $selectedAnswers, examDuration: $examDuration, examTimeOutState: $examTimeOutState, isLastQuestion: $isLastQuestion, isDangerTime: $isDangerTime, isInExam: $isInExam, examOnSubjectStates: $examOnSubjectStates, checkUserAnswersStates: $checkUserAnswersStates, userAnswers: $userAnswers, navigationState: $navigationState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamStatesImpl &&
            (identical(other.examStates, examStates) ||
                other.examStates == examStates) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            const DeepCollectionEquality()
                .equals(other._selectedAnswers, _selectedAnswers) &&
            (identical(other.examDuration, examDuration) ||
                other.examDuration == examDuration) &&
            (identical(other.examTimeOutState, examTimeOutState) ||
                other.examTimeOutState == examTimeOutState) &&
            (identical(other.isLastQuestion, isLastQuestion) ||
                other.isLastQuestion == isLastQuestion) &&
            (identical(other.isDangerTime, isDangerTime) ||
                other.isDangerTime == isDangerTime) &&
            (identical(other.isInExam, isInExam) ||
                other.isInExam == isInExam) &&
            (identical(other.examOnSubjectStates, examOnSubjectStates) ||
                other.examOnSubjectStates == examOnSubjectStates) &&
            (identical(other.checkUserAnswersStates, checkUserAnswersStates) ||
                other.checkUserAnswersStates == checkUserAnswersStates) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers) &&
            (identical(other.navigationState, navigationState) ||
                other.navigationState == navigationState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      examStates,
      currentQuestionIndex,
      const DeepCollectionEquality().hash(_selectedAnswers),
      examDuration,
      examTimeOutState,
      isLastQuestion,
      isDangerTime,
      isInExam,
      examOnSubjectStates,
      checkUserAnswersStates,
      const DeepCollectionEquality().hash(_userAnswers),
      navigationState);

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamStatesImplCopyWith<_$ExamStatesImpl> get copyWith =>
      __$$ExamStatesImplCopyWithImpl<_$ExamStatesImpl>(this, _$identity);
}

abstract class _ExamStates implements ExamStates {
  const factory _ExamStates(
      {required final BaseStates<dynamic> examStates,
      final int currentQuestionIndex,
      final Map<int, int> selectedAnswers,
      final int? examDuration,
      final bool? examTimeOutState,
      final bool? isLastQuestion,
      final bool? isDangerTime,
      final bool? isInExam,
      final BaseStates<dynamic>? examOnSubjectStates,
      final BaseStates<dynamic>? checkUserAnswersStates,
      final List<UserAnswers>? userAnswers,
      final String? navigationState}) = _$ExamStatesImpl;

  @override
  BaseStates<dynamic> get examStates;
  @override
  int get currentQuestionIndex;
  @override
  Map<int, int> get selectedAnswers;
  @override
  int? get examDuration;
  @override
  bool? get examTimeOutState;
  @override
  bool? get isLastQuestion;
  @override
  bool? get isDangerTime;
  @override
  bool? get isInExam;
  @override
  BaseStates<dynamic>? get examOnSubjectStates;
  @override
  BaseStates<dynamic>? get checkUserAnswersStates;
  @override
  List<UserAnswers>? get userAnswers;
  @override
  String? get navigationState;

  /// Create a copy of ExamStates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExamStatesImplCopyWith<_$ExamStatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
