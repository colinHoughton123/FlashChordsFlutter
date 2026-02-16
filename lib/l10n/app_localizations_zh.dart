// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get welcomeTitle => '欢迎使用 FlashChords';

  @override
  String get welcomeUpdate_Update => '有可用更新';

  @override
  String get welcomeUpdate_Button_Later => '稍后';

  @override
  String get welcomeUpdate_Button_Update => '更新';

  @override
  String get listenerLimitReachedTitle => '监听已禁用';

  @override
  String listenerLimitReachedBody(Object limit) {
    return '在免费播放 $limit 张卡片后，监听功能已被禁用。升级以重新启用。';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return '免费版本：已使用 $played/$limit 张支持监听的卡片';
  }

  @override
  String get listenerLimitDialogTitle => '已达到免费限制';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords 将继续运行，但除非你以 $price 升级，否则监听功能将被禁用。';
  }

  @override
  String get upgrade => '升级';

  @override
  String get later => '稍后';

  @override
  String get listenerInversionNoticeTitle => '监听提示';

  @override
  String get listenerInversionNoticePart1 => '你选择了多个转位。请注意，FlashChords 无法“听出”转位之间的区别。系统会显示预期的按键模式，但如果以错误的转位弹奏和弦，将被标记为';

  @override
  String get listenerInversionNoticeAny => '“正确”';

  @override
  String get listenerInversionNoticePart2 => '。';

  @override
  String get listenerInversionNoticeDontShow => '不再显示';

  @override
  String get listenerInversionNoticeGotIt => '好的';

  @override
  String get loadingChords => '正在加载和弦...';

  @override
  String get start => '开始';

  @override
  String get configure => '配置';

  @override
  String get mainCatchPhrase => '快速学习和弦！';

  @override
  String get mainFeaturesTitle => '功能';

  @override
  String get mainFeatures1Title => '选择你的和弦';

  @override
  String get mainFeatures1Content => '选择要练习的和弦';

  @override
  String get mainFeatures2Title => '计时挑战';

  @override
  String get mainFeatures2Content => '用自定义计时器测试反应时间';

  @override
  String get mainFeatures3Title => '实时聆听模式';

  @override
  String get mainFeatures3Content => '和弦会被自动检测并评分';

  @override
  String get language_picker_title => '选择语言';

  @override
  String get language_change_tooltip => '切换语言';

  @override
  String get configTitle => '设置';

  @override
  String get configSelectRoots => '选择和弦';

  @override
  String get configSelectChordTypes => '选择和弦类型';

  @override
  String get configSelectInversions => '选择转位';

  @override
  String get configEnableTimer => '启用计时器';

  @override
  String get configTimerSeconds => '计时器（秒）';

  @override
  String get saveButton => '保存';

  @override
  String get configListener => '启用麦克风监听并标记为正确';

  @override
  String get configIncorrect => '如果不是计时开始后的第一个和弦，则标记为错误';

  @override
  String get configAtLeastOneOption => '此部分必须至少选择一个选项。已重新选择最后一个选项。请重试。';

  @override
  String get configOK => '好的';

  @override
  String get configEnableListening => '启用监听模式（未来功能）';

  @override
  String get configEnableListeningDesc => '当音频检测匹配时自动标记和弦为正确。';

  @override
  String get chord_major => '大三和弦';

  @override
  String get chord_minor => '小三和弦';

  @override
  String get chord_diminished => '减和弦';

  @override
  String get chord_dominant7 => '属七和弦';

  @override
  String get chord_major7 => '大七和弦';

  @override
  String get chord_minor7 => '小七和弦';

  @override
  String get chord_suspended2 => '挂二和弦';

  @override
  String get chord_suspended4 => '挂四和弦';

  @override
  String get chord_augmented => '增和弦';

  @override
  String get inv_root => '原位';

  @override
  String get inv_first => '第一转位';

  @override
  String get inv_second => '第二转位';

  @override
  String get configCardOrder => '卡片顺序';

  @override
  String get configCardOrderRandom => '随机';

  @override
  String get configCardOrderSorted => '排序';

  @override
  String get flash_incorrectCountLabel => '错误';

  @override
  String get flash_correctCountLabel => '正确';

  @override
  String get flash_playingMainDeck => '正在练习主卡组';

  @override
  String get flash_playingErrorDeck => '正在练习错误卡组';

  @override
  String get flash_redoButton => '重做';

  @override
  String get flash_playedLabel => '已练习';

  @override
  String get flash_toGoLabel => '剩余';

  @override
  String get flash_averageTimeLabel => '平均时间：';

  @override
  String get flash_timeLabel => '计时器';

  @override
  String get flash_timerCancelled => '计时器已取消';

  @override
  String get flash_reveal => '显示和弦';

  @override
  String get flash_play_instruction => '弹奏以下和弦\n从主卡组随机选择';

  @override
  String get flash_swipe_right => '如果弹对了请向右滑动';

  @override
  String get flash_swipe_left => '如果弹错了请向左滑动';

  @override
  String get flash_not_sure => '不确定？点击卡片查看指法';

  @override
  String get flash_welcome1 => '这里将显示和弦名称';

  @override
  String get flash_welcome2 => '在钢琴上弹奏它';

  @override
  String get flash_incorrect_count => '错误次数';

  @override
  String get flash_correct_count => '正确次数';

  @override
  String get flash_playing_main => '正在练习主卡组';

  @override
  String get flash_playing_wrong => '正在练习错误';

  @override
  String get flash_play_again => '再玩一次';

  @override
  String get flash_average_time => '平均时间';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '已练习 $played 张，还剩 $remaining 张';
  }

  @override
  String get flash_mainDeck => '主卡组';

  @override
  String get flash_errorDeck => '错误卡组';

  @override
  String get flash_correct => '正确';

  @override
  String get flash_incorrect => '错误';

  @override
  String get flash_of => '共';

  @override
  String get flash_next => '下一张';

  @override
  String get detectedLabel => '已检测';

  @override
  String get missingLabel => '缺失';

  @override
  String get summary_title => '总结';

  @override
  String get summary_correct => '正确';

  @override
  String get summary_incorrect => '错误';

  @override
  String get summary_cards => '卡片';

  @override
  String get summary_average_time => '平均时间';

  @override
  String get summary_seconds => '秒';

  @override
  String get summary_from_main_deck => '主卡组';

  @override
  String get summary_from_error_deck => '错误卡组';

  @override
  String get summary_play_again => '使用错误牌组再玩一次';

  @override
  String get summary_done => '重新开始';

  @override
  String get summary_accuracy => '准确率';

  @override
  String get summary_average_time_correct => '平均（正确和弦）';

  @override
  String get summary_average_time_all => '平均时间（所有和弦）';

  @override
  String get summary_unsaved_changes_title => '你尚未保存更改';

  @override
  String get summary_unsaved_changes_body => '你在设置中做了更改。如果要保存，请先按取消，然后按保存。';

  @override
  String get summary_discard => '放弃更改';

  @override
  String get cancel => '取消';

  @override
  String get listeningActive => '正在监听…';

  @override
  String get listeningInactive => '监听已暂停';

  @override
  String get flash_error_101 => '不允许音频输入。';

  @override
  String get flash_error_101_hint => 'FlashChords 没有麦克风访问权限。请在设备设置中启用麦克风权限并重启应用。';

  @override
  String get flash_error_102 => '无法开始音频监听。';

  @override
  String get flash_error_102_hint => 'FlashChords 无法初始化音频系统。请检查是否有其他应用正在使用麦克风并重启应用。';

  @override
  String get flash_error_103 => '音频输入被中断。';

  @override
  String get flash_error_103_hint => '由于音频中断，监听已停止。请检查麦克风连接并重新开始监听。';

  @override
  String get flash_error_201 => '发生内部错误。';

  @override
  String get flash_error_201_hint => 'FlashChords 遇到了意外错误。请重启应用。如果问题仍然存在，请联系支持并提供此错误代码。';

  @override
  String get flash_error_301 => '必须至少选择一个值。';

  @override
  String get flash_error_301_hint => '你最后取消选择的项已被重新选择，以确保至少有一个值被选中。要取消它，请先选择另一个值。';

  @override
  String get language_picker_scroll_hint => 'Scroll to see more languages';

  @override
  String get listenerStarting => '正在启动监听器...';

  @override
  String get howItWorksTitle => '使用说明';

  @override
  String get howItWorksBody => '将设备放在钢琴上。每张闪卡显示一个和弦，请演奏该和弦。如果监听已开启（配置），并且你在计时结束前弹对了琴键（若计时器启用），FlashChords™ 会标记为正确并显示下一张卡片。如果监听关闭，请自行标记：正确请点勾或右滑，错误请点 X 或左滑。点击卡片可查看应弹的琴键。\n\n注意：非常低的音区和弦在某些设备或键盘上可能更难检测。';

  @override
  String get upgradeReenableListener => '升级以重新启用监听';

  @override
  String get configShowCorrectOnError => '检测到错误时显示正确按键';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans(): super('zh_Hans');

  @override
  String get welcomeTitle => '欢迎使用 FlashChords';

  @override
  String get welcomeUpdate_Update => '有可用更新';

  @override
  String get welcomeUpdate_Button_Later => '稍后';

  @override
  String get welcomeUpdate_Button_Update => '更新';

  @override
  String get listenerLimitReachedTitle => '监听已禁用';

  @override
  String listenerLimitReachedBody(Object limit) {
    return '在免费播放 $limit 张卡片后，监听功能已被禁用。升级以重新启用。';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return '免费版本：已使用 $played/$limit 张支持监听的卡片';
  }

  @override
  String get listenerLimitDialogTitle => '已达到免费限制';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords 将继续运行，但除非你以 $price 升级，否则监听功能将被禁用。';
  }

  @override
  String get upgrade => '升级';

  @override
  String get later => '稍后';

  @override
  String get listenerInversionNoticeTitle => '监听提示';

  @override
  String get listenerInversionNoticePart1 => '你选择了多个转位。请注意，FlashChords 无法“听出”转位之间的区别。系统会显示预期的按键模式，但如果以错误的转位弹奏和弦，将被标记为';

  @override
  String get listenerInversionNoticeAny => '“正确”';

  @override
  String get listenerInversionNoticePart2 => '。';

  @override
  String get listenerInversionNoticeDontShow => '不再显示';

  @override
  String get listenerInversionNoticeGotIt => '好的';

  @override
  String get loadingChords => '正在加载和弦...';

  @override
  String get start => '开始';

  @override
  String get configure => '配置';

  @override
  String get mainCatchPhrase => '快速学习和弦！';

  @override
  String get mainFeaturesTitle => '功能';

  @override
  String get mainFeatures1Title => '选择你的和弦';

  @override
  String get mainFeatures1Content => '选择要练习的和弦';

  @override
  String get mainFeatures2Title => '计时挑战';

  @override
  String get mainFeatures2Content => '用自定义计时器测试反应时间';

  @override
  String get mainFeatures3Title => '实时聆听模式';

  @override
  String get mainFeatures3Content => '和弦会被自动检测并评分';

  @override
  String get language_picker_title => '选择语言';

  @override
  String get language_change_tooltip => '切换语言';

  @override
  String get configTitle => '设置';

  @override
  String get configSelectRoots => '选择和弦';

  @override
  String get configSelectChordTypes => '选择和弦类型';

  @override
  String get configSelectInversions => '选择转位';

  @override
  String get configEnableTimer => '启用计时器';

  @override
  String get configTimerSeconds => '计时器（秒）';

  @override
  String get saveButton => '保存';

  @override
  String get configListener => '启用麦克风监听并标记为正确';

  @override
  String get configIncorrect => '如果不是计时开始后的第一个和弦，则标记为错误';

  @override
  String get configAtLeastOneOption => '此部分必须至少选择一个选项。已重新选择最后一个选项。请重试。';

  @override
  String get configOK => '好的';

  @override
  String get configEnableListening => '启用监听模式（未来功能）';

  @override
  String get configEnableListeningDesc => '当音频检测匹配时自动标记和弦为正确。';

  @override
  String get chord_major => '大三和弦';

  @override
  String get chord_minor => '小三和弦';

  @override
  String get chord_diminished => '减和弦';

  @override
  String get chord_dominant7 => '属七和弦';

  @override
  String get chord_major7 => '大七和弦';

  @override
  String get chord_minor7 => '小七和弦';

  @override
  String get chord_suspended2 => '挂二和弦';

  @override
  String get chord_suspended4 => '挂四和弦';

  @override
  String get chord_augmented => '增和弦';

  @override
  String get inv_root => '原位';

  @override
  String get inv_first => '第一转位';

  @override
  String get inv_second => '第二转位';

  @override
  String get configCardOrder => '卡片顺序';

  @override
  String get configCardOrderRandom => '随机';

  @override
  String get configCardOrderSorted => '排序';

  @override
  String get flash_incorrectCountLabel => '错误';

  @override
  String get flash_correctCountLabel => '正确';

  @override
  String get flash_playingMainDeck => '正在练习主卡组';

  @override
  String get flash_playingErrorDeck => '正在练习错误卡组';

  @override
  String get flash_redoButton => '重做';

  @override
  String get flash_playedLabel => '已练习';

  @override
  String get flash_toGoLabel => '剩余';

  @override
  String get flash_averageTimeLabel => '平均时间：';

  @override
  String get flash_timeLabel => '计时器';

  @override
  String get flash_timerCancelled => '计时器已取消';

  @override
  String get flash_reveal => '显示和弦';

  @override
  String get flash_play_instruction => '弹奏以下和弦\n从主卡组随机选择';

  @override
  String get flash_swipe_right => '如果弹对了请向右滑动';

  @override
  String get flash_swipe_left => '如果弹错了请向左滑动';

  @override
  String get flash_not_sure => '不确定？点击卡片查看指法';

  @override
  String get flash_welcome1 => '这里将显示和弦名称';

  @override
  String get flash_welcome2 => '在钢琴上弹奏它';

  @override
  String get flash_incorrect_count => '错误次数';

  @override
  String get flash_correct_count => '正确次数';

  @override
  String get flash_playing_main => '正在练习主卡组';

  @override
  String get flash_playing_wrong => '正在练习错误';

  @override
  String get flash_play_again => '再玩一次';

  @override
  String get flash_average_time => '平均时间';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '已练习 $played 张，还剩 $remaining 张';
  }

  @override
  String get flash_mainDeck => '主卡组';

  @override
  String get flash_errorDeck => '错误卡组';

  @override
  String get flash_correct => '正确';

  @override
  String get flash_incorrect => '错误';

  @override
  String get flash_of => '共';

  @override
  String get flash_next => '下一张';

  @override
  String get detectedLabel => '已检测';

  @override
  String get missingLabel => '缺失';

  @override
  String get summary_title => '总结';

  @override
  String get summary_correct => '正确';

  @override
  String get summary_incorrect => '错误';

  @override
  String get summary_cards => '卡片';

  @override
  String get summary_average_time => '平均时间';

  @override
  String get summary_seconds => '秒';

  @override
  String get summary_from_main_deck => '主卡组';

  @override
  String get summary_from_error_deck => '错误卡组';

  @override
  String get summary_play_again => '使用错误牌组再玩一次';

  @override
  String get summary_done => '重新开始';

  @override
  String get summary_accuracy => '准确率';

  @override
  String get summary_average_time_correct => '平均（正确和弦）';

  @override
  String get summary_average_time_all => '平均时间（所有和弦）';

  @override
  String get summary_unsaved_changes_title => '你尚未保存更改';

  @override
  String get summary_unsaved_changes_body => '你在设置中做了更改。如果要保存，请先按取消，然后按保存。';

  @override
  String get summary_discard => '放弃更改';

  @override
  String get cancel => '取消';

  @override
  String get listeningActive => '正在监听…';

  @override
  String get listeningInactive => '监听已暂停';

  @override
  String get flash_error_101 => '不允许音频输入。';

  @override
  String get flash_error_101_hint => 'FlashChords 没有麦克风访问权限。请在设备设置中启用麦克风权限并重启应用。';

  @override
  String get flash_error_102 => '无法开始音频监听。';

  @override
  String get flash_error_102_hint => 'FlashChords 无法初始化音频系统。请检查是否有其他应用正在使用麦克风并重启应用。';

  @override
  String get flash_error_103 => '音频输入被中断。';

  @override
  String get flash_error_103_hint => '由于音频中断，监听已停止。请检查麦克风连接并重新开始监听。';

  @override
  String get flash_error_201 => '发生内部错误。';

  @override
  String get flash_error_201_hint => 'FlashChords 遇到了意外错误。请重启应用。如果问题仍然存在，请联系支持并提供此错误代码。';

  @override
  String get flash_error_301 => '必须至少选择一个值。';

  @override
  String get flash_error_301_hint => '你最后取消选择的项已被重新选择，以确保至少有一个值被选中。要取消它，请先选择另一个值。';

  @override
  String get language_picker_scroll_hint => 'Scroll to see more languages';

  @override
  String get listenerStarting => '正在启动监听器...';

  @override
  String get howItWorksTitle => '使用说明';

  @override
  String get howItWorksBody => '将设备放在钢琴上。每张闪卡显示一个和弦，请演奏该和弦。如果监听已开启（配置），并且你在计时结束前弹对了琴键（若计时器启用），FlashChords™ 会标记为正确并显示下一张卡片。如果监听关闭，请自行标记：正确请点勾或右滑，错误请点 X 或左滑。点击卡片可查看应弹的琴键。\n\n注意：非常低的音区和弦在某些设备或键盘上可能更难检测。';

  @override
  String get upgradeReenableListener => '升级以重新启用监听';

  @override
  String get configShowCorrectOnError => '检测到错误时显示正确按键';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant(): super('zh_Hant');

  @override
  String get welcomeTitle => '歡迎使用 FlashChords';

  @override
  String get welcomeUpdate_Update => '有可用更新';

  @override
  String get welcomeUpdate_Button_Later => '稍後';

  @override
  String get welcomeUpdate_Button_Update => '更新';

  @override
  String get listenerLimitReachedTitle => '聆聽功能已停用';

  @override
  String listenerLimitReachedBody(Object limit) {
    return '在 $limit 次免費卡片播放後，聆聽功能已停用。升級即可重新啟用。';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return '免費版：已使用 $limit 次中的 $played 次聆聽卡片';
  }

  @override
  String get listenerLimitDialogTitle => '已達免費上限';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords 仍可使用，但除非以 $price 升級，否則聆聽功能將停用。';
  }

  @override
  String get upgrade => '升級';

  @override
  String get later => '稍後';

  @override
  String get listenerInversionNoticeTitle => '聆聽提示';

  @override
  String get listenerInversionNoticePart1 => '你已選擇超過 1 種轉位。請注意，FlashChords 無法「聽出」不同的轉位。系統仍會顯示正確的鍵位圖樣，但若彈奏錯誤的轉位，仍會被標記為';

  @override
  String get listenerInversionNoticeAny => '「正確」';

  @override
  String get listenerInversionNoticePart2 => '。';

  @override
  String get listenerInversionNoticeDontShow => '不要再顯示';

  @override
  String get listenerInversionNoticeGotIt => '確定';

  @override
  String get loadingChords => '載入和弦中…';

  @override
  String get start => '開始';

  @override
  String get configure => '設定';

  @override
  String get mainCatchPhrase => '快速學會和弦！';

  @override
  String get mainFeaturesTitle => '功能';

  @override
  String get mainFeatures1Title => '選擇你的和弦';

  @override
  String get mainFeatures1Content => '選擇要練習的和弦';

  @override
  String get mainFeatures2Title => '計時挑戰';

  @override
  String get mainFeatures2Content => '用自訂計時器測試反應時間';

  @override
  String get mainFeatures3Title => '即時聆聽模式';

  @override
  String get mainFeatures3Content => '和弦會被自動偵測並評分';

  @override
  String get language_picker_title => '選擇語言';

  @override
  String get language_change_tooltip => '切換語言';

  @override
  String get configTitle => '設定';

  @override
  String get configSelectRoots => '選擇和弦';

  @override
  String get configSelectChordTypes => '選擇和弦類型';

  @override
  String get configSelectInversions => '選擇轉位';

  @override
  String get configEnableTimer => '啟用計時器';

  @override
  String get configTimerSeconds => '計時器（秒）';

  @override
  String get saveButton => '儲存';

  @override
  String get configListener => '啟用麥克風以聆聽並標記正確';

  @override
  String get configIncorrect => '若非計時開始後彈奏的第一個和弦，請標記為錯誤';

  @override
  String get configAtLeastOneOption => '此區塊必須至少選擇一個選項。已重新選取最後一個選項，請再試一次。';

  @override
  String get configOK => '確定';

  @override
  String get configEnableListening => '啟用聆聽模式（未來功能）';

  @override
  String get configEnableListeningDesc => '當音訊偵測符合時自動標記為正確。';

  @override
  String get chord_major => '大調';

  @override
  String get chord_minor => '小調';

  @override
  String get chord_diminished => '減和弦';

  @override
  String get chord_dominant7 => '屬七和弦';

  @override
  String get chord_major7 => '大七和弦';

  @override
  String get chord_minor7 => '小七和弦';

  @override
  String get chord_suspended2 => '掛二和弦';

  @override
  String get chord_suspended4 => '掛四和弦';

  @override
  String get chord_augmented => '增和弦';

  @override
  String get inv_root => '根音位置';

  @override
  String get inv_first => '第一轉位';

  @override
  String get inv_second => '第二轉位';

  @override
  String get configCardOrder => '卡片順序';

  @override
  String get configCardOrderRandom => '隨機';

  @override
  String get configCardOrderSorted => '排序';

  @override
  String get flash_incorrectCountLabel => '錯誤';

  @override
  String get flash_correctCountLabel => '正確';

  @override
  String get flash_playingMainDeck => '正在播放主牌組';

  @override
  String get flash_playingErrorDeck => '正在播放錯誤牌組';

  @override
  String get flash_redoButton => '重做';

  @override
  String get flash_playedLabel => '已完成';

  @override
  String get flash_toGoLabel => '剩餘';

  @override
  String get flash_averageTimeLabel => '平均時間：';

  @override
  String get flash_timeLabel => '計時器';

  @override
  String get flash_timerCancelled => '計時器已取消';

  @override
  String get flash_reveal => '顯示和弦';

  @override
  String get flash_play_instruction => '請演奏下列和弦\n從主牌組中隨機選取';

  @override
  String get flash_swipe_right => '若彈奏正確，向右滑';

  @override
  String get flash_swipe_left => '若彈奏錯誤，向左滑';

  @override
  String get flash_not_sure => '不確定？點擊卡片查看指法';

  @override
  String get flash_welcome1 => '和弦名稱將顯示在此';

  @override
  String get flash_welcome2 => '在鋼琴上彈奏它';

  @override
  String get flash_incorrect_count => '錯誤次數';

  @override
  String get flash_correct_count => '正確次數';

  @override
  String get flash_playing_main => '正在播放主牌組';

  @override
  String get flash_playing_wrong => '正在播放錯誤';

  @override
  String get flash_play_again => '再玩一次';

  @override
  String get flash_average_time => '平均時間';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '已完成 $played，剩餘 $remaining';
  }

  @override
  String get flash_mainDeck => '主牌組';

  @override
  String get flash_errorDeck => '錯誤牌組';

  @override
  String get flash_correct => '正確';

  @override
  String get flash_incorrect => '錯誤';

  @override
  String get flash_of => '之';

  @override
  String get flash_next => '下一個';

  @override
  String get detectedLabel => '已偵測';

  @override
  String get missingLabel => '缺失';

  @override
  String get summary_title => '總結';

  @override
  String get summary_correct => '正確';

  @override
  String get summary_incorrect => '錯誤';

  @override
  String get summary_cards => '卡片';

  @override
  String get summary_average_time => '平均時間';

  @override
  String get summary_seconds => '秒';

  @override
  String get summary_from_main_deck => '主牌組';

  @override
  String get summary_from_error_deck => '錯誤牌組';

  @override
  String get summary_play_again => '使用錯誤牌組再玩一次';

  @override
  String get summary_done => '重新開始';

  @override
  String get summary_accuracy => '正確率';

  @override
  String get summary_average_time_correct => '平均（正確和弦）';

  @override
  String get summary_average_time_all => '平均時間（所有和弦）';

  @override
  String get summary_unsaved_changes_title => '你尚未儲存變更';

  @override
  String get summary_unsaved_changes_body => '你已變更設定。若要儲存，請先按「取消」，再按「儲存」。';

  @override
  String get summary_discard => '捨棄變更';

  @override
  String get cancel => '取消';

  @override
  String get listeningActive => '聆聽中…';

  @override
  String get listeningInactive => '聆聽已暫停';

  @override
  String get flash_error_101 => '不允許音訊輸入。';

  @override
  String get flash_error_101_hint => 'FlashChords 沒有麥克風權限。請在裝置設定中啟用麥克風權限並重新啟動應用程式。';

  @override
  String get flash_error_102 => '無法啟動音訊聆聽。';

  @override
  String get flash_error_102_hint => 'FlashChords 無法初始化音訊系統。請確認沒有其他應用程式正在使用麥克風，並重新啟動。';

  @override
  String get flash_error_103 => '音訊輸入已中斷。';

  @override
  String get flash_error_103_hint => '聆聽因音訊中斷而停止。請檢查麥克風連線並重新開始聆聽。';

  @override
  String get flash_error_201 => '發生內部錯誤。';

  @override
  String get flash_error_201_hint => 'FlashChords 遇到未預期錯誤。請重新啟動應用程式；若問題持續，請聯絡支援並提供錯誤代碼。';

  @override
  String get flash_error_301 => '至少必須選擇一個值。';

  @override
  String get flash_error_301_hint => '已重新選取最後取消的項目以確保至少選擇一個值。若要取消它，請先選擇其他項目。';

  @override
  String get language_picker_scroll_hint => '向下捲動以查看更多語言';

  @override
  String get listenerStarting => '正在啟動監聽器...';

  @override
  String get howItWorksTitle => '使用說明';

  @override
  String get howItWorksBody => '將裝置放在鋼琴上。每張閃卡會顯示一個和弦，請演奏該和弦。若已啟用聆聽（設定），且你在計時結束前彈對了琴鍵（若計時器啟用），FlashChords™ 會標示為正確並顯示下一張卡片。若未啟用聆聽，請自行標記：正確按勾選或向右滑，錯誤按 X 或向左滑。點擊卡片可查看應彈的琴鍵。\n\n注意：非常低的音域和弦在某些裝置或鍵盤上可能較難偵測。';

  @override
  String get upgradeReenableListener => '升級以重新啟用聆聽';

  @override
  String get configShowCorrectOnError => '偵測到錯誤時顯示正確按鍵';
}
