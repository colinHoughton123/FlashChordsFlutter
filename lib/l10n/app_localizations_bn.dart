// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get welcomeTitle => 'FlashChords-এ স্বাগতম';

  @override
  String get welcomeUpdate_Update => 'আপডেট উপলব্ধ';

  @override
  String get welcomeUpdate_Button_Later => 'পরে';

  @override
  String get welcomeUpdate_Button_Update => 'আপডেট করুন';

  @override
  String get listenerLimitReachedTitle => 'শোনার সুবিধা নিষ্ক্রিয়';

  @override
  String listenerLimitReachedBody(Object limit) {
    return '$limitটি বিনামূল্যের কার্ড খেলার পর শোনার সুবিধা নিষ্ক্রিয় করা হয়েছে। পুনরায় চালু করতে আপগ্রেড করুন।';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'বিনামূল্যের সংস্করণ: $limitটির মধ্যে $playedটি শোনার সুবিধাযুক্ত কার্ড ব্যবহার করা হয়েছে';
  }

  @override
  String get listenerLimitDialogTitle => 'বিনামূল্যের সীমা পূর্ণ হয়েছে';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords কাজ চালিয়ে যাবে, কিন্তু আপনি $price দিয়ে আপগ্রেড না করলে শোনার সুবিধা নিষ্ক্রিয় থাকবে।';
  }

  @override
  String get upgrade => 'আপগ্রেড করুন';

  @override
  String get later => 'পরে';

  @override
  String get listenerInversionNoticeTitle => 'শোনার নোট';

  @override
  String get listenerInversionNoticePart1 => 'আপনি একাধিক ইনভার্সন নির্বাচন করেছেন। মনে রাখবেন FlashChords ইনভার্সনের পার্থক্য “শুনতে” পারে না। প্রত্যাশিত কী-প্যাটার্ন দেখানো হবে, কিন্তু ভুল ইনভার্সনে বাজানো কর্ডকে ';

  @override
  String get listenerInversionNoticeAny => '“সঠিক”';

  @override
  String get listenerInversionNoticePart2 => ' হিসেবে চিহ্নিত করা হবে।';

  @override
  String get listenerInversionNoticeDontShow => 'আর দেখাবেন না';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'কর্ড লোড হচ্ছে...';

  @override
  String get start => 'শুরু';

  @override
  String get configure => 'কনফিগার করুন';

  @override
  String get mainCatchPhrase => 'এক ঝলকে কর্ড শিখুন!';

  @override
  String get mainFeaturesTitle => 'বৈশিষ্ট্যসমূহ';

  @override
  String get mainFeatures1Title => 'আপনার কর্ড নির্বাচন করুন';

  @override
  String get mainFeatures1Content => 'কোন কর্ডে মনোযোগ দেবেন তা কনফিগার করুন';

  @override
  String get mainFeatures2Title => 'সময় নির্ধারিত চ্যালেঞ্জ';

  @override
  String get mainFeatures2Content => 'কাস্টম টাইমার দিয়ে নিজেকে পরীক্ষা করুন';

  @override
  String get mainFeatures3Title => 'স্বয়ংক্রিয় মূল্যায়ন';

  @override
  String get mainFeatures3Content => 'FlashChords-কে আপনার পিয়ানো শুনতে দিন';

  @override
  String get language_picker_title => 'ভাষা নির্বাচন করুন';

  @override
  String get language_change_tooltip => 'ভাষা পরিবর্তন করুন';

  @override
  String get configTitle => 'কনফিগারেশন';

  @override
  String get configSelectRoots => 'কর্ড নির্বাচন করুন';

  @override
  String get configSelectChordTypes => 'কর্ডের ধরন নির্বাচন করুন';

  @override
  String get configSelectInversions => 'ইনভার্সন নির্বাচন করুন';

  @override
  String get configEnableTimer => 'টাইমার চালু করুন';

  @override
  String get configTimerSeconds => 'টাইমার (সেকেন্ড)';

  @override
  String get saveButton => 'সংরক্ষণ করুন';

  @override
  String get configListener => 'শোনার এবং সঠিক হিসেবে চিহ্নিত করতে মাইক্রোফোন চালু করুন';

  @override
  String get configIncorrect => 'টাইমার শুরু হওয়ার পর প্রথম কর্ড না হলে এটিকে ভুল হিসেবে চিহ্নিত করুন';

  @override
  String get configAtLeastOneOption => 'এই অংশে অন্তত একটি অপশন নির্বাচন করতে হবে। শেষ অপশনটি আবার নির্বাচন করা হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'শোনার মোড চালু করুন (ভবিষ্যৎ বৈশিষ্ট্য)';

  @override
  String get configEnableListeningDesc => 'অডিও শনাক্তকরণ মিলে গেলে কর্ডকে স্বয়ংক্রিয়ভাবে সঠিক হিসেবে চিহ্নিত করুন।';

  @override
  String get chord_major => 'মেজর';

  @override
  String get chord_minor => 'মাইনর';

  @override
  String get chord_diminished => 'ডিমিনিশড';

  @override
  String get chord_dominant7 => 'ডমিন্যান্ট ৭ম';

  @override
  String get chord_major7 => 'মেজর ৭ম';

  @override
  String get chord_minor7 => 'মাইনর ৭ম';

  @override
  String get chord_suspended2 => 'সাসপেন্ডেড ২';

  @override
  String get chord_suspended4 => 'সাসপেন্ডেড ৪';

  @override
  String get chord_augmented => 'অগমেন্টেড';

  @override
  String get inv_root => 'রুট অবস্থান';

  @override
  String get inv_first => '১ম ইনভার্সন';

  @override
  String get inv_second => '২য় ইনভার্সন';

  @override
  String get configCardOrder => 'কার্ডের ক্রম';

  @override
  String get configCardOrderRandom => 'এলোমেলো';

  @override
  String get configCardOrderSorted => 'সাজানো';

  @override
  String get flash_incorrectCountLabel => 'ভুল';

  @override
  String get flash_correctCountLabel => 'সঠিক';

  @override
  String get flash_playingMainDeck => 'মূল ডেক চালানো হচ্ছে';

  @override
  String get flash_playingErrorDeck => 'ত্রুটি ডেক চালানো হচ্ছে';

  @override
  String get flash_redoButton => 'আবার করুন';

  @override
  String get flash_playedLabel => 'খেলা হয়েছে';

  @override
  String get flash_toGoLabel => 'বাকি';

  @override
  String get flash_averageTimeLabel => 'গড় সময়:';

  @override
  String get flash_timeLabel => 'টাইমার';

  @override
  String get flash_timerCancelled => 'টাইমার বাতিল হয়েছে';

  @override
  String get flash_reveal => 'কর্ড দেখান';

  @override
  String get flash_play_instruction => 'নিচের কর্ডটি বাজান\nমূল ডেক থেকে এলোমেলোভাবে নির্বাচিত';

  @override
  String get flash_swipe_right => 'সঠিক বাজালে ডানদিকে সোয়াইপ করুন';

  @override
  String get flash_swipe_left => 'ভুল বাজালে বামদিকে সোয়াইপ করুন';

  @override
  String get flash_not_sure => 'নিশ্চিত নন? আঙুলের অবস্থান দেখতে কার্ডে ট্যাপ করুন';

  @override
  String get flash_welcome1 => 'এখানে কর্ডের নাম দেখানো হবে';

  @override
  String get flash_welcome2 => 'আপনার পিয়ানোতে বাজান';

  @override
  String get flash_incorrect_count => 'ভুল সংখ্যা';

  @override
  String get flash_correct_count => 'সঠিক সংখ্যা';

  @override
  String get flash_playing_main => 'মূল ডেক চালানো হচ্ছে';

  @override
  String get flash_playing_wrong => 'ত্রুটিগুলো চালানো হচ্ছে';

  @override
  String get flash_play_again => 'আবার খেলুন';

  @override
  String get flash_average_time => 'গড় সময়';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played খেলা হয়েছে, $remaining বাকি';
  }

  @override
  String get flash_mainDeck => 'মূল ডেক';

  @override
  String get flash_errorDeck => 'ত্রুটি ডেক';

  @override
  String get flash_correct => 'সঠিক';

  @override
  String get flash_incorrect => 'ভুল';

  @override
  String get flash_of => 'এর মধ্যে';

  @override
  String get flash_next => 'পরবর্তী';

  @override
  String get summary_title => 'সারসংক্ষেপ';

  @override
  String get summary_correct => 'সঠিক';

  @override
  String get summary_incorrect => 'ভুল';

  @override
  String get summary_cards => 'কার্ডসমূহ';

  @override
  String get summary_average_time => 'গড় সময়';

  @override
  String get summary_seconds => 'সেকেন্ড';

  @override
  String get summary_from_main_deck => 'মূল ডেক';

  @override
  String get summary_from_error_deck => 'ত্রুটি ডেক';

  @override
  String get summary_play_again => 'আবার খেলুন';

  @override
  String get summary_done => 'শেষ';

  @override
  String get summary_accuracy => 'নির্ভুলতা';

  @override
  String get summary_average_time_correct => 'গড় (সঠিক কর্ড)';

  @override
  String get summary_average_time_all => 'গড় সময় (সব কর্ড)';

  @override
  String get summary_unsaved_changes_title => 'আপনি আপনার পরিবর্তন সংরক্ষণ করেননি';

  @override
  String get summary_unsaved_changes_body => 'আপনি কনফিগারেশনে একটি পরিবর্তন করেছেন। সংরক্ষণ করতে চাইলে এখন CANCEL চাপুন, তারপর SAVE চাপুন।';

  @override
  String get summary_discard => 'পরিবর্তন বাতিল করুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get listeningActive => 'শোনা হচ্ছে…';

  @override
  String get listeningInactive => 'শোনা স্থগিত';

  @override
  String get flash_error_101 => 'অডিও ইনপুট অনুমোদিত নয়।';

  @override
  String get flash_error_101_hint => 'FlashChords-এর মাইক্রোফোন ব্যবহারের অনুমতি নেই। ডিভাইস সেটিংসে মাইক্রোফোন অ্যাক্সেস চালু করুন এবং অ্যাপটি পুনরায় চালু করুন।';

  @override
  String get flash_error_102 => 'অডিও শোনা শুরু করা যায়নি।';

  @override
  String get flash_error_102_hint => 'FlashChords অডিও সিস্টেম চালু করতে পারেনি। অন্য কোনো অ্যাপ মাইক্রোফোন ব্যবহার করছে কিনা পরীক্ষা করুন এবং অ্যাপটি পুনরায় চালু করুন।';

  @override
  String get flash_error_103 => 'অডিও ইনপুট বাধাগ্রস্ত হয়েছে।';

  @override
  String get flash_error_103_hint => 'অডিও বাধার কারণে শোনা বন্ধ হয়েছে। মাইক্রোফোন সংযোগ পরীক্ষা করুন এবং আবার শোনা শুরু করুন।';

  @override
  String get flash_error_201 => 'একটি অভ্যন্তরীণ ত্রুটি ঘটেছে।';

  @override
  String get flash_error_201_hint => 'FlashChords একটি অপ্রত্যাশিত ত্রুটির সম্মুখীন হয়েছে। অ্যাপটি পুনরায় চালু করুন। সমস্যা থাকলে এই ত্রুটি কোডসহ সহায়তায় যোগাযোগ করুন।';

  @override
  String get flash_error_301 => 'কমপক্ষে একটি মান নির্বাচন করতে হবে।';

  @override
  String get flash_error_301_hint => 'আপনার শেষ নির্বাচনটি আবার নির্বাচন করা হয়েছে যাতে অন্তত একটি মান নির্বাচিত থাকে। এটি বাতিল করতে আগে অন্য একটি মান নির্বাচন করুন।';

  @override
  String get language_picker_scroll_hint => 'আরও ভাষা দেখতে স্ক্রোল করুন';
}
