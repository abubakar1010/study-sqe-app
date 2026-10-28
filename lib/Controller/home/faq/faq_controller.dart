import 'package:get/get.dart';
import 'package:studysqet/services/api_client.dart';
import '../../../utils/urls.dart';


class FaqController extends GetxController {
  var isLoading = false.obs;
  var faqs = <Faq>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  void fetchFaqs() async {
    try {
      isLoading(true);
      final response = await ApiClient.getData(Urls.getFaqs);

      if (response.statusCode == 200) {
        final data = response.body['data'] as List;
        faqs.value = data.map((e) => Faq.fromJson(e)).toList();
      } else {
        Get.snackbar('!!!', response.body['message'] ?? 'Failed to load FAQs');
      }
    } catch (e) {
      Get.snackbar('!!!', 'Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}

class Faq {
  final String id;
  final String question;
  final String answer;

  Faq({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['_id'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}