import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_architecture_tdd/data/cache/cache.dart';
import 'package:flutter_clean_architecture_tdd/data/http/http.dart';

import 'package:flutter_clean_architecture_tdd/main/decorators/decorators.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

class DeleteSecureCacheStorageSpy extends Mock
    implements DeleteSecureCacheStorage {}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  AuthorizeHttpClientDecorator sut;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  DeleteSecureCacheStorageSpy deleteSecureCacheStorage;
  HttpClientSpy httpClient;
  String httpResponse, token, url, method;
  Map body;

  PostExpectation mockTokenCall() => when(fetchSecureCacheStorage.fetch(any));

  PostExpectation mockHttpResponseCall() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
        headers: anyNamed('headers'),
      ));

  void mockToken() {
    token = faker.guid.guid();
    mockTokenCall().thenAnswer((_) async => token);
  }

  void mockTokenError() {
    mockTokenCall().thenThrow(Exception());
  }

  void mockHttpResponseError(HttpError error) {
    mockHttpResponseCall().thenThrow(error);
  }

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);
    mockHttpResponseCall().thenAnswer((_) async => httpResponse);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    deleteSecureCacheStorage = DeleteSecureCacheStorageSpy();
    httpClient = HttpClientSpy();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      deleteSecureCacheStorage: deleteSecureCacheStorage,
      decoratee: httpClient,
    );
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(6);
    body = {'any_key': 'any_value'};
    mockToken();
    mockHttpResponse();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetch('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(url: url, method: method, body: body);
    verify(httpClient.request(
      url: url,
      method: method,
      body: body,
      headers: {'x-access-token': token},
    )).called(1);

    await sut.request(
        url: url,
        method: method,
        body: body,
        headers: {'any_header': 'any_value'});
    verify(httpClient.request(
      url: url,
      method: method,
      body: body,
      headers: {'x-access-token': token, 'any_header': 'any_value'},
    )).called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await sut.request(url: url, method: method, body: body);

    expect(response, httpResponse);
  });

  test('Should throw if FetchSecureCacheStorage throws', () async {
    mockTokenError();

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorage.delete('token')).called(1);
  });

  test('Should rethrow if decoratee throws', () async {
    mockHttpResponseError(HttpError.badRequest);

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should delete cache if request throws ForbiddenError', () async {
    mockHttpResponseError(HttpError.forbidden);

    final future = sut.request(url: url, method: method, body: body);
    await untilCalled(deleteSecureCacheStorage.delete('token'));

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorage.delete('token')).called(1);
  });
}
