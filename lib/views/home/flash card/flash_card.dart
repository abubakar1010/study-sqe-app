import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/global_widgets/custom_text_button.dart';
import 'package:studysqet/utils/app_colors.dart';

import '../../../Controller/home/flashcard/flashcard_controller.dart';

class FlashCardScreen extends StatefulWidget {
  final String? areaId;

  const FlashCardScreen({super.key, this.areaId});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  final FlashcardController controller = Get.put(FlashcardController());
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    if (widget.areaId != null) {
      controller.fetchLastSeenFlashcard(widget.areaId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(text: "Flashcards"),
      ),
      body: Obx(() {
        if (controller.isLoadingFlashcard.value &&
            controller.currentFlashcard.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.currentFlashcard.value == null) {
          return const Center(child: Text('No flashcard available'));
        }

        final flashcard = controller.currentFlashcard.value!;

        return Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              FlipCard(
                key: cardKey,
                fill: Fill.fillBack,
                direction: FlipDirection.HORIZONTAL,
                side: CardSide.FRONT,
                front: buildContainer(
                  flashcard.question,
                  Color(0xffE8B57F),
                ),
                back: buildContainer(
                  flashcard.answer,
                  AppColors.cardColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Flexible(
                    child: CustomTextButton(
                      text: "Previous",
                      onTap: () {
                        // You can implement previous functionality if needed
                        Get.snackbar('Info', 'Previous not available');
                      },
                      color: Colors.white,
                      borderColor: Colors.black.withOpacity(0.7),
                      textColor: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Flexible(
                    child: Obx(() {
                      return CustomTextButton(
                        text: "Next",
                        isLoading: controller.isLoadingFlashcard.value,
                        onTap: () {
                         // cardKey.currentState?.toggleCard();
                          Future.delayed(Duration(milliseconds: 300), () {
                            controller.markAsCompletedAndFetchNext();
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }

  Widget buildContainer(String content, Color color) {
    return Container(
      height: 450.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(4, 4),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: CustomTextTwo(text: content),
        ),
      ),
    );
  }
}