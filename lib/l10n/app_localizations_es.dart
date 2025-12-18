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
  String get start => 'Comenzar';

  @override
  String get configure => 'Configurar';

  @override
  String get selectLanguage => 'Seleccionar idioma';

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
  String get configAtLeastOneOption => 'Debe haber al menos una opción seleccionada en esta sección. Re–seleccionando la última opción. Por favor, inténtelo de nuevo.';

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
  String get summary_seconds => 'segundos';

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
  String get listeningActive => 'Listening…';

  @override
  String get listeningInactive => 'Listening paused';
}
