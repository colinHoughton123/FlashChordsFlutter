// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get welcomeTitle => 'Welkom bij FlashChords';

  @override
  String get welcomeUpdate_Update => 'Update beschikbaar';

  @override
  String get welcomeUpdate_Button_Later => 'Later';

  @override
  String get welcomeUpdate_Button_Update => 'Bijwerken';

  @override
  String get listenerLimitReachedTitle => 'Luisteren uitgeschakeld';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'De luisterfunctie is uitgeschakeld na $limit gratis gespeelde kaarten. Upgrade om deze opnieuw in te schakelen.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Gratis versie: $played van $limit kaarten met luisterfunctie gebruikt';
  }

  @override
  String get listenerLimitDialogTitle => 'Gratis limiet bereikt';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords blijft werken, maar de luisterfunctie is uitgeschakeld tenzij je upgrade voor $price.';
  }

  @override
  String get upgrade => 'Upgrade';

  @override
  String get later => 'Later';

  @override
  String get listenerInversionNoticeTitle => 'Luister-opmerking';

  @override
  String get listenerInversionNoticePart1 => 'Je hebt meer dan één omkering geselecteerd. Houd er rekening mee dat FlashChords het verschil tussen omkeringen niet kan “horen”. De verwachte toets patronen worden weergegeven, maar een akkoord dat in de verkeerde omkering wordt gespeeld, wordt gemarkeerd als ';

  @override
  String get listenerInversionNoticeAny => '“correct”';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Niet meer tonen';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Akkoorden laden...';

  @override
  String get start => 'Start';

  @override
  String get configure => 'Configureren';

  @override
  String get mainCatchPhrase => 'Leer akkoorden in een flits!';

  @override
  String get mainFeaturesTitle => 'Functies';

  @override
  String get mainFeatures1Title => 'Selecteer je akkoorden';

  @override
  String get mainFeatures1Content => 'Kies welke akkoorden je wilt oefenen';

  @override
  String get mainFeatures2Title => 'Tijd uitdagingen';

  @override
  String get mainFeatures2Content => 'Test je reactietijd met aangepaste timers';

  @override
  String get mainFeatures3Title => 'Live luistermodus';

  @override
  String get mainFeatures3Content => 'Akkoorden worden automatisch gedetecteerd en beoordeeld';

  @override
  String get language_picker_title => 'Selecteer taal';

  @override
  String get language_change_tooltip => 'Taal wijzigen';

  @override
  String get configTitle => 'Configuratie';

  @override
  String get configSelectRoots => 'Selecteer akkoorden';

  @override
  String get configSelectChordTypes => 'Selecteer akkoordtypen';

  @override
  String get configSelectInversions => 'Selecteer omkeringen';

  @override
  String get configEnableTimer => 'Timer inschakelen';

  @override
  String get configTimerSeconds => 'Timer (seconden)';

  @override
  String get saveButton => 'Opslaan';

  @override
  String get configListener => 'Microfoon inschakelen om te luisteren en als Correct te markeren';

  @override
  String get configIncorrect => 'Markeer het akkoord als Onjuist als het niet het eerste akkoord is dat na de start van de timer wordt gespeeld';

  @override
  String get configAtLeastOneOption => 'Er moet minstens één optie in deze sectie geselecteerd zijn. De laatste optie is opnieuw geselecteerd. Probeer het opnieuw.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Luistermodus inschakelen (toekomstige functie)';

  @override
  String get configEnableListeningDesc => 'Markeer het akkoord automatisch als correct wanneer de audiodetectie overeenkomt.';

  @override
  String get chord_major => 'Groot';

  @override
  String get chord_minor => 'Klein';

  @override
  String get chord_diminished => 'Verminderd';

  @override
  String get chord_dominant7 => 'Dominant septiem';

  @override
  String get chord_major7 => 'Grote septiem';

  @override
  String get chord_minor7 => 'Kleine septiem';

  @override
  String get chord_suspended2 => 'Sus2';

  @override
  String get chord_suspended4 => 'Sus4';

  @override
  String get chord_augmented => 'Overmatig';

  @override
  String get inv_root => 'Grondligging';

  @override
  String get inv_first => '1e omkering';

  @override
  String get inv_second => '2e omkering';

  @override
  String get configCardOrder => 'Kaartvolgorde';

  @override
  String get configCardOrderRandom => 'Willekeurig';

  @override
  String get configCardOrderSorted => 'Gesorteerd';

  @override
  String get flash_incorrectCountLabel => 'Onjuist';

  @override
  String get flash_correctCountLabel => 'Correct';

  @override
  String get flash_playingMainDeck => 'Hoofdstapel wordt gespeeld';

  @override
  String get flash_playingErrorDeck => 'Foutenstapel wordt gespeeld';

  @override
  String get flash_redoButton => 'OPNIEUW';

  @override
  String get flash_playedLabel => 'gespeeld';

  @override
  String get flash_toGoLabel => 'te gaan';

  @override
  String get flash_averageTimeLabel => 'Gemiddelde tijd:';

  @override
  String get flash_timeLabel => 'Timer';

  @override
  String get flash_timerCancelled => 'Timer geannuleerd';

  @override
  String get flash_reveal => 'Akkoord tonen';

  @override
  String get flash_play_instruction => 'Speel het volgende akkoord\nwillekeurig geselecteerd uit de hoofdstapel';

  @override
  String get flash_swipe_right => 'Veeg naar rechts als je het correct speelde';

  @override
  String get flash_swipe_left => 'Veeg naar links als je het onjuist speelde';

  @override
  String get flash_not_sure => 'Niet zeker? Tik op de kaart om de vingerzetting te zien';

  @override
  String get flash_welcome1 => 'Hier wordt een akkoordnaam weergegeven';

  @override
  String get flash_welcome2 => 'Speel het op je piano';

  @override
  String get flash_incorrect_count => 'Onjuist aantal';

  @override
  String get flash_correct_count => 'Correct aantal';

  @override
  String get flash_playing_main => 'Hoofdstapel wordt gespeeld';

  @override
  String get flash_playing_wrong => 'Fouten worden gespeeld';

  @override
  String get flash_play_again => 'Opnieuw spelen';

  @override
  String get flash_average_time => 'Gemiddelde tijd';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played gespeeld, $remaining te gaan';
  }

  @override
  String get flash_mainDeck => 'Hoofdstapel';

  @override
  String get flash_errorDeck => 'Foutenstapel';

  @override
  String get flash_correct => 'Correct';

  @override
  String get flash_incorrect => 'Onjuist';

  @override
  String get flash_of => 'van';

  @override
  String get flash_next => 'Volgende';

  @override
  String get detectedLabel => 'Detected';

  @override
  String get missingLabel => 'Missing';

  @override
  String get summary_title => 'Samenvatting';

  @override
  String get summary_correct => 'Correct';

  @override
  String get summary_incorrect => 'Onjuist';

  @override
  String get summary_cards => 'Kaarten';

  @override
  String get summary_average_time => 'Gemiddelde tijd';

  @override
  String get summary_seconds => 'seconden';

  @override
  String get summary_from_main_deck => 'Hoofdstapel';

  @override
  String get summary_from_error_deck => 'Foutenstapel';

  @override
  String get summary_play_again => 'Opnieuw spelen met het foute‑akkoord‑deck';

  @override
  String get summary_done => 'Opnieuw beginnen';

  @override
  String get summary_accuracy => 'Nauwkeurigheid';

  @override
  String get summary_average_time_correct => 'Gemiddelde (correcte akkoorden)';

  @override
  String get summary_average_time_all => 'Gemiddelde tijd (alle akkoorden)';

  @override
  String get summary_unsaved_changes_title => 'Je hebt je wijzigingen niet opgeslagen';

  @override
  String get summary_unsaved_changes_body => 'Je hebt een wijziging aangebracht in de configuratie. Als je wilt opslaan, druk nu op ANNULEREN en daarna op OPSLAAN.';

  @override
  String get summary_discard => 'Wijzigingen verwerpen';

  @override
  String get cancel => 'Annuleren';

  @override
  String get listeningActive => 'Luisteren…';

  @override
  String get listeningInactive => 'Luisteren gepauzeerd';

  @override
  String get flash_error_101 => 'Audio-invoer is niet toegestaan.';

  @override
  String get flash_error_101_hint => 'FlashChords heeft geen toestemming om toegang te krijgen tot de microfoon. Schakel microfoontoegang in via de instellingen van je apparaat en start de app opnieuw.';

  @override
  String get flash_error_102 => 'Kan audio-luisteren niet starten.';

  @override
  String get flash_error_102_hint => 'FlashChords kon het audiosysteem niet initialiseren. Controleer of geen andere app de microfoon gebruikt en start de app opnieuw.';

  @override
  String get flash_error_103 => 'Audio-invoer werd onderbroken.';

  @override
  String get flash_error_103_hint => 'Het luisteren is gestopt door een audio-onderbreking. Controleer je microfoonverbinding en start het luisteren opnieuw.';

  @override
  String get flash_error_201 => 'Er is een interne fout opgetreden.';

  @override
  String get flash_error_201_hint => 'FlashChords heeft een onverwachte fout ondervonden. Start de app opnieuw. Als het probleem blijft bestaan, neem contact op met ondersteuning met deze foutcode.';

  @override
  String get flash_error_301 => 'Er moet minstens één waarde geselecteerd zijn.';

  @override
  String get flash_error_301_hint => 'Je laatste deselectie is opnieuw geselecteerd om ervoor te zorgen dat er één waarde geselecteerd is. Om deze te deselecteren, selecteer eerst een andere waarde.';

  @override
  String get language_picker_scroll_hint => 'Scroll om meer talen te zien';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'Zo werkt het';

  @override
  String get howItWorksBody => 'Plaats je apparaat op je piano. Speel voor elke kaart het getoonde akkoord. Als de luisteraar is ingeschakeld (Configuratie) en je speelt de juiste toetsen voordat de timer afloopt (indien ingeschakeld), markeert FlashChords™ het als correct en toont de volgende kaart. Staat de luisteraar uit, markeer je het zelf: vinkje of naar rechts vegen voor correct, X of naar links vegen voor incorrect. Tik op de kaart om de verwachte toetsen te zien.\n\nLet op: zeer lage octaafakkoorden kunnen op sommige apparaten of toetsenborden moeilijker te detecteren zijn.';

  @override
  String get upgradeReenableListener => 'Upgrade om de luisteraar opnieuw in te schakelen';

  @override
  String get configShowCorrectOnError => 'Toon juiste toetsen bij foutdetectie';
}
