enum ReviewMode { ReviewAuto, ReviewManual, Test, Textbook }

class MReviewOptions {
  var mode = ReviewMode.ReviewAuto;
  var shuffled = false;
  var interval = 5;
  var groupSelected = 1;
  var groupCount = 1;
  var speakingEnabled = true;
  var reviewCount = 10;
  var onRepeat = true;
  var moveForward = true;
}
