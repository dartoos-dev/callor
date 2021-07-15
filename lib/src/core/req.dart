import 'package:formdator/formdator.dart';

/// Validator for mandatory input data.
///
/// It will reject null or empty input values.
///
/// **Note:** the accepted input types are String, Iterable, and Map.
class Req {
  /// Checks whether an input value is blank — that is, whether the input value
  /// is null or empty.
  ///
  /// [blank] the error message in case of a null or empty input value; the
  /// default is 'required'.
  Req({String? blank}) : this.val(const Ok(), blank: blank);

  /// Checks whether an input value is blank. If it is not blank, then the
  /// additional validation step will be performed on the input value.
  ///
  /// [val] the additional validation step.
  /// [blank] the error message in case of a null or empty input value; the
  /// default is 'required'.
  Req.val(ValObj val, {String? blank})
      : _val = val,
        _blank = blank ?? 'required';

  /// It performs the same as the [Req.val] constructor, but it restricts the
  /// input type to [String].
  ///
  /// [val] the additional validation step.
  /// [blank] the error message in case of a null or empty input value; the
  /// default is 'required'.
  Req.str(ValStr val, {String? blank}) : this.val(ToValObj(val), blank: blank);

  /// It performs the same task as the [Req.val] constructor, but for many
  /// validators at once.
  Req.many(Iterable<ValObj> vals, {String? blank})
      : this.val(Rules<Object>(vals), blank: blank);

  final String _blank;
  final ValObj _val;

  /// Valid - returns null - if [input] is neither null nor empty.
  String? call(Object? input) =>
      (input == null || _isEmpty(input)) ? _blank : _val(input);

  bool _isEmpty(Object input) {
    return (input is String && input.isEmpty) ||
        (input is Iterable && input.isEmpty) ||
        (input is Map && input.isEmpty);
  }
}
