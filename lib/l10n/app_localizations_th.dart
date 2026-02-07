// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get welcomeTitle => 'ยินดีต้อนรับสู่ FlashChords';

  @override
  String get welcomeUpdate_Update => 'มีอัปเดตใหม่';

  @override
  String get welcomeUpdate_Button_Later => 'ภายหลัง';

  @override
  String get welcomeUpdate_Button_Update => 'อัปเดต';

  @override
  String get listenerLimitReachedTitle => 'ปิดการฟังแล้ว';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'ระบบการฟังถูกปิดหลังจากเล่นการ์ดฟรี $limit ใบ โปรดอัปเกรดเพื่อเปิดใช้งานอีกครั้ง';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'เวอร์ชันฟรี: ใช้การ์ดที่รองรับการฟังไปแล้ว $played จาก $limit ใบ';
  }

  @override
  String get listenerLimitDialogTitle => 'ถึงขีดจำกัดฟรีแล้ว';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords จะยังทำงานต่อไป แต่ระบบการฟังจะถูกปิด เว้นแต่คุณจะอัปเกรดในราคา $price';
  }

  @override
  String get upgrade => 'อัปเกรด';

  @override
  String get later => 'ภายหลัง';

  @override
  String get listenerInversionNoticeTitle => 'หมายเหตุการฟัง';

  @override
  String get listenerInversionNoticePart1 => 'คุณเลือกอินเวอร์ชันมากกว่าหนึ่งแบบ โปรดทราบว่า FlashChords ไม่สามารถ “ได้ยิน” ความแตกต่างระหว่างอินเวอร์ชันได้ รูปแบบคีย์ที่คาดไว้จะแสดง แต่คอร์ดที่เล่นด้วยอินเวอร์ชันผิดจะถูกทำเครื่องหมายว่า ';

  @override
  String get listenerInversionNoticeAny => '“ถูกต้อง”';

  @override
  String get listenerInversionNoticePart2 => '。';

  @override
  String get listenerInversionNoticeDontShow => 'ไม่ต้องแสดงอีก';

  @override
  String get listenerInversionNoticeGotIt => 'ตกลง';

  @override
  String get loadingChords => 'กำลังโหลดคอร์ด...';

  @override
  String get start => 'เริ่ม';

  @override
  String get configure => 'ตั้งค่า';

  @override
  String get mainCatchPhrase => 'เรียนรู้คอร์ดได้ในพริบตา!';

  @override
  String get mainFeaturesTitle => 'คุณสมบัติ';

  @override
  String get mainFeatures1Title => 'เลือกคอร์ดของคุณ';

  @override
  String get mainFeatures1Content => 'เลือกคอร์ดที่ต้องการฝึก';

  @override
  String get mainFeatures2Title => 'ความท้าทายแบบจับเวลา';

  @override
  String get mainFeatures2Content => 'ทดสอบเวลาในการตอบสนองด้วยตัวจับเวลาที่ปรับแต่งได้';

  @override
  String get mainFeatures3Title => 'โหมดฟังสด';

  @override
  String get mainFeatures3Content => 'คอร์ดจะถูกตรวจจับและให้คะแนนโดยอัตโนมัติ';

  @override
  String get language_picker_title => 'เลือกภาษา';

  @override
  String get language_change_tooltip => 'เปลี่ยนภาษา';

  @override
  String get configTitle => 'การตั้งค่า';

  @override
  String get configSelectRoots => 'เลือกคอร์ด';

  @override
  String get configSelectChordTypes => 'เลือกประเภทคอร์ด';

  @override
  String get configSelectInversions => 'เลือกอินเวอร์ชัน';

  @override
  String get configEnableTimer => 'เปิดใช้งานตัวจับเวลา';

  @override
  String get configTimerSeconds => 'ตัวจับเวลา (วินาที)';

  @override
  String get saveButton => 'บันทึก';

  @override
  String get configListener => 'เปิดไมโครโฟนเพื่อฟังและทำเครื่องหมายว่าถูกต้อง';

  @override
  String get configIncorrect => 'ทำเครื่องหมายคอร์ดว่าไม่ถูกต้อง หากไม่ใช่คอร์ดแรกที่เล่นหลังเริ่มจับเวลา';

  @override
  String get configAtLeastOneOption => 'ต้องเลือกอย่างน้อยหนึ่งตัวเลือกในส่วนนี้ ระบบได้เลือกตัวเลือกสุดท้ายกลับมาแล้ว โปรดลองอีกครั้ง';

  @override
  String get configOK => 'ตกลง';

  @override
  String get configEnableListening => 'เปิดโหมดการฟัง (ฟีเจอร์ในอนาคต)';

  @override
  String get configEnableListeningDesc => 'ทำเครื่องหมายคอร์ดว่าถูกต้องโดยอัตโนมัติเมื่อการตรวจจับเสียงตรงกัน';

  @override
  String get chord_major => 'เมเจอร์';

  @override
  String get chord_minor => 'ไมเนอร์';

  @override
  String get chord_diminished => 'ดิมินิชด์';

  @override
  String get chord_dominant7 => 'โดมิแนนท์ 7th';

  @override
  String get chord_major7 => 'เมเจอร์ 7th';

  @override
  String get chord_minor7 => 'ไมเนอร์ 7th';

  @override
  String get chord_suspended2 => 'ซัสเพนเด็ด 2';

  @override
  String get chord_suspended4 => 'ซัสเพนเด็ด 4';

  @override
  String get chord_augmented => 'ออคเมนเต็ด';

  @override
  String get inv_root => 'ตำแหน่งราก';

  @override
  String get inv_first => 'อินเวอร์ชันที่ 1';

  @override
  String get inv_second => 'อินเวอร์ชันที่ 2';

  @override
  String get configCardOrder => 'ลำดับการ์ด';

  @override
  String get configCardOrderRandom => 'สุ่ม';

  @override
  String get configCardOrderSorted => 'เรียงลำดับ';

  @override
  String get flash_incorrectCountLabel => 'ไม่ถูกต้อง';

  @override
  String get flash_correctCountLabel => 'ถูกต้อง';

  @override
  String get flash_playingMainDeck => 'กำลังเล่นเด็คหลัก';

  @override
  String get flash_playingErrorDeck => 'กำลังเล่นเด็คข้อผิดพลาด';

  @override
  String get flash_redoButton => 'ทำใหม่';

  @override
  String get flash_playedLabel => 'เล่นแล้ว';

  @override
  String get flash_toGoLabel => 'เหลือ';

  @override
  String get flash_averageTimeLabel => 'เวลาเฉลี่ย:';

  @override
  String get flash_timeLabel => 'ตัวจับเวลา';

  @override
  String get flash_timerCancelled => 'ยกเลิกตัวจับเวลาแล้ว';

  @override
  String get flash_reveal => 'แสดงคอร์ด';

  @override
  String get flash_play_instruction => 'เล่นคอร์ดต่อไปนี้\nสุ่มจากเด็คหลัก';

  @override
  String get flash_swipe_right => 'ปัดขวาหากคุณเล่นถูกต้อง';

  @override
  String get flash_swipe_left => 'ปัดซ้ายหากคุณเล่นไม่ถูกต้อง';

  @override
  String get flash_not_sure => 'ไม่แน่ใจ? แตะการ์ดเพื่อดูตำแหน่งนิ้ว';

  @override
  String get flash_welcome1 => 'ชื่อคอร์ดจะแสดงที่นี่';

  @override
  String get flash_welcome2 => 'เล่นบนเปียโนของคุณ';

  @override
  String get flash_incorrect_count => 'จำนวนที่ผิด';

  @override
  String get flash_correct_count => 'จำนวนที่ถูก';

  @override
  String get flash_playing_main => 'กำลังเล่นเด็คหลัก';

  @override
  String get flash_playing_wrong => 'กำลังเล่นข้อผิดพลาด';

  @override
  String get flash_play_again => 'เล่นอีกครั้ง';

  @override
  String get flash_average_time => 'เวลาเฉลี่ย';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return 'เล่นแล้ว $played เหลือ $remaining';
  }

  @override
  String get flash_mainDeck => 'เด็คหลัก';

  @override
  String get flash_errorDeck => 'เด็คข้อผิดพลาด';

  @override
  String get flash_correct => 'ถูกต้อง';

  @override
  String get flash_incorrect => 'ไม่ถูกต้อง';

  @override
  String get flash_of => 'จาก';

  @override
  String get flash_next => 'ถัดไป';

  @override
  String get summary_title => 'สรุป';

  @override
  String get summary_correct => 'ถูกต้อง';

  @override
  String get summary_incorrect => 'ไม่ถูกต้อง';

  @override
  String get summary_cards => 'การ์ด';

  @override
  String get summary_average_time => 'เวลาเฉลี่ย';

  @override
  String get summary_seconds => 'วินาที';

  @override
  String get summary_from_main_deck => 'เด็คหลัก';

  @override
  String get summary_from_error_deck => 'เด็คข้อผิดพลาด';

  @override
  String get summary_play_again => 'เล่นอีกครั้งด้วยสำรับข้อผิดพลาด';

  @override
  String get summary_done => 'เริ่มใหม่';

  @override
  String get summary_accuracy => 'ความแม่นยำ';

  @override
  String get summary_average_time_correct => 'ค่าเฉลี่ย (คอร์ดที่ถูกต้อง)';

  @override
  String get summary_average_time_all => 'เวลาเฉลี่ย (ทุกคอร์ด)';

  @override
  String get summary_unsaved_changes_title => 'คุณยังไม่ได้บันทึกการเปลี่ยนแปลง';

  @override
  String get summary_unsaved_changes_body => 'คุณได้เปลี่ยนการตั้งค่า หากต้องการบันทึก ให้กด CANCEL ตอนนี้ แล้วกด SAVE';

  @override
  String get summary_discard => 'ละทิ้งการเปลี่ยนแปลง';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get listeningActive => 'กำลังฟัง…';

  @override
  String get listeningInactive => 'หยุดฟังชั่วคราว';

  @override
  String get flash_error_101 => 'ไม่อนุญาตให้ใช้อินพุตเสียง';

  @override
  String get flash_error_101_hint => 'FlashChords ไม่มีสิทธิ์เข้าถึงไมโครโฟน โปรดเปิดสิทธิ์ไมโครโฟนในการตั้งค่าอุปกรณ์และรีสตาร์ทแอป';

  @override
  String get flash_error_102 => 'ไม่สามารถเริ่มการฟังเสียงได้';

  @override
  String get flash_error_102_hint => 'FlashChords ไม่สามารถเริ่มระบบเสียงได้ โปรดตรวจสอบว่าไม่มีแอปอื่นใช้ไมโครโฟนและรีสตาร์ทแอป';

  @override
  String get flash_error_103 => 'อินพุตเสียงถูกขัดจังหวะ';

  @override
  String get flash_error_103_hint => 'การฟังหยุดลงเนื่องจากการขัดจังหวะเสียง โปรดตรวจสอบการเชื่อมต่อไมโครโฟนและเริ่มใหม่';

  @override
  String get flash_error_201 => 'เกิดข้อผิดพลาดภายใน';

  @override
  String get flash_error_201_hint => 'FlashChords พบข้อผิดพลาดที่ไม่คาดคิด โปรดรีสตาร์ทแอป หากปัญหายังคงอยู่ โปรดติดต่อฝ่ายสนับสนุนพร้อมรหัสข้อผิดพลาดนี้';

  @override
  String get flash_error_301 => 'ต้องเลือกอย่างน้อยหนึ่งค่า';

  @override
  String get flash_error_301_hint => 'การยกเลิกการเลือกครั้งล่าสุดถูกเลือกกลับมาเพื่อให้แน่ใจว่ามีการเลือกอย่างน้อยหนึ่งค่า หากต้องการยกเลิก ให้เลือกค่าอื่นก่อน';

  @override
  String get language_picker_scroll_hint => 'เลื่อนเพื่อดูภาษาเพิ่มเติม';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'วิธีการใช้งาน';

  @override
  String get howItWorksBody => 'วางอุปกรณ์ของคุณบนเปียโน สำหรับแต่ละแฟลชการ์ด ให้เล่นคอร์ดที่แสดง หากเปิดการฟังอยู่ (การตั้งค่า) และคุณเล่นคีย์ที่ถูกต้องก่อนหมดเวลา (ถ้าเปิดตัวจับเวลา) FlashChords™ จะทำเครื่องหมายว่าถูกต้องและแสดงการ์ดถัดไป หากปิดการฟัง ให้ทำเครื่องหมายเอง: เครื่องหมายถูกหรือปัดไปทางขวาสำหรับถูกต้อง, X หรือปัดไปทางซ้ายสำหรับไม่ถูกต้อง แตะการ์ดเพื่อดูคีย์ที่คาดไว้\n\nหมายเหตุ: คอร์ดในอ็อกเทฟที่ต่ำมากอาจตรวจจับได้ยากขึ้นบนบางอุปกรณ์หรือคีย์บอร์ด';

  @override
  String get upgradeReenableListener => 'อัปเกรดเพื่อเปิดการฟังอีกครั้ง';
}
