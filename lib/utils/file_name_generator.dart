String createAudioFileName(int chapter, String reciter) {
  return 'chapter_${chapter}_reciter_$reciter.mp3';
}

String createAudioFileDir(int chapter, String reciter) {
  return 'chapter_${chapter}_reciter_$reciter';
}

String createAudioTimingFileName(int chapter, String reciter) {
  return 'chapter_${chapter}_reciter_${reciter}_timing.json';
}
