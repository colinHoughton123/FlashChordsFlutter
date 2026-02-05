// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get welcomeTitle => 'FlashChords में आपका स्वागत है';

  @override
  String get welcomeUpdate_Update => 'अपडेट उपलब्ध है';

  @override
  String get welcomeUpdate_Button_Later => 'बाद में';

  @override
  String get welcomeUpdate_Button_Update => 'अपडेट करें';

  @override
  String get listenerLimitReachedTitle => 'सुनने की सुविधा बंद है';

  @override
  String listenerLimitReachedBody(Object limit) {
    return '$limit मुफ्त कार्ड खेलने के बाद सुनने की सुविधा बंद कर दी गई है। फिर से सक्षम करने के लिए अपग्रेड करें।';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'मुफ्त संस्करण: $limit में से $played सुनने-सक्षम कार्ड उपयोग किए गए';
  }

  @override
  String get listenerLimitDialogTitle => 'मुफ्त सीमा पूरी हो गई';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords काम करता रहेगा, लेकिन जब तक आप $price में अपग्रेड नहीं करते, सुनने की सुविधा बंद रहेगी।';
  }

  @override
  String get upgrade => 'अपग्रेड करें';

  @override
  String get later => 'बाद में';

  @override
  String get listenerInversionNoticeTitle => 'सुनने संबंधी नोट';

  @override
  String get listenerInversionNoticePart1 => 'आपने एक से अधिक इन्वर्ज़न चुना है। ध्यान दें कि FlashChords इन्वर्ज़न के बीच का अंतर “सुन” नहीं सकता। अपेक्षित की-पैटर्न दिखाए जाएंगे, लेकिन गलत इन्वर्ज़न में बजाया गया कॉर्ड ';

  @override
  String get listenerInversionNoticeAny => '“सही”';

  @override
  String get listenerInversionNoticePart2 => ' के रूप में चिह्नित होगा।';

  @override
  String get listenerInversionNoticeDontShow => 'दोबारा न दिखाएँ';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'कॉर्ड लोड हो रहे हैं...';

  @override
  String get start => 'शुरू करें';

  @override
  String get configure => 'कॉन्फ़िगर करें';

  @override
  String get mainCatchPhrase => 'कॉर्ड्स को तुरंत सीखें!';

  @override
  String get mainFeaturesTitle => 'विशेषताएँ';

  @override
  String get mainFeatures1Title => 'अपने कॉर्ड चुनें';

  @override
  String get mainFeatures1Content => 'किस कॉर्ड पर ध्यान देना है, यह कॉन्फ़िगर करें';

  @override
  String get mainFeatures2Title => 'समयबद्ध चुनौतियाँ';

  @override
  String get mainFeatures2Content => 'कस्टम टाइमर के साथ खुद को परखें';

  @override
  String get mainFeatures3Title => 'स्वचालित मूल्यांकन';

  @override
  String get mainFeatures3Content => 'FlashChords को आपके पियानो को सुनने दें';

  @override
  String get language_picker_title => 'भाषा चुनें';

  @override
  String get language_change_tooltip => 'भाषा बदलें';

  @override
  String get configTitle => 'कॉन्फ़िगरेशन';

  @override
  String get configSelectRoots => 'कॉर्ड चुनें';

  @override
  String get configSelectChordTypes => 'कॉर्ड प्रकार चुनें';

  @override
  String get configSelectInversions => 'इन्वर्ज़न चुनें';

  @override
  String get configEnableTimer => 'टाइमर सक्षम करें';

  @override
  String get configTimerSeconds => 'टाइमर (सेकंड)';

  @override
  String get saveButton => 'सहेजें';

  @override
  String get configListener => 'सुनने और सही चिह्नित करने के लिए माइक्रोफ़ोन सक्षम करें';

  @override
  String get configIncorrect => 'यदि टाइमर शुरू होने के बाद यह पहला कॉर्ड नहीं है, तो इसे गलत चिह्नित करें';

  @override
  String get configAtLeastOneOption => 'इस अनुभाग में कम से कम एक विकल्प चुनना आवश्यक है। अंतिम विकल्प फिर से चुना गया है। कृपया पुनः प्रयास करें।';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'सुनने का मोड सक्षम करें (भविष्य की सुविधा)';

  @override
  String get configEnableListeningDesc => 'जब ऑडियो पहचान मेल खाए, तो कॉर्ड को स्वतः सही चिह्नित करें।';

  @override
  String get chord_major => 'मेजर';

  @override
  String get chord_minor => 'माइनर';

  @override
  String get chord_diminished => 'डिमिनिश्ड';

  @override
  String get chord_dominant7 => 'डॉमिनेंट 7th';

  @override
  String get chord_major7 => 'मेजर 7th';

  @override
  String get chord_minor7 => 'माइनर 7th';

  @override
  String get chord_suspended2 => 'सस्पेंडेड 2';

  @override
  String get chord_suspended4 => 'सस्पेंडेड 4';

  @override
  String get chord_augmented => 'ऑगमेंटेड';

  @override
  String get inv_root => 'रूट पोज़िशन';

  @override
  String get inv_first => '1st इन्वर्ज़न';

  @override
  String get inv_second => '2nd इन्वर्ज़न';

  @override
  String get configCardOrder => 'कार्ड क्रम';

  @override
  String get configCardOrderRandom => 'रैंडम';

  @override
  String get configCardOrderSorted => 'सॉर्टेड';

  @override
  String get flash_incorrectCountLabel => 'गलत';

  @override
  String get flash_correctCountLabel => 'सही';

  @override
  String get flash_playingMainDeck => 'मुख्य डेक खेला जा रहा है';

  @override
  String get flash_playingErrorDeck => 'त्रुटि डेक खेला जा रहा है';

  @override
  String get flash_redoButton => 'दोहराएँ';

  @override
  String get flash_playedLabel => 'खेले गए';

  @override
  String get flash_toGoLabel => 'बाकी';

  @override
  String get flash_averageTimeLabel => 'औसत समय:';

  @override
  String get flash_timeLabel => 'टाइमर';

  @override
  String get flash_timerCancelled => 'टाइमर रद्द किया गया';

  @override
  String get flash_reveal => 'कॉर्ड दिखाएँ';

  @override
  String get flash_play_instruction => 'निम्नलिखित कॉर्ड बजाएँ\nमुख्य डेक से रैंडम चुना गया';

  @override
  String get flash_swipe_right => 'यदि सही बजाया तो दाएँ स्वाइप करें';

  @override
  String get flash_swipe_left => 'यदि गलत बजाया तो बाएँ स्वाइप करें';

  @override
  String get flash_not_sure => 'सुनिश्चित नहीं? उंगली स्थिति देखने के लिए कार्ड टैप करें';

  @override
  String get flash_welcome1 => 'यहाँ कॉर्ड का नाम दिखेगा';

  @override
  String get flash_welcome2 => 'इसे अपने पियानो पर बजाएँ';

  @override
  String get flash_incorrect_count => 'गलत गिनती';

  @override
  String get flash_correct_count => 'सही गिनती';

  @override
  String get flash_playing_main => 'मुख्य डेक खेला जा रहा है';

  @override
  String get flash_playing_wrong => 'त्रुटियाँ खेली जा रही हैं';

  @override
  String get flash_play_again => 'फिर से खेलें';

  @override
  String get flash_average_time => 'औसत समय';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played खेले गए, $remaining बाकी';
  }

  @override
  String get flash_mainDeck => 'मुख्य डेक';

  @override
  String get flash_errorDeck => 'त्रुटि डेक';

  @override
  String get flash_correct => 'सही';

  @override
  String get flash_incorrect => 'गलत';

  @override
  String get flash_of => 'में से';

  @override
  String get flash_next => 'अगला';

  @override
  String get summary_title => 'सारांश';

  @override
  String get summary_correct => 'सही';

  @override
  String get summary_incorrect => 'गलत';

  @override
  String get summary_cards => 'कार्ड';

  @override
  String get summary_average_time => 'औसत समय';

  @override
  String get summary_seconds => 'सेकंड';

  @override
  String get summary_from_main_deck => 'मुख्य डेक';

  @override
  String get summary_from_error_deck => 'त्रुटि डेक';

  @override
  String get summary_play_again => 'फिर से खेलें';

  @override
  String get summary_done => 'समाप्त';

  @override
  String get summary_accuracy => 'सटीकता';

  @override
  String get summary_average_time_correct => 'औसत (सही कॉर्ड)';

  @override
  String get summary_average_time_all => 'औसत समय (सभी कॉर्ड)';

  @override
  String get summary_unsaved_changes_title => 'आपने अपने बदलाव सहेजे नहीं हैं';

  @override
  String get summary_unsaved_changes_body => 'आपने कॉन्फ़िगरेशन में बदलाव किया है। यदि आप सहेजना चाहते हैं, तो अभी CANCEL दबाएँ, फिर SAVE दबाएँ।';

  @override
  String get summary_discard => 'बदलाव हटाएँ';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get listeningActive => 'सुन रहा है…';

  @override
  String get listeningInactive => 'सुनना रुका हुआ है';

  @override
  String get flash_error_101 => 'ऑडियो इनपुट की अनुमति नहीं है।';

  @override
  String get flash_error_101_hint => 'FlashChords को माइक्रोफ़ोन तक पहुँच की अनुमति नहीं है। कृपया अपने डिवाइस सेटिंग्स में माइक्रोफ़ोन अनुमति सक्षम करें और ऐप को पुनः शुरू करें।';

  @override
  String get flash_error_102 => 'ऑडियो सुनना शुरू नहीं हो सका।';

  @override
  String get flash_error_102_hint => 'FlashChords ऑडियो सिस्टम प्रारंभ नहीं कर सका। कृपया सुनिश्चित करें कि कोई अन्य ऐप माइक्रोफ़ोन का उपयोग नहीं कर रहा है और ऐप को पुनः शुरू करें।';

  @override
  String get flash_error_103 => 'ऑडियो इनपुट बाधित हुआ।';

  @override
  String get flash_error_103_hint => 'ऑडियो बाधा के कारण सुनना बंद हो गया। कृपया माइक्रोफ़ोन कनेक्शन जाँचें और सुनना पुनः शुरू करें।';

  @override
  String get flash_error_201 => 'एक आंतरिक त्रुटि हुई।';

  @override
  String get flash_error_201_hint => 'FlashChords को एक अप्रत्याशित त्रुटि मिली। कृपया ऐप पुनः शुरू करें। यदि समस्या बनी रहे, तो इस त्रुटि कोड के साथ सहायता से संपर्क करें।';

  @override
  String get flash_error_301 => 'कम से कम एक मान चुनना आवश्यक है।';

  @override
  String get flash_error_301_hint => 'आपका अंतिम चयन हटाने पर इसे फिर से चुना गया है ताकि कम से कम एक मान चुना रहे। इसे हटाने के लिए पहले कोई अन्य मान चुनें।';

  @override
  String get language_picker_scroll_hint => 'और भाषाएँ देखने के लिए स्क्रॉल करें';
}
