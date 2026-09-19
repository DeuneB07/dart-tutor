import '../core/app_lang.dart';
import '../models/topic.dart';
import 'topics_data_en.dart';
import 'topics_data_es.dart';

List<Topic> get kTopics => switch (AppLang.code) {
  'es' => kTopicsEs,
  _ => kTopicsEn,
};
