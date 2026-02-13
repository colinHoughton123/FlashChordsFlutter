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
  String get welcomeUpdate_Update => 'Actualización disponible';

  @override
  String get welcomeUpdate_Button_Later => 'Más tarde';

  @override
  String get welcomeUpdate_Button_Update => 'Actualizar';

  @override
  String get listenerLimitReachedTitle => 'Escucha deshabilitada';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'La escucha se ha deshabilitado después de $limit tarjetas gratuitas. Actualiza para volver a habilitarla.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Versión gratuita: $played de $limit tarjetas con escucha usadas';
  }

  @override
  String get listenerLimitDialogTitle => 'Límite gratuito alcanzado';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords seguirá funcionando, pero la escucha está deshabilitada a menos que actualices por $price.';
  }

  @override
  String get upgrade => 'Actualizar';

  @override
  String get later => 'Más tarde';

  @override
  String get listenerInversionNoticeTitle => 'Nota del modo escucha';

  @override
  String get listenerInversionNoticePart1 => 'Has seleccionado más de una inversión. Ten en cuenta que FlashChords no puede “oír” la diferencia entre inversiones. Se mostrarán los patrones de teclas esperados, pero un acorde tocado en la inversión incorrecta se marcará como ';

  @override
  String get listenerInversionNoticeAny => '“correcto”';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'No mostrar esto de nuevo';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Cargando acordes...';

  @override
  String get start => 'Comenzar';

  @override
  String get configure => 'Configurar';

  @override
  String get mainCatchPhrase => '¡Aprende acordes en un instante!';

  @override
  String get mainFeaturesTitle => 'Funciones';

  @override
  String get mainFeatures1Title => 'Selecciona tus acordes';

  @override
  String get mainFeatures1Content => 'Elige qué acordes practicar';

  @override
  String get mainFeatures2Title => 'Desafíos cronometrados';

  @override
  String get mainFeatures2Content => 'Pon a prueba tu tiempo de respuesta con temporizadores personalizados';

  @override
  String get mainFeatures3Title => 'Modo de Escucha en Vivo';

  @override
  String get mainFeatures3Content => 'Los acordes se detectan y se evalúan automáticamente';

  @override
  String get language_picker_title => 'Seleccionar idioma';

  @override
  String get language_change_tooltip => 'Cambiar idioma';

  @override
  String get configTitle => 'Configuración';

  @override
  String get configSelectRoots => 'Seleccionar acordes';

  @override
  String get configSelectChordTypes => 'Seleccionar tipos de acordes';

  @override
  String get configSelectInversions => 'Seleccionar inversiones';

  @override
  String get configEnableTimer => 'Activar temporizador';

  @override
  String get configTimerSeconds => 'Temporizador (segundos)';

  @override
  String get saveButton => 'Guardar';

  @override
  String get configListener => 'Activar el micrófono para escuchar y marcar Correcto';

  @override
  String get configIncorrect => 'Marcar el acorde como Incorrecto si no es el primero tocado después de iniciar el temporizador';

  @override
  String get configAtLeastOneOption => 'Debe seleccionarse al menos una opción en esta sección. Se ha vuelto a seleccionar la última opción. Inténtalo de nuevo.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Activar modo de escucha (función futura)';

  @override
  String get configEnableListeningDesc => 'Marcar automáticamente el acorde como correcto cuando la detección de audio coincida.';

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
  String get chord_suspended2 => 'Suspendido 2';

  @override
  String get chord_suspended4 => 'Suspendido 4';

  @override
  String get chord_augmented => 'Aumentado';

  @override
  String get inv_root => 'Posición fundamental';

  @override
  String get inv_first => '1ª inversión';

  @override
  String get inv_second => '2ª inversión';

  @override
  String get configCardOrder => 'Orden de las tarjetas';

  @override
  String get configCardOrderRandom => 'Aleatorio';

  @override
  String get configCardOrderSorted => 'Ordenado';

  @override
  String get flash_incorrectCountLabel => 'Incorrecto';

  @override
  String get flash_correctCountLabel => 'Correcto';

  @override
  String get flash_playingMainDeck => 'Jugando el mazo principal';

  @override
  String get flash_playingErrorDeck => 'Jugando el mazo de errores';

  @override
  String get flash_redoButton => 'REHACER';

  @override
  String get flash_playedLabel => 'jugadas';

  @override
  String get flash_toGoLabel => 'restantes';

  @override
  String get flash_averageTimeLabel => 'Tiempo promedio:';

  @override
  String get flash_timeLabel => 'Temporizador';

  @override
  String get flash_timerCancelled => 'Temporizador cancelado';

  @override
  String get flash_reveal => 'Mostrar acorde';

  @override
  String get flash_play_instruction => 'Toca el siguiente acorde\nseleccionado aleatoriamente del mazo principal';

  @override
  String get flash_swipe_right => 'Desliza a la derecha si lo tocaste correctamente';

  @override
  String get flash_swipe_left => 'Desliza a la izquierda si lo tocaste incorrectamente';

  @override
  String get flash_not_sure => '¿No estás seguro? Toca la tarjeta para ver la digitación';

  @override
  String get flash_welcome1 => 'Aquí se mostrará el nombre de un acorde';

  @override
  String get flash_welcome2 => 'Tócalo en tu piano';

  @override
  String get flash_incorrect_count => 'Conteo incorrecto';

  @override
  String get flash_correct_count => 'Conteo correcto';

  @override
  String get flash_playing_main => 'Jugando el mazo principal';

  @override
  String get flash_playing_wrong => 'Jugando los errores';

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
  String get detectedLabel => 'Detected';

  @override
  String get missingLabel => 'Missing';

  @override
  String get summary_title => 'Resumen';

  @override
  String get summary_correct => 'Correcto';

  @override
  String get summary_incorrect => 'Incorrecto';

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
  String get summary_play_again => 'Volver a jugar con el mazo de errores';

  @override
  String get summary_done => 'Empezar de nuevo';

  @override
  String get summary_accuracy => 'Precisión';

  @override
  String get summary_average_time_correct => 'Promedio (acordes correctos)';

  @override
  String get summary_average_time_all => 'Tiempo promedio (todos los acordes)';

  @override
  String get summary_unsaved_changes_title => 'No has guardado tus cambios';

  @override
  String get summary_unsaved_changes_body => 'Hiciste un cambio en la configuración. Si quieres guardar, presiona CANCELAR ahora y luego presiona GUARDAR.';

  @override
  String get summary_discard => 'Descartar cambios';

  @override
  String get cancel => 'Cancelar';

  @override
  String get listeningActive => 'Escuchando…';

  @override
  String get listeningInactive => 'Escucha en pausa';

  @override
  String get flash_error_101 => 'La entrada de audio no está permitida.';

  @override
  String get flash_error_101_hint => 'FlashChords no tiene permiso para acceder al micrófono. Activa el acceso al micrófono en la configuración de tu dispositivo y reinicia la app.';

  @override
  String get flash_error_102 => 'No se puede iniciar la escucha de audio.';

  @override
  String get flash_error_102_hint => 'FlashChords no pudo inicializar el sistema de audio. Verifica que ninguna otra app esté usando el micrófono y reinicia la app.';

  @override
  String get flash_error_103 => 'La entrada de audio fue interrumpida.';

  @override
  String get flash_error_103_hint => 'La escucha se detuvo debido a una interrupción de audio. Verifica la conexión de tu micrófono y reinicia la escucha.';

  @override
  String get flash_error_201 => 'Ocurrió un error interno.';

  @override
  String get flash_error_201_hint => 'FlashChords encontró un error inesperado. Reinicia la app. Si el problema persiste, contacta con soporte con este código de error.';

  @override
  String get flash_error_301 => 'Debe seleccionarse al menos un valor.';

  @override
  String get flash_error_301_hint => 'Tu última deselección se ha vuelto a seleccionar para asegurar que haya un valor seleccionado. Para deseleccionarlo, selecciona primero otro valor.';

  @override
  String get language_picker_scroll_hint => 'Desplázate para ver más idiomas';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'Cómo funciona';

  @override
  String get howItWorksBody => 'Coloca tu dispositivo sobre el piano. Para cada tarjeta, toca el acorde mostrado. Si el oyente está activado (Configuración) y tocas las teclas correctas antes de que termine el temporizador (si está activado), FlashChords™ lo marcará como correcto y mostrará la siguiente tarjeta. Si el oyente está desactivado, márcalo tú mismo: marca de verificación o desliza a la derecha para correcto, X o desliza a la izquierda para incorrecto. Toca la tarjeta para ver las teclas esperadas.\n\nNota: los acordes en octavas muy bajas pueden ser más difíciles de detectar en algunos dispositivos o teclados.';

  @override
  String get upgradeReenableListener => 'Mejora para volver a activar el oyente';

  @override
  String get configShowCorrectOnError => 'Mostrar teclas correctas cuando se detecte un error';
}
