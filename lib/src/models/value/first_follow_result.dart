import 'package:thenafter_dart/src/util/types_util.dart';

/// A data class to store the result of first and follow sets
class FirstFollowResult {
  /// The first-set map for each production
  final ProductionTerminals firstList;

  /// The follow-set map for each production
  final ProductionTerminals followList;

  /// Default constructor that initializes both first and follow sets
  const FirstFollowResult(this.firstList, this.followList);
}
