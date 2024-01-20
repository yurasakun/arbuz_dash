import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
/// {@template user}
/// User model
/// {@endtemplate}
///
@JsonSerializable()
class User extends Equatable {
  /// {@macro user}
  const User( {
    required this.id,
    required this.authDate,
    required this.lastScore,
    required this.fullName,
    required this.userName,
  });


  /// Factory which converts a [Map] into a [User].
  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  /// The current user's id.
  @JsonKey(name: 'userId')
  final String id;

  /// The current user's auth date.
  @JsonKey(name: 'authDate')
  final String authDate;

  /// The current user's last score.
  @JsonKey(name: 'lastScore')
  final int lastScore;

  /// The current user's full Name.
  @JsonKey(name: 'name')
  final String fullName;

  ///
  @JsonKey(name: 'userName')
  final String userName;

  /// Converts the [User] to [Map].
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, authDate, lastScore, fullName, userName];
}
