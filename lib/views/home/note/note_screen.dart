import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studysqet/global_widgets/custom_text.dart';
import 'package:studysqet/global_widgets/custom_text_button.dart';
import 'package:studysqet/utils/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Controller/home/note/note_controller.dart';


class NoteScreen extends StatefulWidget {
  final String? subjectId;
  final String? subjectName;

  const NoteScreen({super.key, this.subjectId, this.subjectName});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NoteController controller = Get.put(NoteController());

  @override
  void initState() {
    super.initState();
    if (widget.subjectId != null) {
      controller.fetchNote(widget.subjectId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return CustomTextOne(
            text: controller.currentNote.value?.title ??
                widget.subjectName ?? "Note",
          );
        }),
      ),
      body: Obx(() {
        if (controller.isLoadingNote.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.currentNote.value == null) {
          return const Center(child: Text('No note available'));
        }

        final note = controller.currentNote.value!;

        return SfPdfViewer.network(
          note.url,
          canShowPageLoadingIndicator: true,
          canShowScrollHead: true,
          canShowPaginationDialog: true,
          canShowScrollStatus: true,
          canShowTextSelectionMenu: true,
          enableTextSelection: true,
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.currentNote.value == null) {
          return SizedBox.shrink();
        }

        final note = controller.currentNote.value!;
        final isCompleted = note.isCompleted;

        return Padding(
          padding: EdgeInsets.all(16.h),
          child: CustomTextButton(
            text: isCompleted ? "Completed" : "Mark as Complete",
            isLoading: controller.isMarkingComplete.value,
            onTap: isCompleted
                ? () {}
                : () {
              if (controller.currentNote.value?.id != null) {
                controller.markAsComplete(controller.currentNote.value!.id);
              }
            },
            color: isCompleted ? Colors.grey : AppColors.primaryColor,
          ),
        );
      }),
    );
  }
}

