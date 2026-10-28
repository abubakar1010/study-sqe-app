import 'package:get/get.dart';
import '../../../services/api_client.dart';
import '../../../utils/urls.dart';

class NoteController extends GetxController {
  var isLoadingNote = false.obs;
  var currentNote = Rxn<Note>();
  var isMarkingComplete = false.obs;

  void fetchNote(String subjectId) async {
    try {
      isLoadingNote(true);
      final response = await ApiClient.getData(Urls.getNotes(subjectId));

      if (response.statusCode == 200) {
        final data = response.body['data'];
        if (data != null) {
          currentNote.value = Note.fromJson(data);
        } else {
          Get.snackbar('Info', 'No notes available for this subject');
        }
      } else {
       // Get.snackbar('!!!', response.body['message'] ?? 'Failed to load note');
      }
    } catch (e) {
      Get.snackbar('!!!', 'Something went wrong');
    } finally {
      isLoadingNote(false);
    }
  }

  void markAsComplete(String subjectId) async {
    try {
      isMarkingComplete(true);
      final response = await ApiClient.postData(
        Urls.markNoteAsComplete(subjectId),
        {},
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Note marked as completed');
        if (currentNote.value != null) {
          currentNote.value = Note(
            id: currentNote.value!.id,
            title: currentNote.value!.title,
            url: currentNote.value!.url,
            isCompleted: true,
          );
        }
      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to mark as complete');
      }
    } catch (e) {
      Get.snackbar('!!!', 'Something went wrong');
    } finally {
      isMarkingComplete(false);
    }
  }
}

class Note {
  final String id;
  final String title;
  final String url;
  final bool isCompleted;

  Note({
    required this.id,
    required this.title,
    required this.url,
    required this.isCompleted,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}