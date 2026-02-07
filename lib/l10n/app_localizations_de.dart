// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get welcomeTitle => 'Willkommen bei FlashChords';

  @override
  String get welcomeUpdate_Update => 'Update verfügbar';

  @override
  String get welcomeUpdate_Button_Later => 'Später';

  @override
  String get welcomeUpdate_Button_Update => 'Aktualisieren';

  @override
  String get listenerLimitReachedTitle => 'Listener deaktiviert';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'Der Listener wurde nach $limit kostenlosen Kartenwiedergaben deaktiviert. Bitte upgraden, um ihn wieder zu aktivieren.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Kostenlose Version: $played von $limit Karten mit Listener-Funktion verwendet';
  }

  @override
  String get listenerLimitDialogTitle => 'Kostenloses Limit erreicht';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords funktioniert weiterhin, aber der Listener ist deaktiviert, sofern du nicht für $price upgradest.';
  }

  @override
  String get upgrade => 'Upgrade';

  @override
  String get later => 'Später';

  @override
  String get listenerInversionNoticeTitle => 'Hinweis zum Listener';

  @override
  String get listenerInversionNoticePart1 => 'Du hast mehr als eine Umkehrung ausgewählt. Bitte beachte, dass FlashChords den Unterschied zwischen Umkehrungen nicht „hören“ kann. Die erwarteten Tastenmuster werden angezeigt, aber ein Akkord, der in der falschen Umkehrung gespielt wird, wird als ';

  @override
  String get listenerInversionNoticeAny => '„korrekt“';

  @override
  String get listenerInversionNoticePart2 => ' markiert.';

  @override
  String get listenerInversionNoticeDontShow => 'Nicht mehr anzeigen';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Akkorde werden geladen...';

  @override
  String get start => 'Start';

  @override
  String get configure => 'Konfigurieren';

  @override
  String get mainCatchPhrase => 'Lerne Akkorde im Handumdrehen!';

  @override
  String get mainFeaturesTitle => 'Funktionen';

  @override
  String get mainFeatures1Title => 'Wähle deine Akkorde aus';

  @override
  String get mainFeatures1Content => 'Choose which chords to practice';

  @override
  String get mainFeatures2Title => 'Zeit-Challenges';

  @override
  String get mainFeatures2Content => 'Test your response time with customized timers';

  @override
  String get mainFeatures3Title => 'Live Listening Mode';

  @override
  String get mainFeatures3Content => 'Chords are automatically detected and scored';

  @override
  String get language_picker_title => 'Sprache auswählen';

  @override
  String get language_change_tooltip => 'Sprache ändern';

  @override
  String get configTitle => 'Konfiguration';

  @override
  String get configSelectRoots => 'Akkorde auswählen';

  @override
  String get configSelectChordTypes => 'Akkordtypen auswählen';

  @override
  String get configSelectInversions => 'Umkehrungen auswählen';

  @override
  String get configEnableTimer => 'Timer aktivieren';

  @override
  String get configTimerSeconds => 'Timer (Sekunden)';

  @override
  String get saveButton => 'Speichern';

  @override
  String get configListener => 'Mikrofon aktivieren, um zuzuhören und als Korrekt zu markieren';

  @override
  String get configIncorrect => 'Akkord als Falsch markieren, wenn er nicht der erste nach Timerstart gespielte Akkord ist';

  @override
  String get configAtLeastOneOption => 'Mindestens eine Option muss in diesem Abschnitt ausgewählt sein. Die letzte Option wurde erneut ausgewählt. Bitte versuche es erneut.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Listening-Modus aktivieren (zukünftige Funktion)';

  @override
  String get configEnableListeningDesc => 'Akkord automatisch als korrekt markieren, wenn die Audioerkennung übereinstimmt.';

  @override
  String get chord_major => 'Dur';

  @override
  String get chord_minor => 'Moll';

  @override
  String get chord_diminished => 'Vermindert';

  @override
  String get chord_dominant7 => 'Dominantseptakkord';

  @override
  String get chord_major7 => 'Durseptakkord';

  @override
  String get chord_minor7 => 'Mollseptakkord';

  @override
  String get chord_suspended2 => 'Sus2';

  @override
  String get chord_suspended4 => 'Sus4';

  @override
  String get chord_augmented => 'Übermäßig';

  @override
  String get inv_root => 'Grundstellung';

  @override
  String get inv_first => '1. Umkehrung';

  @override
  String get inv_second => '2. Umkehrung';

  @override
  String get configCardOrder => 'Kartenreihenfolge';

  @override
  String get configCardOrderRandom => 'Zufällig';

  @override
  String get configCardOrderSorted => 'Sortiert';

  @override
  String get flash_incorrectCountLabel => 'Falsch';

  @override
  String get flash_correctCountLabel => 'Richtig';

  @override
  String get flash_playingMainDeck => 'Hauptstapel wird gespielt';

  @override
  String get flash_playingErrorDeck => 'Fehlerstapel wird gespielt';

  @override
  String get flash_redoButton => 'WIEDERHOLEN';

  @override
  String get flash_playedLabel => 'gespielt';

  @override
  String get flash_toGoLabel => 'übrig';

  @override
  String get flash_averageTimeLabel => 'Durchschnittszeit:';

  @override
  String get flash_timeLabel => 'Timer';

  @override
  String get flash_timerCancelled => 'Timer abgebrochen';

  @override
  String get flash_reveal => 'Akkord anzeigen';

  @override
  String get flash_play_instruction => 'Spiele den folgenden Akkord\nzufällig aus dem Hauptstapel ausgewählt';

  @override
  String get flash_swipe_right => 'Wische nach rechts, wenn du ihn richtig gespielt hast';

  @override
  String get flash_swipe_left => 'Wische nach links, wenn du ihn falsch gespielt hast';

  @override
  String get flash_not_sure => 'Nicht sicher? Tippe auf die Karte, um die Fingerposition zu sehen';

  @override
  String get flash_welcome1 => 'Hier wird ein Akkordname angezeigt';

  @override
  String get flash_welcome2 => 'Spiele ihn auf deinem Klavier';

  @override
  String get flash_incorrect_count => 'Anzahl falsch';

  @override
  String get flash_correct_count => 'Anzahl richtig';

  @override
  String get flash_playing_main => 'Hauptstapel wird gespielt';

  @override
  String get flash_playing_wrong => 'Fehler werden gespielt';

  @override
  String get flash_play_again => 'Noch einmal spielen';

  @override
  String get flash_average_time => 'Durchschnittszeit';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played gespielt, $remaining übrig';
  }

  @override
  String get flash_mainDeck => 'Hauptstapel';

  @override
  String get flash_errorDeck => 'Fehlerstapel';

  @override
  String get flash_correct => 'Richtig';

  @override
  String get flash_incorrect => 'Falsch';

  @override
  String get flash_of => 'von';

  @override
  String get flash_next => 'Weiter';

  @override
  String get summary_title => 'Zusammenfassung';

  @override
  String get summary_correct => 'Richtig';

  @override
  String get summary_incorrect => 'Falsch';

  @override
  String get summary_cards => 'Karten';

  @override
  String get summary_average_time => 'Durchschnittszeit';

  @override
  String get summary_seconds => 'Sekunden';

  @override
  String get summary_from_main_deck => 'Hauptstapel';

  @override
  String get summary_from_error_deck => 'Fehlerstapel';

  @override
  String get summary_play_again => 'Play again using errors deck';

  @override
  String get summary_done => 'Start Over';

  @override
  String get summary_accuracy => 'Genauigkeit';

  @override
  String get summary_average_time_correct => 'Durchschnitt (richtige Akkorde)';

  @override
  String get summary_average_time_all => 'Durchschnittszeit (alle Akkorde)';

  @override
  String get summary_unsaved_changes_title => 'Du hast deine Änderungen nicht gespeichert';

  @override
  String get summary_unsaved_changes_body => 'Du hast eine Änderung in der Konfiguration vorgenommen. Wenn du speichern möchtest, drücke jetzt ABBRECHEN und dann SPEICHERN.';

  @override
  String get summary_discard => 'Änderungen verwerfen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get listeningActive => 'Hört zu…';

  @override
  String get listeningInactive => 'Listening pausiert';

  @override
  String get flash_error_101 => 'Audioeingang ist nicht erlaubt.';

  @override
  String get flash_error_101_hint => 'FlashChords hat keine Berechtigung, auf das Mikrofon zuzugreifen. Bitte aktiviere den Mikrofonzugriff in den Geräteeinstellungen und starte die App neu.';

  @override
  String get flash_error_102 => 'Audio-Listening konnte nicht gestartet werden.';

  @override
  String get flash_error_102_hint => 'FlashChords konnte das Audiosystem nicht initialisieren. Bitte überprüfe, dass keine andere App das Mikrofon verwendet, und starte die App neu.';

  @override
  String get flash_error_103 => 'Audioeingang wurde unterbrochen.';

  @override
  String get flash_error_103_hint => 'Das Listening wurde aufgrund einer Audio-Unterbrechung gestoppt. Bitte überprüfe deine Mikrofonverbindung und starte das Listening erneut.';

  @override
  String get flash_error_201 => 'Ein interner Fehler ist aufgetreten.';

  @override
  String get flash_error_201_hint => 'FlashChords ist auf einen unerwarteten Fehler gestoßen. Bitte starte die App neu. Wenn das Problem weiterhin besteht, kontaktiere den Support mit diesem Fehlercode.';

  @override
  String get flash_error_301 => 'Mindestens ein Wert muss ausgewählt werden.';

  @override
  String get flash_error_301_hint => 'Deine letzte Abwahl wurde wieder ausgewählt, um sicherzustellen, dass ein Wert ausgewählt ist. Um ihn abzuwählen, wähle zuerst einen anderen Wert aus.';

  @override
  String get language_picker_scroll_hint => 'Scrollen, um weitere Sprachen zu sehen';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'So funktioniert es';

  @override
  String get howItWorksBody => 'Lege dein Gerät auf dein Klavier. Spiele für jede Karte den angezeigten Akkord. Wenn der Listener aktiviert ist (Konfiguration) und du die richtigen Tasten vor Ablauf des Timers spielst (falls aktiviert), markiert FlashChords™ den Akkord als richtig und zeigt die nächste Karte. Ist der Listener aus, markierst du selbst: Häkchen oder nach rechts wischen für richtig, X oder nach links wischen für falsch. Tippe auf die Karte, um die erwarteten Tasten anzuzeigen.\n\nHinweis: Sehr tiefe Oktaven können auf einigen Geräten oder Tastaturen schwieriger zu erkennen sein.';

  @override
  String get upgradeReenableListener => 'Upgrade to re-enable the listener';
}
