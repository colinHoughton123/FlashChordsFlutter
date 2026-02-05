// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get welcomeTitle => 'Witamy w FlashChords';

  @override
  String get welcomeUpdate_Update => 'Dostępna aktualizacja';

  @override
  String get welcomeUpdate_Button_Later => 'Później';

  @override
  String get welcomeUpdate_Button_Update => 'Aktualizuj';

  @override
  String get listenerLimitReachedTitle => 'Nasłuchiwanie wyłączone';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'Nasłuchiwanie zostało wyłączone po $limit darmowych kartach. Wykup wersję premium, aby je ponownie włączyć.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Wersja darmowa: wykorzystano $played z $limit kart z nasłuchiwaniem';
  }

  @override
  String get listenerLimitDialogTitle => 'Osiągnięto darmowy limit';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords będzie nadal działać, ale nasłuchiwanie jest wyłączone, chyba że wykupisz wersję premium za $price.';
  }

  @override
  String get upgrade => 'Ulepsz';

  @override
  String get later => 'Później';

  @override
  String get listenerInversionNoticeTitle => 'Uwaga dotycząca nasłuchiwania';

  @override
  String get listenerInversionNoticePart1 => 'Wybrano więcej niż jedną inwersję. Pamiętaj, że FlashChords nie potrafi „usłyszeć” różnicy między inwersjami. Oczekiwane układy klawiszy zostaną wyświetlone, ale akord zagrany w złej inwersji zostanie oznaczony jako ';

  @override
  String get listenerInversionNoticeAny => '„poprawny”';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Nie pokazuj ponownie';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Ładowanie akordów...';

  @override
  String get start => 'Start';

  @override
  String get configure => 'Konfiguruj';

  @override
  String get mainCatchPhrase => 'Naucz się akordów w mgnieniu oka!';

  @override
  String get mainFeaturesTitle => 'Funkcje';

  @override
  String get mainFeatures1Title => 'Wybierz swoje akordy';

  @override
  String get mainFeatures1Content => 'Skonfiguruj, na których akordach chcesz się skupić';

  @override
  String get mainFeatures2Title => 'Wyzwania czasowe';

  @override
  String get mainFeatures2Content => 'Sprawdź się dzięki spersonalizowanym timerom';

  @override
  String get mainFeatures3Title => 'Automatyczne ocenianie';

  @override
  String get mainFeatures3Content => 'Pozwól FlashChords nasłuchiwać twojej gry na pianinie';

  @override
  String get language_picker_title => 'Wybierz język';

  @override
  String get language_change_tooltip => 'Zmień język';

  @override
  String get configTitle => 'Konfiguracja';

  @override
  String get configSelectRoots => 'Wybierz akordy';

  @override
  String get configSelectChordTypes => 'Wybierz typy akordów';

  @override
  String get configSelectInversions => 'Wybierz inwersje';

  @override
  String get configEnableTimer => 'Włącz timer';

  @override
  String get configTimerSeconds => 'Timer (sekundy)';

  @override
  String get saveButton => 'Zapisz';

  @override
  String get configListener => 'Włącz mikrofon, aby nasłuchiwać i oznaczać jako Poprawne';

  @override
  String get configIncorrect => 'Oznacz akord jako Niepoprawny, jeśli nie jest pierwszym zagranym po uruchomieniu timera';

  @override
  String get configAtLeastOneOption => 'W tej sekcji musi być wybrana przynajmniej jedna opcja. Ostatnia opcja została ponownie zaznaczona. Spróbuj ponownie.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Włącz tryb nasłuchiwania (funkcja przyszłościowa)';

  @override
  String get configEnableListeningDesc => 'Automatycznie oznaczaj akord jako poprawny, gdy wykrywanie dźwięku się zgadza.';

  @override
  String get chord_major => 'Durowy';

  @override
  String get chord_minor => 'Molowy';

  @override
  String get chord_diminished => 'Zmniejszony';

  @override
  String get chord_dominant7 => 'Dominantowy septymowy';

  @override
  String get chord_major7 => 'Durowy septymowy';

  @override
  String get chord_minor7 => 'Molowy septymowy';

  @override
  String get chord_suspended2 => 'Zawieszony 2';

  @override
  String get chord_suspended4 => 'Zawieszony 4';

  @override
  String get chord_augmented => 'Zwiększony';

  @override
  String get inv_root => 'Pozycja podstawowa';

  @override
  String get inv_first => '1. inwersja';

  @override
  String get inv_second => '2. inwersja';

  @override
  String get configCardOrder => 'Kolejność kart';

  @override
  String get configCardOrderRandom => 'Losowa';

  @override
  String get configCardOrderSorted => 'Posortowana';

  @override
  String get flash_incorrectCountLabel => 'Niepoprawne';

  @override
  String get flash_correctCountLabel => 'Poprawne';

  @override
  String get flash_playingMainDeck => 'Granie talią główną';

  @override
  String get flash_playingErrorDeck => 'Granie talią błędów';

  @override
  String get flash_redoButton => 'POWTÓRZ';

  @override
  String get flash_playedLabel => 'zagrano';

  @override
  String get flash_toGoLabel => 'pozostało';

  @override
  String get flash_averageTimeLabel => 'Średni czas:';

  @override
  String get flash_timeLabel => 'Timer';

  @override
  String get flash_timerCancelled => 'Timer anulowany';

  @override
  String get flash_reveal => 'Pokaż akord';

  @override
  String get flash_play_instruction => 'Zagraj następujący akord\nwylosowany z talii głównej';

  @override
  String get flash_swipe_right => 'Przesuń w prawo, jeśli zagrałeś poprawnie';

  @override
  String get flash_swipe_left => 'Przesuń w lewo, jeśli zagrałeś niepoprawnie';

  @override
  String get flash_not_sure => 'Nie jesteś pewien? Dotknij karty, aby zobaczyć palcowanie';

  @override
  String get flash_welcome1 => 'Tutaj pojawi się nazwa akordu';

  @override
  String get flash_welcome2 => 'Zagraj go na pianinie';

  @override
  String get flash_incorrect_count => 'Liczba niepoprawnych';

  @override
  String get flash_correct_count => 'Liczba poprawnych';

  @override
  String get flash_playing_main => 'Granie talią główną';

  @override
  String get flash_playing_wrong => 'Granie błędami';

  @override
  String get flash_play_again => 'Zagraj ponownie';

  @override
  String get flash_average_time => 'Średni czas';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played zagrano, $remaining pozostało';
  }

  @override
  String get flash_mainDeck => 'Talia główna';

  @override
  String get flash_errorDeck => 'Talia błędów';

  @override
  String get flash_correct => 'Poprawne';

  @override
  String get flash_incorrect => 'Niepoprawne';

  @override
  String get flash_of => 'z';

  @override
  String get flash_next => 'Dalej';

  @override
  String get summary_title => 'Podsumowanie';

  @override
  String get summary_correct => 'Poprawne';

  @override
  String get summary_incorrect => 'Niepoprawne';

  @override
  String get summary_cards => 'Karty';

  @override
  String get summary_average_time => 'Średni czas';

  @override
  String get summary_seconds => 'sekundy';

  @override
  String get summary_from_main_deck => 'Talia główna';

  @override
  String get summary_from_error_deck => 'Talia błędów';

  @override
  String get summary_play_again => 'Zagraj ponownie';

  @override
  String get summary_done => 'Gotowe';

  @override
  String get summary_accuracy => 'Dokładność';

  @override
  String get summary_average_time_correct => 'Średnia (poprawne akordy)';

  @override
  String get summary_average_time_all => 'Średni czas (wszystkie akordy)';

  @override
  String get summary_unsaved_changes_title => 'Nie zapisałeś swoich zmian';

  @override
  String get summary_unsaved_changes_body => 'Dokonałeś zmiany w konfiguracji. Jeśli chcesz zapisać, naciśnij teraz ANULUJ, a następnie ZAPISZ.';

  @override
  String get summary_discard => 'Odrzuć zmiany';

  @override
  String get cancel => 'Anuluj';

  @override
  String get listeningActive => 'Nasłuchiwanie…';

  @override
  String get listeningInactive => 'Nasłuchiwanie wstrzymane';

  @override
  String get flash_error_101 => 'Wejście audio nie jest dozwolone.';

  @override
  String get flash_error_101_hint => 'FlashChords nie ma uprawnień do korzystania z mikrofonu. Włącz dostęp do mikrofonu w ustawieniach urządzenia i uruchom aplikację ponownie.';

  @override
  String get flash_error_102 => 'Nie można rozpocząć nasłuchiwania audio.';

  @override
  String get flash_error_102_hint => 'FlashChords nie mógł zainicjować systemu audio. Sprawdź, czy żadna inna aplikacja nie używa mikrofonu i uruchom aplikację ponownie.';

  @override
  String get flash_error_103 => 'Wejście audio zostało przerwane.';

  @override
  String get flash_error_103_hint => 'Nasłuchiwanie zostało zatrzymane z powodu przerwania audio. Sprawdź połączenie mikrofonu i uruchom nasłuchiwanie ponownie.';

  @override
  String get flash_error_201 => 'Wystąpił błąd wewnętrzny.';

  @override
  String get flash_error_201_hint => 'FlashChords napotkał nieoczekiwany błąd. Uruchom aplikację ponownie. Jeśli problem będzie się powtarzał, skontaktuj się z pomocą techniczną, podając ten kod błędu.';

  @override
  String get flash_error_301 => 'Należy wybrać co najmniej jedną wartość.';

  @override
  String get flash_error_301_hint => 'Ostatnie odznaczenie zostało ponownie zaznaczone, aby zapewnić wybór jednej wartości. Aby ją odznaczyć, najpierw wybierz inną wartość.';
}
