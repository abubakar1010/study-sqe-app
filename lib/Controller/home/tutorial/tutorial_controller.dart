import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:studysqet/services/api_client.dart';
import 'package:studysqet/utils/urls.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class TutorialController extends GetxController {
  var isLoadingTutorials = false.obs;
  var tutorials = <Tutorial>[].obs;
  var currentTutorialIndex = 0.obs;
  var isMarkingComplete = false.obs;
  var isPlayerInitialized = false.obs;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void onInit() {
    super.onInit();
    WakelockPlus.enable(); // Keep screen on while playing videos
  }

  @override
  void onClose() {
    disposePlayer();
    WakelockPlus.disable();
    super.onClose();
  }

  void disposePlayer() {
    chewieController?.dispose();
    videoPlayerController?.dispose();
    chewieController = null;
    videoPlayerController = null;
    isPlayerInitialized.value = false;
  }

  bool isHLSVideo(String url) {
    return url.toLowerCase().contains('.m3u8') ||
        url.toLowerCase().contains('m3u8');
  }

  void initializePlayer(String url) async {
    try {
      // Dispose previous player
      disposePlayer();
      isPlayerInitialized.value = false;

      print("Initializing video player for: $url");

      // Determine video type
      VideoPlayerController controller;
      if (isHLSVideo(url)) {
        print("Loading HLS stream");
        controller = VideoPlayerController.networkUrl(
          Uri.parse(url),
          videoPlayerOptions: VideoPlayerOptions(
            mixWithOthers: true,
            allowBackgroundPlayback: false,

          ),

        );
      } else {
        print("Loading MP4 video");
        controller = VideoPlayerController.networkUrl(
          Uri.parse(url),
          videoPlayerOptions: VideoPlayerOptions(
            mixWithOthers: true,
            allowBackgroundPlayback: false,
          ),
        );
      }

      videoPlayerController = controller;

      // Initialize video player
      await videoPlayerController!.initialize();

      // Create Chewie controller with custom controls
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        allowedScreenSleep: false,
        showControlsOnInitialize: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.transparent,
          handleColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          bufferedColor: Colors.transparent,
        ),

        placeholder: Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.transparent,
            ),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Error loading video',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );

      isPlayerInitialized.value = true;
      print("Video player initialized successfully");
    } catch (e) {
      print("Error initializing video player: $e");
      isPlayerInitialized.value = false;

      Get.snackbar(
        'Error',
        'Failed to load video. Please check your internet connection.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        duration: Duration(seconds: 3),
      );
    }
  }

  void fetchTutorials(String subjectId) async {
    try {
      isLoadingTutorials(true);
      final response = await ApiClient.getData(Urls.getTutorials(subjectId));

      if (response.statusCode == 200) {
        final data = response.body['data']['data'] as List;
        tutorials.value = data.map((e) => Tutorial.fromJson(e)).toList();

        if (tutorials.isNotEmpty) {
          currentTutorialIndex.value = 0;
          // Initialize first video
          initializePlayer(tutorials[0].url);
        }
      } else {
        Get.snackbar(
          'Error',
          response.body['message'] ?? 'Failed to load tutorials',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        '!!!',
        'Something went wrong: $e',

      );
    } finally {
      isLoadingTutorials(false);
    }
  }

  void markAsComplete(String tutorialId, int index) async {
    try {
      isMarkingComplete(true);
      final response = await ApiClient.postData(
        Urls.markTutorialComplete(tutorialId),
        {},
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Tutorial marked as completed',

        );

        // Update the tutorial completion status
        if (index < tutorials.length) {
          tutorials[index] = Tutorial(
            id: tutorials[index].id,
            title: tutorials[index].title,
            url: tutorials[index].url,
            isComplete: true,
          );
          tutorials.refresh();
        }
      } else {
        Get.snackbar(
          '!!!!',
          response.body['message'] ?? 'Failed to mark as complete',

        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isMarkingComplete(false);
    }
  }

  void playTutorial(int index) async {
    if (currentTutorialIndex.value != index) {
      // Pause current video before switching
      await chewieController?.pause();
      currentTutorialIndex.value = index;
      // Initialize new video
      initializePlayer(tutorials[index].url);
    }
  }

  void seekForward() {
    if (videoPlayerController != null && videoPlayerController!.value.isInitialized) {
      final currentPosition = videoPlayerController!.value.position;
      final duration = videoPlayerController!.value.duration;
      final newPosition = currentPosition + Duration(seconds: 10);

      if (newPosition < duration) {
        videoPlayerController!.seekTo(newPosition);
      } else {
        videoPlayerController!.seekTo(duration);
      }
    }
  }

  void seekBackward() {
    if (videoPlayerController != null && videoPlayerController!.value.isInitialized) {
      final currentPosition = videoPlayerController!.value.position;
      final newPosition = currentPosition - Duration(seconds: 10);

      if (newPosition > Duration.zero) {
        videoPlayerController!.seekTo(newPosition);
      } else {
        videoPlayerController!.seekTo(Duration.zero);
      }
    }
  }
}

class Tutorial {
  final String id;
  final String title;
  final String url;
  final bool isComplete;

  Tutorial({
    required this.id,
    required this.title,
    required this.url,
    required this.isComplete,
  });

  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      isComplete: json['isComplete'] ?? false,
    );
  }
}