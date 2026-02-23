// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'songs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SongsState {


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SongsState);
  }


  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SongsState()';
  }


}

/// @nodoc
class $SongsStateCopyWith<$Res> {
  $SongsStateCopyWith(SongsState _, $Res Function(SongsState) __);
}


/// Adds pattern-matching-related methods to [SongsState].
extension SongsStatePatterns on SongsState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  {

  TResult

  Function

  (

  SongsInitial

  value

  )

  ?

  initial

  ,

  TResult

  Function

  (

  SongsLoading

  value

  )

  ?

  loading

  ,

  TResult

  Function

  (

  SongsRefreshing

  value

  )

  ?

  refreshing

  ,

  TResult

  Function

  (

  SongsSuccess

  value

  )

  ?

  success

  ,

  TResult

  Function

  (

  SongsError

  value

  )

  ?

  error

  ,

  required

  TResult

  orElse

  (

  )

  ,
}){
final _that = this;
switch (_that) {
case SongsInitial() when initial != null:
return initial(_that);case SongsLoading() when loading != null:
return loading(_that);case SongsRefreshing() when refreshing != null:
return refreshing(_that);case SongsSuccess() when success != null:
return success(_that);case SongsError() when error != null:
return error(_that);case _:
return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs
TResult map<TResult extends Object?>(
    {required TResult Function( SongsInitial value) initial, required TResult Function( SongsLoading value) loading, required TResult Function( SongsRefreshing value) refreshing, required TResult Function( SongsSuccess value) success, required TResult Function( SongsError value) error,}) {
  final _that = this;
  switch (_that) {
    case SongsInitial():
      return initial(_that);
    case SongsLoading():
      return loading(_that);
    case SongsRefreshing():
      return refreshing(_that);
    case SongsSuccess():
      return success(_that);
    case SongsError():
      return error(_that);
  }
}

/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs
TResult? mapOrNull<TResult extends Object?>(
    {TResult? Function( SongsInitial value)? initial, TResult? Function( SongsLoading value)? loading, TResult? Function( SongsRefreshing value)? refreshing, TResult? Function( SongsSuccess value)? success, TResult? Function( SongsError value)? error,}) {
  final _that = this;
  switch (_that) {
    case SongsInitial() when initial != null:
      return initial(_that);
    case SongsLoading() when loading != null:
      return loading(_that);
    case SongsRefreshing() when refreshing != null:
      return refreshing(_that);
    case SongsSuccess() when success != null:
      return success(_that);
    case SongsError() when error != null:
      return error(_that);
    case _:
      return null;
  }
}

/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen
<
TResult extends Object?>(
{
TResult
Function
(
)
?
initial
,
TResult
Function
(
String
?
searchQuery
)
?
loading
,
TResult
Function
(
List
<
Song
>
songs
,
String
?
searchQuery
)
?
refreshing
,
TResult
Function
(
List
<
Song
>
songs
,
String
?
searchQuery
)
?
success
,
TResult
Function
(
ApiException
error
,
String
?
searchQuery
)
?
error
,
required
TResult
orElse(),}) {final _that = this;
switch (_that) {
case SongsInitial() when initial != null:
return initial();case SongsLoading() when loading != null:
return loading(_that.searchQuery);case SongsRefreshing() when refreshing != null:
return refreshing(_that.songs,_that.searchQuery);case SongsSuccess() when success != null:
return success(_that.songs,_that.searchQuery);case SongsError() when error != null:
return error(_that.error,_that.searchQuery);case _:
return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function() initial,required TResult Function( String? searchQuery) loading,required TResult Function( List<Song> songs, String? searchQuery) refreshing,required TResult Function( List<Song> songs, String? searchQuery) success,required TResult Function( ApiException error, String? searchQuery) error,}) {final _that = this;
switch (_that) {
case SongsInitial():
return initial();case SongsLoading():
return loading(_that.searchQuery);case SongsRefreshing():
return refreshing(_that.songs,_that.searchQuery);case SongsSuccess():
return success(_that.songs,_that.searchQuery);case SongsError():
return error(_that.error,_that.searchQuery);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()? initial,TResult? Function( String? searchQuery)? loading,TResult? Function( List<Song> songs, String? searchQuery)? refreshing,TResult? Function( List<Song> songs, String? searchQuery)? success,TResult? Function( ApiException error, String? searchQuery)? error,}) {final _that = this;
switch (_that) {
case SongsInitial() when initial != null:
return initial();case SongsLoading() when loading != null:
return loading(_that.searchQuery);case SongsRefreshing() when refreshing != null:
return refreshing(_that.songs,_that.searchQuery);case SongsSuccess() when success != null:
return success(_that.songs,_that.searchQuery);case SongsError() when error != null:
return error(_that.error,_that.searchQuery);case _:
return null;

}
}

}

/// @nodoc


class SongsInitial extends SongsState {
const SongsInitial(): super._();


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is SongsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
return 'SongsState.initial()';
}


}


/// @nodoc


