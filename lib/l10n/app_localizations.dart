import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to FlashChords'**
  String get welcomeTitle;

  /// No description provided for @welcomeUpdate_Update.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get welcomeUpdate_Update;

  /// No description provided for @welcomeUpdate_Button_Later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get welcomeUpdate_Button_Later;

  /// No description provided for @welcomeUpdate_Button_Update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get welcomeUpdate_Button_Update;

  /// No description provided for @listenerLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Listener disabled'**
  String get listenerLimitReachedTitle;

  /// No description provided for @listenerLimitReachedBody.
  ///
  /// In en, this message translates to:
  /// **'The listener has been disabled after {limit} free card plays. Upgrade to re-enable.'**
  String listenerLimitReachedBody(Object limit);

  /// No description provided for @freeUsageStatus.
  ///
  /// In en, this message translates to:
  /// **'Free version: {played} of {limit} listener-enabled cards used'**
  String freeUsageStatus(Object limit, Object played);

  /// No description provided for @listenerLimitDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Free limit reached'**
  String get listenerLimitDialogTitle;

  /// No description provided for @listenerLimitDialogBody.
  ///
  /// In en, this message translates to:
  /// **'FlashChords will continue to work, but the listener is disabled unless you upgrade for {price}.'**
  String listenerLimitDialogBody(Object price);

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @listenerInversionNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Listener Note'**
  String get listenerInversionNoticeTitle;

  /// No description provided for @listenerInversionNoticePart1.
  ///
  /// In en, this message translates to:
  /// **'You have more than 1 inversion selected. Be aware that FlashChords cannot “hear” the difference between inversions. The expected key patterns will be displayed, but a chord played in the wrong inversion will be marked as '**
  String get listenerInversionNoticePart1;

  /// No description provided for @listenerInversionNoticeAny.
  ///
  /// In en, this message translates to:
  /// **'“correct”'**
  String get listenerInversionNoticeAny;

  /// No description provided for @listenerInversionNoticePart2.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get listenerInversionNoticePart2;

  /// No description provided for @listenerInversionNoticeDontShow.
  ///
  /// In en, this message translates to:
  /// **'Don\'t show this again'**
  String get listenerInversionNoticeDontShow;

  /// No description provided for @listenerInversionNoticeGotIt.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get listenerInversionNoticeGotIt;

  /// No description provided for @loadingChords.
  ///
  /// In en, this message translates to:
  /// **'Loading chords...'**
  String get loadingChords;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @configure.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get configure;

  /// No description provided for @mainCatchPhrase.
  ///
  /// In en, this message translates to:
  /// **'Learn chords in a flash!'**
  String get mainCatchPhrase;

  /// No description provided for @mainFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get mainFeaturesTitle;

  /// No description provided for @mainFeatures1Title.
  ///
  /// In en, this message translates to:
  /// **'Select your chords'**
  String get mainFeatures1Title;

  /// No description provided for @mainFeatures1Content.
  ///
  /// In en, this message translates to:
  /// **'Choose which chords to practice'**
  String get mainFeatures1Content;

  /// No description provided for @mainFeatures2Title.
  ///
  /// In en, this message translates to:
  /// **'Timed Challenges'**
  String get mainFeatures2Title;

  /// No description provided for @mainFeatures2Content.
  ///
  /// In en, this message translates to:
  /// **'Test your response time with customized timers'**
  String get mainFeatures2Content;

  /// No description provided for @mainFeatures3Title.
  ///
  /// In en, this message translates to:
  /// **'Live Listening Mode'**
  String get mainFeatures3Title;

  /// No description provided for @mainFeatures3Content.
  ///
  /// In en, this message translates to:
  /// **'Chords are automatically detected and scored'**
  String get mainFeatures3Content;

  /// No description provided for @language_picker_title.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get language_picker_title;

  /// No description provided for @language_change_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get language_change_tooltip;

  /// No description provided for @configTitle.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configTitle;

  /// No description provided for @configSelectRoots.
  ///
  /// In en, this message translates to:
  /// **'Select Chords'**
  String get configSelectRoots;

  /// No description provided for @configSelectChordTypes.
  ///
  /// In en, this message translates to:
  /// **'Select Chord Types'**
  String get configSelectChordTypes;

  /// No description provided for @configSelectInversions.
  ///
  /// In en, this message translates to:
  /// **'Select Inversions'**
  String get configSelectInversions;

  /// No description provided for @configEnableTimer.
  ///
  /// In en, this message translates to:
  /// **'Enable Timer'**
  String get configEnableTimer;

  /// No description provided for @configTimerSeconds.
  ///
  /// In en, this message translates to:
  /// **'Timer (seconds)'**
  String get configTimerSeconds;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @configListener.
  ///
  /// In en, this message translates to:
  /// **'Enable the microphone to listen and mark Correct'**
  String get configListener;

  /// No description provided for @configIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Mark chord played as Incorrect if not the first chord played after timer start'**
  String get configIncorrect;

  /// No description provided for @configAtLeastOneOption.
  ///
  /// In en, this message translates to:
  /// **'At least one option must be selected in this section. Re-selecting the last option. Please try again.'**
  String get configAtLeastOneOption;

  /// No description provided for @configOK.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get configOK;

  /// No description provided for @configEnableListening.
  ///
  /// In en, this message translates to:
  /// **'Enable Listening Mode (Future Feature)'**
  String get configEnableListening;

  /// No description provided for @configEnableListeningDesc.
  ///
  /// In en, this message translates to:
  /// **'Automatically mark chord correct when audio detection matches.'**
  String get configEnableListeningDesc;

  /// No description provided for @chord_major.
  ///
  /// In en, this message translates to:
  /// **'Major'**
  String get chord_major;

  /// No description provided for @chord_minor.
  ///
  /// In en, this message translates to:
  /// **'Minor'**
  String get chord_minor;

  /// No description provided for @chord_diminished.
  ///
  /// In en, this message translates to:
  /// **'Diminished'**
  String get chord_diminished;

  /// No description provided for @chord_dominant7.
  ///
  /// In en, this message translates to:
  /// **'Dominant 7th'**
  String get chord_dominant7;

  /// No description provided for @chord_major7.
  ///
  /// In en, this message translates to:
  /// **'Major 7th'**
  String get chord_major7;

  /// No description provided for @chord_minor7.
  ///
  /// In en, this message translates to:
  /// **'Minor 7th'**
  String get chord_minor7;

  /// No description provided for @chord_suspended2.
  ///
  /// In en, this message translates to:
  /// **'Suspended 2'**
  String get chord_suspended2;

  /// No description provided for @chord_suspended4.
  ///
  /// In en, this message translates to:
  /// **'Suspended 4'**
  String get chord_suspended4;

  /// No description provided for @chord_augmented.
  ///
  /// In en, this message translates to:
  /// **'Augmented'**
  String get chord_augmented;

  /// No description provided for @inv_root.
  ///
  /// In en, this message translates to:
  /// **'Root position'**
  String get inv_root;

  /// No description provided for @inv_first.
  ///
  /// In en, this message translates to:
  /// **'1st inversion'**
  String get inv_first;

  /// No description provided for @inv_second.
  ///
  /// In en, this message translates to:
  /// **'2nd inversion'**
  String get inv_second;

  /// No description provided for @configCardOrder.
  ///
  /// In en, this message translates to:
  /// **'Card Order'**
  String get configCardOrder;

  /// No description provided for @configCardOrderRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get configCardOrderRandom;

  /// No description provided for @configCardOrderSorted.
  ///
  /// In en, this message translates to:
  /// **'Sorted'**
  String get configCardOrderSorted;

  /// No description provided for @flash_incorrectCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get flash_incorrectCountLabel;

  /// No description provided for @flash_correctCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get flash_correctCountLabel;

  /// No description provided for @flash_playingMainDeck.
  ///
  /// In en, this message translates to:
  /// **'Playing the main deck'**
  String get flash_playingMainDeck;

  /// No description provided for @flash_playingErrorDeck.
  ///
  /// In en, this message translates to:
  /// **'Playing the error deck'**
  String get flash_playingErrorDeck;

  /// No description provided for @flash_redoButton.
  ///
  /// In en, this message translates to:
  /// **'REDO'**
  String get flash_redoButton;

  /// No description provided for @flash_playedLabel.
  ///
  /// In en, this message translates to:
  /// **'played'**
  String get flash_playedLabel;

  /// No description provided for @flash_toGoLabel.
  ///
  /// In en, this message translates to:
  /// **'to go'**
  String get flash_toGoLabel;

  /// No description provided for @flash_averageTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Average Time:'**
  String get flash_averageTimeLabel;

  /// No description provided for @flash_timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get flash_timeLabel;

  /// No description provided for @flash_timerCancelled.
  ///
  /// In en, this message translates to:
  /// **'Timer cancelled'**
  String get flash_timerCancelled;

  /// No description provided for @flash_reveal.
  ///
  /// In en, this message translates to:
  /// **'Show Chord'**
  String get flash_reveal;

  /// No description provided for @flash_play_instruction.
  ///
  /// In en, this message translates to:
  /// **'Play the following chord\nselected randomly from the main deck'**
  String get flash_play_instruction;

  /// No description provided for @flash_swipe_right.
  ///
  /// In en, this message translates to:
  /// **'Swipe right if you played it correctly'**
  String get flash_swipe_right;

  /// No description provided for @flash_swipe_left.
  ///
  /// In en, this message translates to:
  /// **'Swipe left if you played it incorrectly'**
  String get flash_swipe_left;

  /// No description provided for @flash_not_sure.
  ///
  /// In en, this message translates to:
  /// **'Not sure? Tap the flashcard to see the fingering'**
  String get flash_not_sure;

  /// No description provided for @flash_welcome1.
  ///
  /// In en, this message translates to:
  /// **'A chord name will display here'**
  String get flash_welcome1;

  /// No description provided for @flash_welcome2.
  ///
  /// In en, this message translates to:
  /// **'Play it on your piano'**
  String get flash_welcome2;

  /// No description provided for @flash_incorrect_count.
  ///
  /// In en, this message translates to:
  /// **'Incorrect count'**
  String get flash_incorrect_count;

  /// No description provided for @flash_correct_count.
  ///
  /// In en, this message translates to:
  /// **'Correct count'**
  String get flash_correct_count;

  /// No description provided for @flash_playing_main.
  ///
  /// In en, this message translates to:
  /// **'Playing the main deck'**
  String get flash_playing_main;

  /// No description provided for @flash_playing_wrong.
  ///
  /// In en, this message translates to:
  /// **'Playing the errors'**
  String get flash_playing_wrong;

  /// No description provided for @flash_play_again.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get flash_play_again;

  /// No description provided for @flash_average_time.
  ///
  /// In en, this message translates to:
  /// **'Average time'**
  String get flash_average_time;

  /// No description provided for @flash_cards_played.
  ///
  /// In en, this message translates to:
  /// **'{played} played {remaining} to go'**
  String flash_cards_played(Object played, Object remaining);

  /// No description provided for @flash_mainDeck.
  ///
  /// In en, this message translates to:
  /// **'Main Deck'**
  String get flash_mainDeck;

  /// No description provided for @flash_errorDeck.
  ///
  /// In en, this message translates to:
  /// **'Errors Deck'**
  String get flash_errorDeck;

  /// No description provided for @flash_correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get flash_correct;

  /// No description provided for @flash_incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get flash_incorrect;

  /// No description provided for @flash_of.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get flash_of;

  /// No description provided for @flash_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get flash_next;

  /// No description provided for @summary_title.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary_title;

  /// No description provided for @summary_correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get summary_correct;

  /// No description provided for @summary_incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get summary_incorrect;

  /// No description provided for @summary_cards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get summary_cards;

  /// No description provided for @summary_average_time.
  ///
  /// In en, this message translates to:
  /// **'Average Time'**
  String get summary_average_time;

  /// No description provided for @summary_seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get summary_seconds;

  /// No description provided for @summary_from_main_deck.
  ///
  /// In en, this message translates to:
  /// **'Main deck'**
  String get summary_from_main_deck;

  /// No description provided for @summary_from_error_deck.
  ///
  /// In en, this message translates to:
  /// **'Errors deck'**
  String get summary_from_error_deck;

  /// No description provided for @summary_play_again.
  ///
  /// In en, this message translates to:
  /// **'Play again using errors deck'**
  String get summary_play_again;

  /// No description provided for @summary_done.
  ///
  /// In en, this message translates to:
  /// **'Start Over'**
  String get summary_done;

  /// No description provided for @summary_accuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get summary_accuracy;

  /// No description provided for @summary_average_time_correct.
  ///
  /// In en, this message translates to:
  /// **'Average (correct chords)'**
  String get summary_average_time_correct;

  /// No description provided for @summary_average_time_all.
  ///
  /// In en, this message translates to:
  /// **'Average time (all chords)'**
  String get summary_average_time_all;

  /// No description provided for @summary_unsaved_changes_title.
  ///
  /// In en, this message translates to:
  /// **'You have not saved your changes'**
  String get summary_unsaved_changes_title;

  /// No description provided for @summary_unsaved_changes_body.
  ///
  /// In en, this message translates to:
  /// **'You made a change in the configuration.  If you want to save, press CANCEL now, then press SAVE.'**
  String get summary_unsaved_changes_body;

  /// No description provided for @summary_discard.
  ///
  /// In en, this message translates to:
  /// **'Discard changes'**
  String get summary_discard;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @listeningActive.
  ///
  /// In en, this message translates to:
  /// **'Listening…'**
  String get listeningActive;

  /// No description provided for @listeningInactive.
  ///
  /// In en, this message translates to:
  /// **'Listening paused'**
  String get listeningInactive;

  /// No description provided for @flash_error_101.
  ///
  /// In en, this message translates to:
  /// **'Audio input is not permitted.'**
  String get flash_error_101;

  /// No description provided for @flash_error_101_hint.
  ///
  /// In en, this message translates to:
  /// **'FlashChords does not have permission to access the microphone. Please enable microphone access in your device settings and restart the app.'**
  String get flash_error_101_hint;

  /// No description provided for @flash_error_102.
  ///
  /// In en, this message translates to:
  /// **'Unable to start audio listening.'**
  String get flash_error_102;

  /// No description provided for @flash_error_102_hint.
  ///
  /// In en, this message translates to:
  /// **'FlashChords could not initialize the audio system. Please check that no other app is using the microphone and restart the app.'**
  String get flash_error_102_hint;

  /// No description provided for @flash_error_103.
  ///
  /// In en, this message translates to:
  /// **'Audio input was interrupted.'**
  String get flash_error_103;

  /// No description provided for @flash_error_103_hint.
  ///
  /// In en, this message translates to:
  /// **'Listening has stopped due to an audio interruption. Please check your microphone connection and restart listening.'**
  String get flash_error_103_hint;

  /// No description provided for @flash_error_201.
  ///
  /// In en, this message translates to:
  /// **'An internal error occurred.'**
  String get flash_error_201;

  /// No description provided for @flash_error_201_hint.
  ///
  /// In en, this message translates to:
  /// **'FlashChords encountered an unexpected error. Please restart the app. If the problem persists, contact support with this error code.'**
  String get flash_error_201_hint;

  /// No description provided for @flash_error_301.
  ///
  /// In en, this message translates to:
  /// **'At least one value must be selected.'**
  String get flash_error_301;

  /// No description provided for @flash_error_301_hint.
  ///
  /// In en, this message translates to:
  /// **'Your last de-select has been reselected to ensure one value is selected.  To deselect it, select another value first.'**
  String get flash_error_301_hint;

  /// No description provided for @language_picker_scroll_hint.
  ///
  /// In en, this message translates to:
  /// **'Scroll to see more languages'**
  String get language_picker_scroll_hint;

  /// No description provided for @listenerStarting.
  ///
  /// In en, this message translates to:
  /// **'Starting listener...'**
  String get listenerStarting;

  /// No description provided for @howItWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get howItWorksTitle;

  /// No description provided for @howItWorksBody.
  ///
  /// In en, this message translates to:
  /// **'Place your device on your piano. For each flashcard, play the chord shown. If the listener is enabled (Configuration) and you play the correct keys before the timer ends (if enabled), FlashChords™ will mark it correct and show the next card. If the listener is off, mark it yourself: checkmark or swipe right for correct, X or swipe left for incorrect. Tap the card to reveal the expected keys.\n\nNote: very low-octave chords may be harder to detect on some devices or keyboards.'**
  String get howItWorksBody;

  /// No description provided for @upgradeReenableListener.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to re-enable the listener'**
  String get upgradeReenableListener;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['bn', 'de', 'en', 'es', 'fr', 'hi', 'it', 'ja', 'ko', 'nl', 'pl', 'pt', 'ru', 'th', 'tr', 'uk', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.scriptCode) {
    case 'Hans': return AppLocalizationsZhHans();
case 'Hant': return AppLocalizationsZhHant();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn': return AppLocalizationsBn();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'hi': return AppLocalizationsHi();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
    case 'nl': return AppLocalizationsNl();
    case 'pl': return AppLocalizationsPl();
    case 'pt': return AppLocalizationsPt();
    case 'ru': return AppLocalizationsRu();
    case 'th': return AppLocalizationsTh();
    case 'tr': return AppLocalizationsTr();
    case 'uk': return AppLocalizationsUk();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
