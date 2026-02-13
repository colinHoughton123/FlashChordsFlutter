// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get welcomeTitle => 'Benvenuto su FlashChords';

  @override
  String get welcomeUpdate_Update => 'Aggiornamento disponibile';

  @override
  String get welcomeUpdate_Button_Later => 'Più tardi';

  @override
  String get welcomeUpdate_Button_Update => 'Aggiorna';

  @override
  String get listenerLimitReachedTitle => 'Ascolto disabilitato';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'L’ascolto è stato disabilitato dopo $limit carte gratuite. Passa alla versione superiore per riattivarlo.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Versione gratuita: $played di $limit carte con ascolto utilizzate';
  }

  @override
  String get listenerLimitDialogTitle => 'Limite gratuito raggiunto';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords continuerà a funzionare, ma l’ascolto è disabilitato a meno che tu non effettui l’upgrade per $price.';
  }

  @override
  String get upgrade => 'Aggiorna';

  @override
  String get later => 'Più tardi';

  @override
  String get listenerInversionNoticeTitle => 'Nota sull’ascolto';

  @override
  String get listenerInversionNoticePart1 => 'Hai selezionato più di un’inversione. Tieni presente che FlashChords non può “sentire” la differenza tra le inversioni. Verranno mostrati i pattern di tasti previsti, ma un accordo suonato nell’inversione sbagliata sarà contrassegnato come ';

  @override
  String get listenerInversionNoticeAny => '“corretto”';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Non mostrare più';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Caricamento accordi...';

  @override
  String get start => 'Inizia';

  @override
  String get configure => 'Configura';

  @override
  String get mainCatchPhrase => 'Impara gli accordi in un lampo!';

  @override
  String get mainFeaturesTitle => 'Funzionalità';

  @override
  String get mainFeatures1Title => 'Seleziona i tuoi accordi';

  @override
  String get mainFeatures1Content => 'Scegli quali accordi esercitare';

  @override
  String get mainFeatures2Title => 'Sfide a tempo';

  @override
  String get mainFeatures2Content => 'Metti alla prova il tuo tempo di risposta con timer personalizzati';

  @override
  String get mainFeatures3Title => 'Modalità di ascolto dal vivo';

  @override
  String get mainFeatures3Content => 'Gli accordi vengono rilevati e valutati automaticamente';

  @override
  String get language_picker_title => 'Seleziona lingua';

  @override
  String get language_change_tooltip => 'Cambia lingua';

  @override
  String get configTitle => 'Configurazione';

  @override
  String get configSelectRoots => 'Seleziona accordi';

  @override
  String get configSelectChordTypes => 'Seleziona tipi di accordi';

  @override
  String get configSelectInversions => 'Seleziona inversioni';

  @override
  String get configEnableTimer => 'Abilita timer';

  @override
  String get configTimerSeconds => 'Timer (secondi)';

  @override
  String get saveButton => 'Salva';

  @override
  String get configListener => 'Abilita il microfono per ascoltare e contrassegnare Corretto';

  @override
  String get configIncorrect => 'Contrassegna l’accordo come Errato se non è il primo suonato dopo l’avvio del timer';

  @override
  String get configAtLeastOneOption => 'Almeno un’opzione deve essere selezionata in questa sezione. L’ultima opzione è stata riselezionata. Riprova.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Abilita modalità Ascolto (funzionalità futura)';

  @override
  String get configEnableListeningDesc => 'Contrassegna automaticamente l’accordo come corretto quando la rilevazione audio corrisponde.';

  @override
  String get chord_major => 'Maggiore';

  @override
  String get chord_minor => 'Minore';

  @override
  String get chord_diminished => 'Diminuito';

  @override
  String get chord_dominant7 => 'Settima di dominante';

  @override
  String get chord_major7 => 'Settima maggiore';

  @override
  String get chord_minor7 => 'Settima minore';

  @override
  String get chord_suspended2 => 'Sospeso 2';

  @override
  String get chord_suspended4 => 'Sospeso 4';

  @override
  String get chord_augmented => 'Aumentato';

  @override
  String get inv_root => 'Posizione fondamentale';

  @override
  String get inv_first => '1ª inversione';

  @override
  String get inv_second => '2ª inversione';

  @override
  String get configCardOrder => 'Ordine delle carte';

  @override
  String get configCardOrderRandom => 'Casuale';

  @override
  String get configCardOrderSorted => 'Ordinato';

  @override
  String get flash_incorrectCountLabel => 'Errato';

  @override
  String get flash_correctCountLabel => 'Corretto';

  @override
  String get flash_playingMainDeck => 'Stai usando il mazzo principale';

  @override
  String get flash_playingErrorDeck => 'Stai usando il mazzo degli errori';

  @override
  String get flash_redoButton => 'RIPETI';

  @override
  String get flash_playedLabel => 'giocate';

  @override
  String get flash_toGoLabel => 'rimanenti';

  @override
  String get flash_averageTimeLabel => 'Tempo medio:';

  @override
  String get flash_timeLabel => 'Timer';

  @override
  String get flash_timerCancelled => 'Timer annullato';

  @override
  String get flash_reveal => 'Mostra accordo';

  @override
  String get flash_play_instruction => 'Suona il seguente accordo\nselezionato casualmente dal mazzo principale';

  @override
  String get flash_swipe_right => 'Scorri a destra se lo hai suonato correttamente';

  @override
  String get flash_swipe_left => 'Scorri a sinistra se lo hai suonato in modo errato';

  @override
  String get flash_not_sure => 'Non sei sicuro? Tocca la carta per vedere la diteggiatura';

  @override
  String get flash_welcome1 => 'Qui verrà mostrato il nome di un accordo';

  @override
  String get flash_welcome2 => 'Suonalo sul tuo pianoforte';

  @override
  String get flash_incorrect_count => 'Conteggio errori';

  @override
  String get flash_correct_count => 'Conteggio corretti';

  @override
  String get flash_playing_main => 'Stai usando il mazzo principale';

  @override
  String get flash_playing_wrong => 'Stai usando gli errori';

  @override
  String get flash_play_again => 'Gioca di nuovo';

  @override
  String get flash_average_time => 'Tempo medio';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played giocate, $remaining rimanenti';
  }

  @override
  String get flash_mainDeck => 'Mazzo principale';

  @override
  String get flash_errorDeck => 'Mazzo degli errori';

  @override
  String get flash_correct => 'Corretto';

  @override
  String get flash_incorrect => 'Errato';

  @override
  String get flash_of => 'di';

  @override
  String get flash_next => 'Avanti';

  @override
  String get detectedLabel => 'Detected';

  @override
  String get missingLabel => 'Missing';

  @override
  String get summary_title => 'Riepilogo';

  @override
  String get summary_correct => 'Corretto';

  @override
  String get summary_incorrect => 'Errato';

  @override
  String get summary_cards => 'Carte';

  @override
  String get summary_average_time => 'Tempo medio';

  @override
  String get summary_seconds => 'secondi';

  @override
  String get summary_from_main_deck => 'Mazzo principale';

  @override
  String get summary_from_error_deck => 'Mazzo degli errori';

  @override
  String get summary_play_again => 'Gioca di nuovo con il mazzo errori';

  @override
  String get summary_done => 'Ricomincia';

  @override
  String get summary_accuracy => 'Precisione';

  @override
  String get summary_average_time_correct => 'Media (accordi corretti)';

  @override
  String get summary_average_time_all => 'Tempo medio (tutti gli accordi)';

  @override
  String get summary_unsaved_changes_title => 'Non hai salvato le modifiche';

  @override
  String get summary_unsaved_changes_body => 'Hai apportato una modifica alla configurazione. Se vuoi salvare, premi ANNULLA ora, poi premi SALVA.';

  @override
  String get summary_discard => 'Scarta modifiche';

  @override
  String get cancel => 'Annulla';

  @override
  String get listeningActive => 'In ascolto…';

  @override
  String get listeningInactive => 'Ascolto in pausa';

  @override
  String get flash_error_101 => 'L’ingresso audio non è consentito.';

  @override
  String get flash_error_101_hint => 'FlashChords non ha il permesso di accedere al microfono. Abilita l’accesso al microfono nelle impostazioni del dispositivo e riavvia l’app.';

  @override
  String get flash_error_102 => 'Impossibile avviare l’ascolto audio.';

  @override
  String get flash_error_102_hint => 'FlashChords non è riuscito a inizializzare il sistema audio. Verifica che nessun’altra app stia usando il microfono e riavvia l’app.';

  @override
  String get flash_error_103 => 'L’ingresso audio è stato interrotto.';

  @override
  String get flash_error_103_hint => 'L’ascolto si è fermato a causa di un’interruzione audio. Controlla la connessione del microfono e riavvia l’ascolto.';

  @override
  String get flash_error_201 => 'Si è verificato un errore interno.';

  @override
  String get flash_error_201_hint => 'FlashChords ha riscontrato un errore imprevisto. Riavvia l’app. Se il problema persiste, contatta il supporto con questo codice di errore.';

  @override
  String get flash_error_301 => 'Deve essere selezionato almeno un valore.';

  @override
  String get flash_error_301_hint => 'L’ultima deselezione è stata riselezionata per garantire che un valore sia selezionato. Per deselezionarlo, seleziona prima un altro valore.';

  @override
  String get language_picker_scroll_hint => 'Scorri per vedere altre lingue';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'Come funziona';

  @override
  String get howItWorksBody => 'Posiziona il dispositivo sul pianoforte. Per ogni scheda, suona l’accordo mostrato. Se l’ascolto è attivo (Configurazione) e suoni i tasti corretti prima della fine del timer (se attivo), FlashChords™ lo segnerà come corretto e mostrerà la scheda successiva. Se l’ascolto è disattivato, segna tu: spunta o scorri a destra per corretto, X o scorri a sinistra per errato. Tocca la scheda per vedere i tasti attesi.\n\nNota: gli accordi in ottave molto basse possono essere più difficili da rilevare su alcuni dispositivi o tastiere.';

  @override
  String get upgradeReenableListener => 'Esegui l’upgrade per riattivare l’ascolto';

  @override
  String get configShowCorrectOnError => 'Mostra i tasti corretti quando viene rilevato un errore';
}
