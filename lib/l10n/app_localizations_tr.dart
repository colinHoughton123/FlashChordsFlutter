// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get welcomeTitle => 'FlashChords’a Hoş Geldiniz';

  @override
  String get welcomeUpdate_Update => 'Güncelleme Mevcut';

  @override
  String get welcomeUpdate_Button_Later => 'Daha sonra';

  @override
  String get welcomeUpdate_Button_Update => 'Güncelle';

  @override
  String get listenerLimitReachedTitle => 'Dinleme devre dışı';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'Dinleme özelliği $limit ücretsiz karttan sonra devre dışı bırakıldı. Yeniden etkinleştirmek için yükseltin.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Ücretsiz sürüm: dinleme etkin $limit karttan $played tanesi kullanıldı';
  }

  @override
  String get listenerLimitDialogTitle => 'Ücretsiz limit doldu';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords çalışmaya devam edecek, ancak $price karşılığında yükseltme yapmadığınız sürece dinleme devre dışıdır.';
  }

  @override
  String get upgrade => 'Yükselt';

  @override
  String get later => 'Daha sonra';

  @override
  String get listenerInversionNoticeTitle => 'Dinleme Notu';

  @override
  String get listenerInversionNoticePart1 => 'Birden fazla çevrim (inversion) seçtiniz. FlashChords’un çevrimler arasındaki farkı “duyamayacağını” unutmayın. Beklenen tuş desenleri gösterilecektir, ancak yanlış çevrimde çalınan bir akor ';

  @override
  String get listenerInversionNoticeAny => '“doğru”';

  @override
  String get listenerInversionNoticePart2 => ' olarak işaretlenecektir.';

  @override
  String get listenerInversionNoticeDontShow => 'Bunu tekrar gösterme';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Akorlar yükleniyor...';

  @override
  String get start => 'Başlat';

  @override
  String get configure => 'Yapılandır';

  @override
  String get mainCatchPhrase => 'Akorları bir anda öğrenin!';

  @override
  String get mainFeaturesTitle => 'Özellikler';

  @override
  String get mainFeatures1Title => 'Akorlarınızı seçin';

  @override
  String get mainFeatures1Content => 'Hangi akorlara odaklanmak istediğinizi yapılandırın';

  @override
  String get mainFeatures2Title => 'Zamanlı Meydan Okumalar';

  @override
  String get mainFeatures2Content => 'Özelleştirilmiş zamanlayıcılarla kendinizi test edin';

  @override
  String get mainFeatures3Title => 'Otomatik İşaretleme';

  @override
  String get mainFeatures3Content => 'FlashChords’un piyanonuzu dinlemesine izin verin';

  @override
  String get language_picker_title => 'Dil seçin';

  @override
  String get language_change_tooltip => 'Dili değiştir';

  @override
  String get configTitle => 'Yapılandırma';

  @override
  String get configSelectRoots => 'Akorları seç';

  @override
  String get configSelectChordTypes => 'Akor türlerini seç';

  @override
  String get configSelectInversions => 'Çevrimleri seç';

  @override
  String get configEnableTimer => 'Zamanlayıcıyı etkinleştir';

  @override
  String get configTimerSeconds => 'Zamanlayıcı (saniye)';

  @override
  String get saveButton => 'Kaydet';

  @override
  String get configListener => 'Dinlemek ve Doğru olarak işaretlemek için mikrofonu etkinleştir';

  @override
  String get configIncorrect => 'Zamanlayıcı başladıktan sonra çalınan ilk akor değilse akoru Yanlış olarak işaretle';

  @override
  String get configAtLeastOneOption => 'Bu bölümde en az bir seçenek seçilmelidir. Son seçenek yeniden seçildi. Lütfen tekrar deneyin.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Dinleme Modunu Etkinleştir (Gelecek Özellik)';

  @override
  String get configEnableListeningDesc => 'Ses algılama eşleştiğinde akoru otomatik olarak doğru işaretle.';

  @override
  String get chord_major => 'Majör';

  @override
  String get chord_minor => 'Minör';

  @override
  String get chord_diminished => 'Eksik';

  @override
  String get chord_dominant7 => 'Dominant 7’li';

  @override
  String get chord_major7 => 'Majör 7’li';

  @override
  String get chord_minor7 => 'Minör 7’li';

  @override
  String get chord_suspended2 => 'Asılı 2';

  @override
  String get chord_suspended4 => 'Asılı 4';

  @override
  String get chord_augmented => 'Artırılmış';

  @override
  String get inv_root => 'Kök pozisyon';

  @override
  String get inv_first => '1. çevrim';

  @override
  String get inv_second => '2. çevrim';

  @override
  String get configCardOrder => 'Kart sırası';

  @override
  String get configCardOrderRandom => 'Rastgele';

  @override
  String get configCardOrderSorted => 'Sıralı';

  @override
  String get flash_incorrectCountLabel => 'Yanlış';

  @override
  String get flash_correctCountLabel => 'Doğru';

  @override
  String get flash_playingMainDeck => 'Ana deste oynanıyor';

  @override
  String get flash_playingErrorDeck => 'Hata destesi oynanıyor';

  @override
  String get flash_redoButton => 'TEKRAR';

  @override
  String get flash_playedLabel => 'oynandı';

  @override
  String get flash_toGoLabel => 'kaldı';

  @override
  String get flash_averageTimeLabel => 'Ortalama Süre:';

  @override
  String get flash_timeLabel => 'Zamanlayıcı';

  @override
  String get flash_timerCancelled => 'Zamanlayıcı iptal edildi';

  @override
  String get flash_reveal => 'Akoru Göster';

  @override
  String get flash_play_instruction => 'Aşağıdaki akoru çalın\nana desteden rastgele seçildi';

  @override
  String get flash_swipe_right => 'Doğru çaldıysanız sağa kaydırın';

  @override
  String get flash_swipe_left => 'Yanlış çaldıysanız sola kaydırın';

  @override
  String get flash_not_sure => 'Emin değil misiniz? Parmaklamayı görmek için karta dokunun';

  @override
  String get flash_welcome1 => 'Burada bir akor adı görünecek';

  @override
  String get flash_welcome2 => 'Piyanonuzda çalın';

  @override
  String get flash_incorrect_count => 'Yanlış sayısı';

  @override
  String get flash_correct_count => 'Doğru sayısı';

  @override
  String get flash_playing_main => 'Ana deste oynanıyor';

  @override
  String get flash_playing_wrong => 'Hatalar oynanıyor';

  @override
  String get flash_play_again => 'Tekrar oyna';

  @override
  String get flash_average_time => 'Ortalama süre';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played oynandı, $remaining kaldı';
  }

  @override
  String get flash_mainDeck => 'Ana Deste';

  @override
  String get flash_errorDeck => 'Hata Destesi';

  @override
  String get flash_correct => 'Doğru';

  @override
  String get flash_incorrect => 'Yanlış';

  @override
  String get flash_of => '/';

  @override
  String get flash_next => 'Sonraki';

  @override
  String get summary_title => 'Özet';

  @override
  String get summary_correct => 'Doğru';

  @override
  String get summary_incorrect => 'Yanlış';

  @override
  String get summary_cards => 'Kartlar';

  @override
  String get summary_average_time => 'Ortalama Süre';

  @override
  String get summary_seconds => 'saniye';

  @override
  String get summary_from_main_deck => 'Ana deste';

  @override
  String get summary_from_error_deck => 'Hata destesi';

  @override
  String get summary_play_again => 'Tekrar oyna';

  @override
  String get summary_done => 'Bitti';

  @override
  String get summary_accuracy => 'Doğruluk';

  @override
  String get summary_average_time_correct => 'Ortalama (doğru akorlar)';

  @override
  String get summary_average_time_all => 'Ortalama süre (tüm akorlar)';

  @override
  String get summary_unsaved_changes_title => 'Değişikliklerinizi kaydetmediniz';

  @override
  String get summary_unsaved_changes_body => 'Yapılandırmada bir değişiklik yaptınız. Kaydetmek istiyorsanız şimdi İPTAL’e basın, ardından KAYDET’e basın.';

  @override
  String get summary_discard => 'Değişiklikleri at';

  @override
  String get cancel => 'İptal';

  @override
  String get listeningActive => 'Dinleniyor…';

  @override
  String get listeningInactive => 'Dinleme duraklatıldı';

  @override
  String get flash_error_101 => 'Ses girişi izinli değil.';

  @override
  String get flash_error_101_hint => 'FlashChords mikrofon erişim iznine sahip değil. Lütfen cihaz ayarlarında mikrofon erişimini etkinleştirin ve uygulamayı yeniden başlatın.';

  @override
  String get flash_error_102 => 'Ses dinleme başlatılamadı.';

  @override
  String get flash_error_102_hint => 'FlashChords ses sistemini başlatamadı. Başka bir uygulamanın mikrofonu kullanmadığından emin olun ve uygulamayı yeniden başlatın.';

  @override
  String get flash_error_103 => 'Ses girişi kesildi.';

  @override
  String get flash_error_103_hint => 'Dinleme bir ses kesintisi nedeniyle durdu. Mikrofon bağlantınızı kontrol edin ve dinlemeyi yeniden başlatın.';

  @override
  String get flash_error_201 => 'Dahili bir hata oluştu.';

  @override
  String get flash_error_201_hint => 'FlashChords beklenmeyen bir hatayla karşılaştı. Lütfen uygulamayı yeniden başlatın. Sorun devam ederse, bu hata koduyla destekle iletişime geçin.';

  @override
  String get flash_error_301 => 'En az bir değer seçilmelidir.';

  @override
  String get flash_error_301_hint => 'Son seçiminiz, bir değer seçili kalmasını sağlamak için yeniden seçildi. Seçimi kaldırmak için önce başka bir değer seçin.';

  @override
  String get language_picker_scroll_hint => 'Daha fazla dili görmek için kaydırın';
}
