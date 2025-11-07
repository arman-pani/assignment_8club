import 'package:assignment_8club/models/experience_model.dart';
import 'package:dio/dio.dart';

class ExperienceRepository {
  final Dio dio;
  ExperienceRepository(this.dio);

  Future<List<ExperienceModel>> getExperiences() async {
    final res = await dio.get("experiences?active=true");

    final list = res.data["data"]["experiences"] as List;

    return list.map((e) => ExperienceModel.fromJson(e)).toList();
  }
}

