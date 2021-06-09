import 'package:flutter_test/flutter_test.dart';
import 'package:callor/callor.dart';

import 'counter.dart';

void main() {
  group('Multiple rules', () {
    test('- special case: empty list of rules', () {
      final norules = Rules([]);
      expect(norules(null), null);
      expect(norules(''), null);
      expect(norules('non-blank input'), null);
    });
    test('single rule', () {
      final counter = Counter();
      final single = Rules([counter]);
      expect(single(null), null);
      expect(single(''), null);
      expect(single('non-blank input'), null);
      expect(counter.value, 3);
    });
    test('multiple rules', () {
      final counter = Counter();
      const error = 'error';
      final theRules = <Callor>[
        counter,
        const Ok(),
        counter,
        // the last rule is always invalid regardless of the input value
        const Nok(msg: error),
      ];
      final multiple = Rules(theRules);
      expect(multiple(null), error);
      expect(multiple(''), error);
      expect(multiple('non-blank input'), error);
      expect(counter.value, 6);
    });
  });
}
