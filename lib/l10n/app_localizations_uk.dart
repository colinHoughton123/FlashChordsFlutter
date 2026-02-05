// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get welcomeTitle => 'Ласкаво просимо до FlashChords';

  @override
  String get welcomeUpdate_Update => 'Доступне оновлення';

  @override
  String get welcomeUpdate_Button_Later => 'Пізніше';

  @override
  String get welcomeUpdate_Button_Update => 'Оновити';

  @override
  String get listenerLimitReachedTitle => 'Слухач вимкнено';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'Функцію слухача вимкнено після $limit безкоштовних карток. Оновіть, щоб знову ввімкнути.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Безкоштовна версія: використано $played із $limit карток зі слухачем';
  }

  @override
  String get listenerLimitDialogTitle => 'Досягнуто безкоштовного ліміту';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords продовжить працювати, але слухач буде вимкнений, якщо ви не оновитеся за $price.';
  }

  @override
  String get upgrade => 'Оновити';

  @override
  String get later => 'Пізніше';

  @override
  String get listenerInversionNoticeTitle => 'Примітка слухача';

  @override
  String get listenerInversionNoticePart1 => 'Ви вибрали більше ніж одну інверсію. Зверніть увагу, що FlashChords не може “почути” різницю між інверсіями. Очікувані клавішні шаблони будуть показані, але акорди, зіграні в неправильній інверсії, будуть позначені як ';

  @override
  String get listenerInversionNoticeAny => '“правильні”';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Більше не показувати';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Завантаження акордів...';

  @override
  String get start => 'Почати';

  @override
  String get configure => 'Налаштувати';

  @override
  String get mainCatchPhrase => 'Вивчайте акорди миттєво!';

  @override
  String get mainFeaturesTitle => 'Функції';

  @override
  String get mainFeatures1Title => 'Оберіть свої акорди';

  @override
  String get mainFeatures1Content => 'Налаштуйте, на яких акордах зосередитися';

  @override
  String get mainFeatures2Title => 'Часові виклики';

  @override
  String get mainFeatures2Content => 'Перевіряйте себе з індивідуальними таймерами';

  @override
  String get mainFeatures3Title => 'Автоматичне оцінювання';

  @override
  String get mainFeatures3Content => 'Дозвольте FlashChords слухати вашу гру на піаніно';

  @override
  String get language_picker_title => 'Виберіть мову';

  @override
  String get language_change_tooltip => 'Змінити мову';

  @override
  String get configTitle => 'Налаштування';

  @override
  String get configSelectRoots => 'Виберіть акорди';

  @override
  String get configSelectChordTypes => 'Виберіть типи акордів';

  @override
  String get configSelectInversions => 'Виберіть інверсії';

  @override
  String get configEnableTimer => 'Увімкнути таймер';

  @override
  String get configTimerSeconds => 'Таймер (секунди)';

  @override
  String get saveButton => 'Зберегти';

  @override
  String get configListener => 'Увімкніть мікрофон, щоб слухати й позначати як правильно';

  @override
  String get configIncorrect => 'Позначати акорд як неправильний, якщо це не перший акорд після запуску таймера';

  @override
  String get configAtLeastOneOption => 'У цьому розділі має бути вибрано принаймні один варіант. Останній варіант було вибрано знову. Спробуйте ще раз.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Увімкнути режим слухання (майбутня функція)';

  @override
  String get configEnableListeningDesc => 'Автоматично позначати акорд як правильний, коли аудіо-розпізнавання збігається.';

  @override
  String get chord_major => 'Мажор';

  @override
  String get chord_minor => 'Мінор';

  @override
  String get chord_diminished => 'Зменшений';

  @override
  String get chord_dominant7 => 'Домінантний септакорд';

  @override
  String get chord_major7 => 'Мажорний септакорд';

  @override
  String get chord_minor7 => 'Мінорний септакорд';

  @override
  String get chord_suspended2 => 'Суспендований 2';

  @override
  String get chord_suspended4 => 'Суспендований 4';

  @override
  String get chord_augmented => 'Збільшений';

  @override
  String get inv_root => 'Основна позиція';

  @override
  String get inv_first => '1-ша інверсія';

  @override
  String get inv_second => '2-га інверсія';

  @override
  String get configCardOrder => 'Порядок карток';

  @override
  String get configCardOrderRandom => 'Випадковий';

  @override
  String get configCardOrderSorted => 'Відсортований';

  @override
  String get flash_incorrectCountLabel => 'Неправильно';

  @override
  String get flash_correctCountLabel => 'Правильно';

  @override
  String get flash_playingMainDeck => 'Гра з основною колодою';

  @override
  String get flash_playingErrorDeck => 'Гра з колодою помилок';

  @override
  String get flash_redoButton => 'ПОВТОР';

  @override
  String get flash_playedLabel => 'зіграно';

  @override
  String get flash_toGoLabel => 'залишилось';

  @override
  String get flash_averageTimeLabel => 'Середній час:';

  @override
  String get flash_timeLabel => 'Таймер';

  @override
  String get flash_timerCancelled => 'Таймер скасовано';

  @override
  String get flash_reveal => 'Показати акорд';

  @override
  String get flash_play_instruction => 'Зіграйте наступний акорд\nвипадково вибраний з основної колоди';

  @override
  String get flash_swipe_right => 'Проведіть вправо, якщо зіграли правильно';

  @override
  String get flash_swipe_left => 'Проведіть вліво, якщо зіграли неправильно';

  @override
  String get flash_not_sure => 'Не впевнені? Торкніться картки, щоб побачити аплікатуру';

  @override
  String get flash_welcome1 => 'Тут буде показано назву акорду';

  @override
  String get flash_welcome2 => 'Зіграйте його на піаніно';

  @override
  String get flash_incorrect_count => 'Кількість помилок';

  @override
  String get flash_correct_count => 'Кількість правильних';

  @override
  String get flash_playing_main => 'Гра з основною колодою';

  @override
  String get flash_playing_wrong => 'Гра з помилками';

  @override
  String get flash_play_again => 'Грати знову';

  @override
  String get flash_average_time => 'Середній час';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played зіграно, $remaining залишилось';
  }

  @override
  String get flash_mainDeck => 'Основна колода';

  @override
  String get flash_errorDeck => 'Колодa помилок';

  @override
  String get flash_correct => 'Правильно';

  @override
  String get flash_incorrect => 'Неправильно';

  @override
  String get flash_of => 'з';

  @override
  String get flash_next => 'Далі';

  @override
  String get summary_title => 'Підсумок';

  @override
  String get summary_correct => 'Правильно';

  @override
  String get summary_incorrect => 'Неправильно';

  @override
  String get summary_cards => 'Картки';

  @override
  String get summary_average_time => 'Середній час';

  @override
  String get summary_seconds => 'секунд';

  @override
  String get summary_from_main_deck => 'Основна колода';

  @override
  String get summary_from_error_deck => 'Колодa помилок';

  @override
  String get summary_play_again => 'Грати знову';

  @override
  String get summary_done => 'Готово';

  @override
  String get summary_accuracy => 'Точність';

  @override
  String get summary_average_time_correct => 'Середній (правильні акорди)';

  @override
  String get summary_average_time_all => 'Середній час (усі акорди)';

  @override
  String get summary_unsaved_changes_title => 'Ви не зберегли зміни';

  @override
  String get summary_unsaved_changes_body => 'Ви внесли зміни в налаштування. Якщо хочете зберегти, натисніть CANCEL зараз, а потім SAVE.';

  @override
  String get summary_discard => 'Скасувати зміни';

  @override
  String get cancel => 'Скасувати';

  @override
  String get listeningActive => 'Слухання…';

  @override
  String get listeningInactive => 'Слухання призупинено';

  @override
  String get flash_error_101 => 'Аудіовхід не дозволено.';

  @override
  String get flash_error_101_hint => 'FlashChords не має дозволу на доступ до мікрофона. Увімкніть доступ у налаштуваннях пристрою та перезапустіть додаток.';

  @override
  String get flash_error_102 => 'Не вдалося почати слухання аудіо.';

  @override
  String get flash_error_102_hint => 'FlashChords не зміг ініціалізувати аудіосистему. Переконайтеся, що жоден інший додаток не використовує мікрофон, і перезапустіть додаток.';

  @override
  String get flash_error_103 => 'Аудіовхід було перервано.';

  @override
  String get flash_error_103_hint => 'Слухання зупинено через переривання аудіо. Перевірте підключення мікрофона та перезапустіть слухання.';

  @override
  String get flash_error_201 => 'Сталася внутрішня помилка.';

  @override
  String get flash_error_201_hint => 'FlashChords зіткнувся з неочікуваною помилкою. Перезапустіть додаток. Якщо проблема не зникне, зверніться до підтримки з цим кодом помилки.';

  @override
  String get flash_error_301 => 'Потрібно вибрати принаймні одне значення.';

  @override
  String get flash_error_301_hint => 'Останнє скасування вибору було знову вибрано, щоб забезпечити вибір хоча б одного значення. Щоб скасувати, спочатку виберіть інше значення.';

  @override
  String get language_picker_scroll_hint => 'Прокрутіть, щоб побачити більше мов';
}
