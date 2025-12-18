// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chord.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Chord {

 String get root;// e.g. "C#"
 String get name;// e.g. "Major 7th"
 String get writtenAs;// e.g. "C#7"
 Map<InversionType, Map<Instrument, String>> get assets;
/// Create a copy of Chord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChordCopyWith<Chord> get copyWith => _$ChordCopyWithImpl<Chord>(this as Chord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chord&&(identical(other.root, root) || other.root == root)&&(identical(other.name, name) || other.name == name)&&(identical(other.writtenAs, writtenAs) || other.writtenAs == writtenAs)&&const DeepCollectionEquality().equals(other.assets, assets));
}


@override
int get hashCode => Object.hash(runtimeType,root,name,writtenAs,const DeepCollectionEquality().hash(assets));

@override
String toString() {
  return 'Chord(root: $root, name: $name, writtenAs: $writtenAs, assets: $assets)';
}


}

/// @nodoc
abstract mixin class $ChordCopyWith<$Res>  {
  factory $ChordCopyWith(Chord value, $Res Function(Chord) _then) = _$ChordCopyWithImpl;
@useResult
$Res call({
 String root, String name, String writtenAs, Map<InversionType, Map<Instrument, String>> assets
});




}
/// @nodoc
class _$ChordCopyWithImpl<$Res>
    implements $ChordCopyWith<$Res> {
  _$ChordCopyWithImpl(this._self, this._then);

  final Chord _self;
  final $Res Function(Chord) _then;

/// Create a copy of Chord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? root = null,Object? name = null,Object? writtenAs = null,Object? assets = null,}) {
  return _then(_self.copyWith(
root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,writtenAs: null == writtenAs ? _self.writtenAs : writtenAs // ignore: cast_nullable_to_non_nullable
as String,assets: null == assets ? _self.assets : assets // ignore: cast_nullable_to_non_nullable
as Map<InversionType, Map<Instrument, String>>,
  ));
}

}


/// Adds pattern-matching-related methods to [Chord].
extension ChordPatterns on Chord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Chord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Chord() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Chord value)  $default,){
final _that = this;
switch (_that) {
case _Chord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Chord value)?  $default,){
final _that = this;
switch (_that) {
case _Chord() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String root,  String name,  String writtenAs,  Map<InversionType, Map<Instrument, String>> assets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chord() when $default != null:
return $default(_that.root,_that.name,_that.writtenAs,_that.assets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String root,  String name,  String writtenAs,  Map<InversionType, Map<Instrument, String>> assets)  $default,) {final _that = this;
switch (_that) {
case _Chord():
return $default(_that.root,_that.name,_that.writtenAs,_that.assets);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String root,  String name,  String writtenAs,  Map<InversionType, Map<Instrument, String>> assets)?  $default,) {final _that = this;
switch (_that) {
case _Chord() when $default != null:
return $default(_that.root,_that.name,_that.writtenAs,_that.assets);case _:
  return null;

}
}

}

/// @nodoc


class _Chord implements Chord {
  const _Chord({required this.root, required this.name, required this.writtenAs, required final  Map<InversionType, Map<Instrument, String>> assets}): _assets = assets;
  

@override final  String root;
// e.g. "C#"
@override final  String name;
// e.g. "Major 7th"
@override final  String writtenAs;
// e.g. "C#7"
 final  Map<InversionType, Map<Instrument, String>> _assets;
// e.g. "C#7"
@override Map<InversionType, Map<Instrument, String>> get assets {
  if (_assets is EqualUnmodifiableMapView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_assets);
}


/// Create a copy of Chord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChordCopyWith<_Chord> get copyWith => __$ChordCopyWithImpl<_Chord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chord&&(identical(other.root, root) || other.root == root)&&(identical(other.name, name) || other.name == name)&&(identical(other.writtenAs, writtenAs) || other.writtenAs == writtenAs)&&const DeepCollectionEquality().equals(other._assets, _assets));
}


@override
int get hashCode => Object.hash(runtimeType,root,name,writtenAs,const DeepCollectionEquality().hash(_assets));

@override
String toString() {
  return 'Chord(root: $root, name: $name, writtenAs: $writtenAs, assets: $assets)';
}


}

/// @nodoc
abstract mixin class _$ChordCopyWith<$Res> implements $ChordCopyWith<$Res> {
  factory _$ChordCopyWith(_Chord value, $Res Function(_Chord) _then) = __$ChordCopyWithImpl;
@override @useResult
$Res call({
 String root, String name, String writtenAs, Map<InversionType, Map<Instrument, String>> assets
});




}
/// @nodoc
class __$ChordCopyWithImpl<$Res>
    implements _$ChordCopyWith<$Res> {
  __$ChordCopyWithImpl(this._self, this._then);

  final _Chord _self;
  final $Res Function(_Chord) _then;

/// Create a copy of Chord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? root = null,Object? name = null,Object? writtenAs = null,Object? assets = null,}) {
  return _then(_Chord(
root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,writtenAs: null == writtenAs ? _self.writtenAs : writtenAs // ignore: cast_nullable_to_non_nullable
as String,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as Map<InversionType, Map<Instrument, String>>,
  ));
}


}

// dart format on
