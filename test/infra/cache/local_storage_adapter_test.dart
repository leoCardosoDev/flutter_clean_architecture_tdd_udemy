import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_clean_architecture_tdd/infra/cache/cache.dart';

class FLutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  FLutterSecureStorageSpy secureStorage;
  LocalStorageAdapter sut;
  String key, value;

  setUp(() {
    secureStorage = FLutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
  });

  void mockSaveSecureError() {
    when(secureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());
  }

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);
    verify(secureStorage.write(key: key, value: value));
  });

  test('Should throw if save secure throws', () async {
    mockSaveSecureError();
    final future = sut.saveSecure(key: key, value: value);
    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
