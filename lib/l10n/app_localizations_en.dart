// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeTitle => 'Welcome to FlashChords';

  @override
  String get welcomeUpdate_Update => 'Update Available';

  @override
  String get welcomeUpdate_Button_Later => 'Later';

  @override
  String get welcomeUpdate_Button_Update => 'Update';

  @override
  String get listenerLimitReachedTitle => 'Listener disabled';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'The listener has been disabled after $limit free card plays. Upgrade to re-enable.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Free version: $played of $limit listener-enabled cards used';
  }

  @override
  String get listenerLimitDialogTitle => 'Free limit reached';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords will continue to work, but the listener is disabled unless you upgrade for $price.';
  }

  @override
  String get upgrade => 'Upgrade';

  @override
  String get later => 'Later';

  @override
  String get listenerInversionNoticeTitle => 'Listener Note';

  @override
  String get listenerInversionNoticePart1 => 'You have more than 1 inversion selected. Be aware that FlashChords cannot “hear” the difference between inversions. The expected key patterns will be displayed, but a chord played in the wrong inversion will be marked as ';

  @override
  String get listenerInversionNoticeAny => '“correct”';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Don\'t show this again';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Loading chords...';

  @override
  String get start => 'Start';

  @override
  String get configure => 'Configure';

  @override
  String get mainCatchPhrase => 'Learn chords in a flash!';

  @override
  String get mainFeaturesTitle => 'Features';

  @override
  String get mainFeatures1Title => 'Select your chords';

  @override
  String get mainFeatures1Content => 'Configure which chords on which to focus';

  @override
  String get mainFeatures2Title => 'Timed Challenges';

  @override
  String get mainFeatures2Content => 'Test yourself with customized timers';

  @override
  String get mainFeatures3Title => 'Automatic Marking';

  @override
  String get mainFeatures3Content => 'Let FlashChords listen to your piano';

  @override
  String get language_picker_title => 'Select language';

  @override
  String get language_change_tooltip => 'Change language';

  @override
  String get configTitle => 'Configuration';

  @override
  String get configSelectRoots => 'Select Chords';

  @override
  String get configSelectChordTypes => 'Select Chord Types';

  @override
  String get configSelectInversions => 'Select Inversions';

  @override
  String get configEnableTimer => 'Enable Timer';

  @override
  String get configTimerSeconds => 'Timer (seconds)';

  @override
  String get saveButton => 'Save';

  @override
  String get configListener => 'Enable the microphone to listen and mark Correct';

  @override
  String get configIncorrect => 'Mark chord played as Incorrect if not the first chord played after timer start';

  @override
  String get configAtLeastOneOption => 'At least one option must be selected in this section. Re-selecting the last option. Please try again.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Enable Listening Mode (Future Feature)';

  @override
  String get configEnableListeningDesc => 'Automatically mark chord correct when audio detection matches.';

  @override
  String get chord_major => 'Major';

  @override
  String get chord_minor => 'Minor';

  @override
  String get chord_diminished => 'Diminished';

  @override
  String get chord_dominant7 => 'Dominant 7th';

  @override
  String get chord_major7 => 'Major 7th';

  @override
  String get chord_minor7 => 'Minor 7th';

  @override
  String get chord_suspended2 => 'Suspended 2';

  @override
  String get chord_suspended4 => 'Suspended 4';

  @override
  String get chord_augmented => 'Augmented';

  @override
  String get inv_root => 'Root position';

  @override
  String get inv_first => '1st inversion';

  @override
  String get inv_second => '2nd inversion';

  @override
  String get configCardOrder => 'Card Order';

  @override
  String get configCardOrderRandom => 'Random';

  @override
  String get configCardOrderSorted => 'Sorted';

  @override
  String get flash_incorrectCountLabel => 'Incorrect';

  @override
  String get flash_correctCountLabel => 'Correct';

  @override
  String get flash_playingMainDeck => 'Playing the main deck';

  @override
  String get flash_playingErrorDeck => 'Playing the error deck';

  @override
  String get flash_redoButton => 'REDO';

  @override
  String get flash_playedLabel => 'played';

  @override
  String get flash_toGoLabel => 'to go';

  @override
  String get flash_averageTimeLabel => 'Average Time:';

  @override
  String get flash_timeLabel => 'Timer';

  @override
  String get flash_timerCancelled => 'Timer cancelled';

  @override
  String get flash_reveal => 'Show Chord';

  @override
  String get flash_play_instruction => 'Play the following chord\nselected randomly from the main deck';

  @override
  String get flash_swipe_right => 'Swipe right if you played it correctly';

  @override
  String get flash_swipe_left => 'Swipe left if you played it incorrectly';

  @override
  String get flash_not_sure => 'Not sure? Tap the flashcard to see the fingering';

  @override
  String get flash_welcome1 => 'A chord name will display here';

  @override
  String get flash_welcome2 => 'Play it on your piano';

  @override
  String get flash_incorrect_count => 'Incorrect count';

  @override
  String get flash_correct_count => 'Correct count';

  @override
  String get flash_playing_main => 'Playing the main deck';

  @override
  String get flash_playing_wrong => 'Playing the errors';

  @override
  String get flash_play_again => 'Play again';

  @override
  String get flash_average_time => 'Average time';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played played $remaining to go';
  }

  @override
  String get flash_mainDeck => 'Main Deck';

  @override
  String get flash_errorDeck => 'Errors Deck';

  @override
  String get flash_correct => 'Correct';

  @override
  String get flash_incorrect => 'Incorrect';

  @override
  String get flash_of => 'of';

  @override
  String get flash_next => 'Next';

  @override
  String get summary_title => 'Summary';

  @override
  String get summary_correct => 'Correct';

  @override
  String get summary_incorrect => 'Incorrect';

  @override
  String get summary_cards => 'Cards';

  @override
  String get summary_average_time => 'Average Time';

  @override
  String get summary_seconds => 'seconds';

  @override
  String get summary_from_main_deck => 'Main deck';

  @override
  String get summary_from_error_deck => 'Errors deck';

  @override
  String get summary_play_again => 'Play again';

  @override
  String get summary_done => 'Done';

  @override
  String get summary_accuracy => 'Accuracy';

  @override
  String get summary_average_time_correct => 'Average (correct chords)';

  @override
  String get summary_average_time_all => 'Average time (all chords)';

  @override
  String get summary_unsaved_changes_title => 'You have not saved your changes';

  @override
  String get summary_unsaved_changes_body => 'You made a change in the configuration.  If you want to save, press CANCEL now, then press SAVE.';

  @override
  String get summary_discard => 'Discard changes';

  @override
  String get cancel => 'Cancel';

  @override
  String get listeningActive => 'Listening…';

  @override
  String get listeningInactive => 'Listening paused';

  @override
  String get flash_error_101 => 'Audio input is not permitted.';

  @override
  String get flash_error_101_hint => 'FlashChords does not have permission to access the microphone. Please enable microphone access in your device settings and restart the app.';

  @override
  String get flash_error_102 => 'Unable to start audio listening.';

  @override
  String get flash_error_102_hint => 'FlashChords could not initialize the audio system. Please check that no other app is using the microphone and restart the app.';

  @override
  String get flash_error_103 => 'Audio input was interrupted.';

  @override
  String get flash_error_103_hint => 'Listening has stopped due to an audio interruption. Please check your microphone connection and restart listening.';

  @override
  String get flash_error_201 => 'An internal error occurred.';

  @override
  String get flash_error_201_hint => 'FlashChords encountered an unexpected error. Please restart the app. If the problem persists, contact support with this error code.';

  @override
  String get flash_error_301 => 'At least one value must be selected.';

  @override
  String get flash_error_301_hint => 'Your last de-select has been reselected to ensure one value is selected.  To deselect it, select another value first.';
}
