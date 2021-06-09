/// Mandatory field.
///
/// **Note:** both the **null** value and the empty string **''** are **invalid inputs**.
class Req {
  /// Non-blank field with an optional extra validation step.
  ///
  /// [val] is the validation step to be performed after ensuring that the field
  /// was not left blank; [blank] is the error message in case of a null or
  /// empty value.
  const Req({required String blank}) : _blank = blank;

  final String _blank;

  /// Valid - returns null - if [value] is neither null nor empty.
  String? call(String? value) => value == null || value.isEmpty ? _blank : null;
}
