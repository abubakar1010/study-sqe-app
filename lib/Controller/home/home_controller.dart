import 'package:get/get.dart';

import '../../services/api_client.dart';
import '../../utils/urls.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var subjects = <Subject>[].obs;

  void fetchSubjects(String assessment, String type) async {
    try {
      isLoading(true);
      final response = await ApiClient.getData(
          Urls.getSubjects(assessment, type)
      );

      if (response.statusCode == 200) {
        final data = response.body['data']['results'] as List;
        subjects.value = data.map((e) => Subject.fromJson(e)).toList();
      } else {
        Get.snackbar('!!!!', response.body['message'] ?? 'Failed to load subjects');
      }
    } catch (e) {
      Get.snackbar('!!!!', 'Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}

class Subject {
  final String id;
  final String title;

  Subject({required this.id, required this.title});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}