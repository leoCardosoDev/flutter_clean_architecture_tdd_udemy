import 'package:meta/meta.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_architecture_tdd/data/http/http_client.dart';

class RemoteLoadSurveys {
  final String url;
  final HttpClient<List<Map>> httpClient;

  RemoteLoadSurveys({@required this.url, @required this.httpClient});

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}

class HttpClientSpy extends Mock implements HttpClient<List<Map>> {}

void main() {
  RemoteLoadSurveys sut;
  HttpClientSpy httpClient;
  String url;

  List<Map> mockValidData() => [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        }
      ];

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadSurveys(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });

  test('Should return surveys on 200', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method')))
        .thenAnswer((_) async => mockValidData());
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });
}
