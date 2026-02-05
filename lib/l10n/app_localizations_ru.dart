// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get welcomeTitle => 'Добро пожаловать в FlashChords';

  @override
  String get welcomeUpdate_Update => 'Доступно обновление';

  @override
  String get welcomeUpdate_Button_Later => 'Позже';

  @override
  String get welcomeUpdate_Button_Update => 'Обновить';

  @override
  String get listenerLimitReachedTitle => 'Прослушивание отключено';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'Прослушивание было отключено после $limit бесплатных карточек. Обновитесь, чтобы снова включить.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Бесплатная версия: использовано $played из $limit карточек с прослушиванием';
  }

  @override
  String get listenerLimitDialogTitle => 'Бесплатный лимит достигнут';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords продолжит работать, но прослушивание отключено, если вы не обновитесь за $price.';
  }

  @override
  String get upgrade => 'Обновить';

  @override
  String get later => 'Позже';

  @override
  String get listenerInversionNoticeTitle => 'Примечание о прослушивании';

  @override
  String get listenerInversionNoticePart1 => 'Вы выбрали более одной инверсии. Учтите, что FlashChords не может «услышать» разницу между инверсиями. Ожидаемые схемы клавиш будут показаны, но аккорд, сыгранный в неправильной инверсии, будет отмечен как ';

  @override
  String get listenerInversionNoticeAny => '«правильный»';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Больше не показывать';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Загрузка аккордов...';

  @override
  String get start => 'Старт';

  @override
  String get configure => 'Настроить';

  @override
  String get mainCatchPhrase => 'Учите аккорды мгновенно!';

  @override
  String get mainFeaturesTitle => 'Функции';

  @override
  String get mainFeatures1Title => 'Выберите свои аккорды';

  @override
  String get mainFeatures1Content => 'Настройте, на каких аккордах вы хотите сосредоточиться';

  @override
  String get mainFeatures2Title => 'Задания на время';

  @override
  String get mainFeatures2Content => 'Проверьте себя с настраиваемыми таймерами';

  @override
  String get mainFeatures3Title => 'Автоматическая проверка';

  @override
  String get mainFeatures3Content => 'Позвольте FlashChords слушать вашу игру на пианино';

  @override
  String get language_picker_title => 'Выберите язык';

  @override
  String get language_change_tooltip => 'Сменить язык';

  @override
  String get configTitle => 'Настройка';

  @override
  String get configSelectRoots => 'Выбрать аккорды';

  @override
  String get configSelectChordTypes => 'Выбрать типы аккордов';

  @override
  String get configSelectInversions => 'Выбрать инверсии';

  @override
  String get configEnableTimer => 'Включить таймер';

  @override
  String get configTimerSeconds => 'Таймер (секунды)';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get configListener => 'Включить микрофон для прослушивания и отметки как Правильно';

  @override
  String get configIncorrect => 'Отмечать аккорд как Неправильный, если он не первый сыгранный после запуска таймера';

  @override
  String get configAtLeastOneOption => 'В этом разделе должна быть выбрана хотя бы одна опция. Последняя опция была выбрана снова. Попробуйте ещё раз.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Включить режим прослушивания (будущая функция)';

  @override
  String get configEnableListeningDesc => 'Автоматически отмечать аккорд как правильный при совпадении аудио-распознавания.';

  @override
  String get chord_major => 'Мажор';

  @override
  String get chord_minor => 'Минор';

  @override
  String get chord_diminished => 'Уменьшенный';

  @override
  String get chord_dominant7 => 'Доминантсептаккорд';

  @override
  String get chord_major7 => 'Мажорный септаккорд';

  @override
  String get chord_minor7 => 'Минорный септаккорд';

  @override
  String get chord_suspended2 => 'Sus2';

  @override
  String get chord_suspended4 => 'Sus4';

  @override
  String get chord_augmented => 'Увеличенный';

  @override
  String get inv_root => 'Основное положение';

  @override
  String get inv_first => '1-я инверсия';

  @override
  String get inv_second => '2-я инверсия';

  @override
  String get configCardOrder => 'Порядок карточек';

  @override
  String get configCardOrderRandom => 'Случайный';

  @override
  String get configCardOrderSorted => 'Отсортированный';

  @override
  String get flash_incorrectCountLabel => 'Неправильно';

  @override
  String get flash_correctCountLabel => 'Правильно';

  @override
  String get flash_playingMainDeck => 'Игра с основной колодой';

  @override
  String get flash_playingErrorDeck => 'Игра с колодой ошибок';

  @override
  String get flash_redoButton => 'ПОВТОР';

  @override
  String get flash_playedLabel => 'сыграно';

  @override
  String get flash_toGoLabel => 'осталось';

  @override
  String get flash_averageTimeLabel => 'Среднее время:';

  @override
  String get flash_timeLabel => 'Таймер';

  @override
  String get flash_timerCancelled => 'Таймер отменён';

  @override
  String get flash_reveal => 'Показать аккорд';

  @override
  String get flash_play_instruction => 'Сыграйте следующий аккорд\nслучайно выбранный из основной колоды';

  @override
  String get flash_swipe_right => 'Смахните вправо, если сыграли правильно';

  @override
  String get flash_swipe_left => 'Смахните влево, если сыграли неправильно';

  @override
  String get flash_not_sure => 'Не уверены? Нажмите на карточку, чтобы увидеть аппликатуру';

  @override
  String get flash_welcome1 => 'Здесь появится название аккорда';

  @override
  String get flash_welcome2 => 'Сыграйте его на пианино';

  @override
  String get flash_incorrect_count => 'Количество ошибок';

  @override
  String get flash_correct_count => 'Количество правильных';

  @override
  String get flash_playing_main => 'Игра с основной колодой';

  @override
  String get flash_playing_wrong => 'Игра с ошибками';

  @override
  String get flash_play_again => 'Сыграть снова';

  @override
  String get flash_average_time => 'Среднее время';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played сыграно, $remaining осталось';
  }

  @override
  String get flash_mainDeck => 'Основная колода';

  @override
  String get flash_errorDeck => 'Колода ошибок';

  @override
  String get flash_correct => 'Правильно';

  @override
  String get flash_incorrect => 'Неправильно';

  @override
  String get flash_of => 'из';

  @override
  String get flash_next => 'Далее';

  @override
  String get summary_title => 'Итоги';

  @override
  String get summary_correct => 'Правильно';

  @override
  String get summary_incorrect => 'Неправильно';

  @override
  String get summary_cards => 'Карточки';

  @override
  String get summary_average_time => 'Среднее время';

  @override
  String get summary_seconds => 'секунд';

  @override
  String get summary_from_main_deck => 'Основная колода';

  @override
  String get summary_from_error_deck => 'Колода ошибок';

  @override
  String get summary_play_again => 'Сыграть снова';

  @override
  String get summary_done => 'Готово';

  @override
  String get summary_accuracy => 'Точность';

  @override
  String get summary_average_time_correct => 'Среднее (правильные аккорды)';

  @override
  String get summary_average_time_all => 'Среднее время (все аккорды)';

  @override
  String get summary_unsaved_changes_title => 'Вы не сохранили изменения';

  @override
  String get summary_unsaved_changes_body => 'Вы внесли изменение в настройках. Если хотите сохранить, нажмите ОТМЕНА сейчас, затем нажмите СОХРАНИТЬ.';

  @override
  String get summary_discard => 'Отменить изменения';

  @override
  String get cancel => 'Отмена';

  @override
  String get listeningActive => 'Прослушивание…';

  @override
  String get listeningInactive => 'Прослушивание приостановлено';

  @override
  String get flash_error_101 => 'Аудиоввод не разрешён.';

  @override
  String get flash_error_101_hint => 'FlashChords не имеет разрешения на доступ к микрофону. Включите доступ к микрофону в настройках устройства и перезапустите приложение.';

  @override
  String get flash_error_102 => 'Не удалось начать прослушивание.';

  @override
  String get flash_error_102_hint => 'FlashChords не смог инициализировать аудиосистему. Убедитесь, что никакое другое приложение не использует микрофон, и перезапустите приложение.';

  @override
  String get flash_error_103 => 'Аудиоввод был прерван.';

  @override
  String get flash_error_103_hint => 'Прослушивание остановлено из-за прерывания аудио. Проверьте подключение микрофона и перезапустите прослушивание.';

  @override
  String get flash_error_201 => 'Произошла внутренняя ошибка.';

  @override
  String get flash_error_201_hint => 'FlashChords столкнулся с неожиданной ошибкой. Перезапустите приложение. Если проблема сохраняется, обратитесь в поддержку с этим кодом ошибки.';

  @override
  String get flash_error_301 => 'Необходимо выбрать хотя бы одно значение.';

  @override
  String get flash_error_301_hint => 'Последний снятый выбор был снова отмечен, чтобы гарантировать выбор одного значения. Чтобы снять его, сначала выберите другое значение.';

  @override
  String get language_picker_scroll_hint => 'Прокрутите, чтобы увидеть больше языков';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'Как это работает';

  @override
  String get howItWorksBody => 'Положите устройство на пианино. Для каждой карточки сыграйте показанный аккорд. Если слушатель включён (Конфигурация) и вы сыграли правильные клавиши до окончания таймера (если он включён), FlashChords™ отметит это как правильно и покажет следующую карточку. Если слушатель выключен, отметьте сами: галочка или свайп вправо для правильного, X или свайп влево для неправильного. Нажмите на карточку, чтобы увидеть ожидаемые клавиши.';
}
