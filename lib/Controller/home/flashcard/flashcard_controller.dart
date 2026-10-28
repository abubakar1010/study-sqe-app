import 'package:get/get.dart';

import '../../../services/api_client.dart';
import '../../../utils/urls.dart';


class FlashcardController extends GetxController {
  var isLoadingAreas = false.obs;
  var isLoadingFlashcard = false.obs;
  var subjectAreas = <SubjectArea>[].obs;

  var currentFlashcard = Rxn<Flashcard>();
  var currentFlashcardId = ''.obs;

  void fetchSubjectAreas(String subjectId) async {
    try {
      isLoadingAreas(true);
      final response = await ApiClient.getData(Urls.getSubjectAreas(subjectId));

      if (response.statusCode == 200) {
        final data = response.body['data']['results'] as List;
        subjectAreas.value = data.map((e) => SubjectArea.fromJson(e)).toList();
      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to load areas');
      }
    } catch (e) {
     // Get.snackbar('!!!', 'Something went wrong');
    } finally {
      isLoadingAreas(false);
    }
  }

  void fetchLastSeenFlashcard(String areaId) async {
    try {
      isLoadingFlashcard(true);
      final response = await ApiClient.getData(Urls.getLastSeenFlashcard(areaId));

      if (response.statusCode == 200) {
        final data = response.body['data'];
        currentFlashcard.value = Flashcard.fromJson(data);
        currentFlashcardId.value = data['_id'] ?? '';
      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to load flashcard');
      }
    } catch (e) {
    //  Get.snackbar('!!!', 'Something went wrong');
    } finally {
      isLoadingFlashcard(false);
    }
  }

  void markAsCompletedAndFetchNext() async {
    if (currentFlashcardId.value.isEmpty) return;

    try {
      isLoadingFlashcard(true);
      final response = await ApiClient.patch(
        Urls.markFlashcardCompleted(currentFlashcardId.value),
        {},
      );

      if (response.statusCode == 200) {
        final data = response.body['data'];
        if (data != null) {
          currentFlashcard.value = Flashcard.fromJson(data);
          currentFlashcardId.value = data['_id'] ?? '';
        } else {
          Get.snackbar('Complete', 'No more flashcards available');
        }
      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to load next flashcard');
      }
    } catch (e) {
     // Get.snackbar('!!!!', 'Something went wrong');
    } finally {
      isLoadingFlashcard(false);
    }
  }
}

class SubjectArea {
  final String id;
  final String title;

  SubjectArea({required this.id, required this.title});

  factory SubjectArea.fromJson(Map<String, dynamic> json) {
    return SubjectArea(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}