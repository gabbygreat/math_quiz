import 'dart:io';
import '../utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._init();
  static BoxCollection? _collection;
  LocalStorage._init();

  Future<BoxCollection> get collection async {
    Directory directory = await getApplicationDocumentsDirectory();

    if (_collection != null) return _collection!;
    _collection = await BoxCollection.open(
      'MathQuiz',
      {'math_question'},
      path: directory.path,
    );
    return _collection!;
  }

  Future<void> createSpelling() async {
    if ((await getSpelling()).isEmpty) {
      final colIns = await instance.collection;
      final questionBox = await colIns.openBox<Map>('math_question');

      await (await collection).transaction(
        () async {
          for (var i in questions) {
            await questionBox.put(
              '${questions.indexOf(i) + 1}',
              i.toJson(),
            );
            await updateLastQuestion(questions.indexOf(i) + 1);
          }
        },
        boxNames: ['quest'],
        readOnly: false,
      );
    }
  }

  Future<void> updateQuestions(List<QuestionModel> list) async {
    final colIns = await instance.collection;
    final questionBox = await colIns.openBox<Map>('math_question');

    await (await collection).transaction(
      () async {
        for (var i in list) {
          await questionBox.put(
            '${list.indexOf(i) + 1}',
            i.toJson(),
          );
          await updateLastQuestion(list.indexOf(i) + 1);
        }
      },
      boxNames: ['quest'],
      readOnly: false,
    );
  }

  Future<void> deleteAllSpelling() async {
    final colIns = await instance.collection;
    final questionBox = await colIns.openBox<Map>('math_question');
    questionBox.clear();
  }

  Future<void> updateLastQuestion(int lastNumber) async {
    final colIns = await instance.collection;
    final questionBox = await colIns.openBox<Map>('math_question');
    await questionBox.put('lastNumber', {'lastNumber': lastNumber});
  }

  Future<int?> getLastQuestionNumber() async {
    final colIns = await instance.collection;
    final questionBox = await colIns.openBox<Map>('math_question');
    final a = await questionBox.get('lastNumber');
    if (a == null) return null;
    return (await questionBox.get('lastNumber'))!['lastNumber'] as int;
  }

  Future<List<QuestionModel?>> getSpelling() async {
    final colIns = await instance.collection;
    final questionBox = await colIns.openBox<Map>('math_question');
    List<QuestionModel?> questions = [];
    final int? last = await getLastQuestionNumber();
    if (last == null) return [];
    for (int i = 1; i <= last; i++) {
      final question = await questionBox.get('$i');
      questions.add(QuestionModel.fromJson(question));
    }
    return questions;
  }
}
