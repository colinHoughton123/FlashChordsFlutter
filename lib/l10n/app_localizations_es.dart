// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcomeTitle => 'Bienvenido a FlashChords';

  @override
  String get loadingChords => 'es -Loading. chords..';

  @override
  String get start => 'Comenzar';

  @override
  String get configure => 'Configurar';

  @override
  String get mainCatchPhrase => 'Learn chords in a flash!';

  @override
  String get mainFeaturesTitle => 'Features';

  @override
  String get mainFeatures1Title => 'Select your chords';

  @override
  String get mainFeatures1Content => 'Configure which chords to focus on';

  @override
  String get mainFeatures2Title => 'Timed Challenges';

  @override
  String get mainFeatures2Content => 'Test yourself with customized timers';

  @override
  String get mainFeatures3Title => 'Automatic Marking';

  @override
  String get mainFeatures3Content => 'Let FlashChords listen to your piano';

  @override
  String get language_picker_title => 'Ses- elect language';

  @override
  String get language_change_tooltip => 'es - Change language';

  @override
  String get configTitle => 'Configuración';

  @override
  String get configSelectRoots => 'Seleccione notas raíz';

  @override
  String get configSelectChordTypes => 'Seleccione tipos de acordes';

  @override
  String get configSelectInversions => 'Seleccione inversiones';

  @override
  String get configEnableTimer => 'Activar temporizador';

  @override
  String get configTimerSeconds => 'Temporizador (segundos)';

  @override
  String get saveButton => 'Guardar';

  @override
  String get configListener => 'es - Enable the microphone to listen and mark Correct';

  @override
  String get configAtLeastOneOption => 'Debe haber al menos una opción seleccionada en esta sección. Re–seleccionando la última opción. Por favor, inténtelo de nuevo.';

  @override
  String get configOK => 'es- OK';

  @override
  String get configEnableListening => 'Activar modo de escucha (función futura)';

  @override
  String get configEnableListeningDesc => 'Marcado automático como correcto si la detección coincide.';

  @override
  String get chord_major => 'Mayor';

  @override
  String get chord_minor => 'Menor';

  @override
  String get chord_diminished => 'Disminuido';

  @override
  String get chord_dominant7 => 'Séptima dominante';

  @override
  String get chord_major7 => 'Séptima mayor';

  @override
  String get chord_minor7 => 'Séptima menor';

  @override
  String get chord_suspended2 => 'Suspensión 2';

  @override
  String get chord_suspended4 => 'Suspensión 4';

  @override
  String get chord_augmented => 'Aumentado';

  @override
  String get inv_root => 'Posición fundamental';

  @override
  String get inv_first => 'Primera inversión';

  @override
  String get inv_second => 'Segunda inversión';

  @override
  String get configCardOrder => 'Orden de tarjetas';

  @override
  String get configCardOrderRandom => 'Aleatorio';

  @override
  String get configCardOrderSorted => 'Ordenado';

  @override
  String get flash_incorrectCountLabel => 'Incorrectas';

  @override
  String get flash_correctCountLabel => 'Correctas';

  @override
  String get flash_playingMainDeck => 'Jugando el mazo principal';

  @override
  String get flash_playingErrorDeck => 'Jugando el mazo de errores';

  @override
  String get flash_redoButton => 'REPETIR';

  @override
  String get flash_playedLabel => 'jugadas';

  @override
  String get flash_toGoLabel => 'restantes';

  @override
  String get flash_averageTimeLabel => 'Tiempo promedio:';

  @override
  String get flash_timeLabel => 'Tiempo';

  @override
  String get flash_timerCancelled => 'sp=Timer cancelled';

  @override
  String get flash_reveal => 'Show Chord';

  @override
  String get flash_play_instruction => 'Toque el siguiente acorde seleccionado aleatoriamente';

  @override
  String get flash_swipe_right => 'Deslice a la derecha si lo tocó correctamente';

  @override
  String get flash_swipe_left => 'Deslice a la izquierda si lo tocó incorrectamente';

  @override
  String get flash_not_sure => '¿No está seguro? Toque aquí para ver la digitación';

  @override
  String get flash_welcome1 => 'El nombre del acorde se mostrará aquí';

  @override
  String get flash_welcome2 => 'Toca el acorde en tu piano';

  @override
  String get flash_incorrect_count => 'Incorrectas';

  @override
  String get flash_correct_count => 'Correctas';

  @override
  String get flash_playing_main => 'Jugando mazo principal';

  @override
  String get flash_playing_wrong => 'Jugando errores';

  @override
  String get flash_play_again => 'Jugar de nuevo';

  @override
  String get flash_average_time => 'Tiempo promedio';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played jugadas, $remaining restantes';
  }

  @override
  String get flash_mainDeck => 'Mazo principal';

  @override
  String get flash_errorDeck => 'Mazo de errores';

  @override
  String get flash_correct => 'Correcto';

  @override
  String get flash_incorrect => 'Incorrecto';

  @override
  String get flash_of => 'de';

  @override
  String get flash_next => 'Siguiente';

  @override
  String get summary_title => 'Resumen';

  @override
  String get summary_correct => 'Correctas';

  @override
  String get summary_incorrect => 'Incorrectas';

  @override
  String get summary_cards => 'Tarjetas';

  @override
  String get summary_average_time => 'Tiempo promedio';

  @override
  String get summary_seconds => 'es -seconds';

  @override
  String get summary_from_main_deck => 'Mazo principal';

  @override
  String get summary_from_error_deck => 'Mazo de errores';

  @override
  String get summary_play_again => 'Jugar otra vez';

  @override
  String get summary_done => 'Listo';

  @override
  String get summary_accuracy => 'Precisión';

  @override
  String get summary_average_time_correct => 'es- Average time (correct chords)';

  @override
  String get summary_average_time_all => 'es- Average time (all chords)';

  @override
  String get summary_unsaved_changes_title => 'es -You have not saved your changes';

  @override
  String get summary_unsaved_changes_body => 'es -You made a change in the configuration.  If you want to save, press CANCEL now, then press SAVE.';

  @override
  String get summary_discard => 'es- Discard changes';

  @override
  String get cancel => 'es -Cancel';

  @override
  String get listeningActive => 'es - Listening…';

  @override
  String get listeningInactive => 'es - Listening paused';

  @override
  String get flash_error_101 => 'es - Audio input is not permitted.';

  @override
  String get flash_error_101_hint => 'es - FlashChords does not have permission to access the microphone. Please enable microphone access in your device settings and restart the app.';

  @override
  String get flash_error_102 => 'es - Unable to start audio listening.';

  @override
  String get flash_error_102_hint => 'es - FlashChords could not initialize the audio system. Please check that no other app is using the microphone and restart the app.';

  @override
  String get flash_error_103 => 'es - Audio input was interrupted.';

  @override
  String get flash_error_103_hint => 'es - Listening has stopped due to an audio interruption. Please check your microphone connection and restart listening.';

  @override
  String get flash_error_201 => 'An internal error occurred.';

  @override
  String get flash_error_201_hint => 'es - FlashChords encountered an unexpected error. Please restart the app. If the problem persists, contact support with this error code.';

  @override
  String get flash_error_301 => 'es - At least one value must be selected.';

  @override
  String get flash_error_301_hint => 'es - Your last de-select has been reselected to ensure one value is selected.  To deselect it, select another value first.';
}
