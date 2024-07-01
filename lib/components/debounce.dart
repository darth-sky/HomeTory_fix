import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

T useDebounce<T>(T value, Duration delay) {
  final debouncedValue = useState(value);
  final timer = useRef<Timer?>(null);

  useEffect(() {
    timer.value?.cancel();
    timer.value = Timer(delay, () {
      debouncedValue.value = value;
    });
    return () => timer.value?.cancel();
  }, [value, delay]);

  return debouncedValue.value;
}