class SongsLoading extends SongsState {
const SongsLoading({this.searchQuery}): super._();


final String? searchQuery;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SongsLoadingCopyWith<SongsLoading> get copyWith => _$SongsLoadingCopyWithImpl<SongsLoading>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is SongsLoading&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery);

@override
String toString() {
return 'SongsState.loading(searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $SongsLoadingCopyWith<$Res> implements $SongsStateCopyWith<$Res> {
factory $SongsLoadingCopyWith(SongsLoading value, $Res Function(SongsLoading) _then) = _$SongsLoadingCopyWithImpl;
@useResult
$Res call({
String? searchQuery
});


}
/// @nodoc
class _$SongsLoadingCopyWithImpl<$Res>
implements $SongsLoadingCopyWith<$Res> {
_$SongsLoadingCopyWithImpl(this._self, this._then);

final SongsLoading _self;
final $Res Function(SongsLoading) _then;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? searchQuery = freezed,}) {
return _then(SongsLoading(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,
));
}


}

/// @nodoc


class SongsRefreshing extends SongsState {
const SongsRefreshing({required final List<Song> songs, this.searchQuery}): _songs = songs,super._();


final List<Song> _songs;
List<Song> get songs {
if (_songs is EqualUnmodifiableListView) return _songs;
// ignore: implicit_dynamic_type
return EqualUnmodifiableListView(_songs);
}

final String? searchQuery;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SongsRefreshingCopyWith<SongsRefreshing> get copyWith => _$SongsRefreshingCopyWithImpl<SongsRefreshing>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is SongsRefreshing&&const DeepCollectionEquality().equals(other._songs, _songs)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_songs),searchQuery);

@override
String toString() {
return 'SongsState.refreshing(songs: $songs, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $SongsRefreshingCopyWith<$Res> implements $SongsStateCopyWith<$Res> {
factory $SongsRefreshingCopyWith(SongsRefreshing value, $Res Function(SongsRefreshing) _then) = _$SongsRefreshingCopyWithImpl;
@useResult
$Res call({
List<Song> songs, String? searchQuery
});


}
/// @nodoc
class _$SongsRefreshingCopyWithImpl<$Res>
implements $SongsRefreshingCopyWith<$Res> {
_$SongsRefreshingCopyWithImpl(this._self, this._then);

final SongsRefreshing _self;
final $Res Function(SongsRefreshing) _then;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? songs = null,Object? searchQuery = freezed,}) {
return _then(SongsRefreshing(
songs: null == songs ? _self._songs : songs // ignore: cast_nullable_to_non_nullable
as List<Song>,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,
));
}


}

/// @nodoc


class SongsSuccess extends SongsState {
const SongsSuccess({required final List<Song> songs, this.searchQuery}): _songs = songs,super._();


final List<Song> _songs;
List<Song> get songs {
if (_songs is EqualUnmodifiableListView) return _songs;
// ignore: implicit_dynamic_type
return EqualUnmodifiableListView(_songs);
}

final String? searchQuery;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SongsSuccessCopyWith<SongsSuccess> get copyWith => _$SongsSuccessCopyWithImpl<SongsSuccess>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is SongsSuccess&&const DeepCollectionEquality().equals(other._songs, _songs)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_songs),searchQuery);

@override
String toString() {
return 'SongsState.success(songs: $songs, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $SongsSuccessCopyWith<$Res> implements $SongsStateCopyWith<$Res> {
factory $SongsSuccessCopyWith(SongsSuccess value, $Res Function(SongsSuccess) _then) = _$SongsSuccessCopyWithImpl;
@useResult
$Res call({
List<Song> songs, String? searchQuery
});


}
/// @nodoc
class _$SongsSuccessCopyWithImpl<$Res>
implements $SongsSuccessCopyWith<$Res> {
_$SongsSuccessCopyWithImpl(this._self, this._then);

final SongsSuccess _self;
final $Res Function(SongsSuccess) _then;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? songs = null,Object? searchQuery = freezed,}) {
return _then(SongsSuccess(
songs: null == songs ? _self._songs : songs // ignore: cast_nullable_to_non_nullable
as List<Song>,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,
));
}


}

/// @nodoc


class SongsError extends SongsState {
const SongsError({required this.error, this.searchQuery}): super._();


final ApiException error;
final String? searchQuery;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SongsErrorCopyWith<SongsError> get copyWith => _$SongsErrorCopyWithImpl<SongsError>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is SongsError&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,error,searchQuery);

@override
String toString() {
return 'SongsState.error(error: $error, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $SongsErrorCopyWith<$Res> implements $SongsStateCopyWith<$Res> {
factory $SongsErrorCopyWith(SongsError value, $Res Function(SongsError) _then) = _$SongsErrorCopyWithImpl;
@useResult
$Res call({
ApiException error, String? searchQuery
});


}
/// @nodoc
class _$SongsErrorCopyWithImpl<$Res>
implements $SongsErrorCopyWith<$Res> {
_$SongsErrorCopyWithImpl(this._self, this._then);

final SongsError _self;
final $Res Function(SongsError) _then;

/// Create a copy of SongsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? searchQuery = freezed,}) {
return _then(SongsError(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiException,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,
));
}


}

// dart format on
