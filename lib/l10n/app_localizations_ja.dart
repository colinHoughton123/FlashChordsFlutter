// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get welcomeTitle => 'FlashChordsへようこそ';

  @override
  String get welcomeUpdate_Update => 'アップデートがあります';

  @override
  String get welcomeUpdate_Button_Later => '後で';

  @override
  String get welcomeUpdate_Button_Update => '更新';

  @override
  String get listenerLimitReachedTitle => 'リスナーが無効になりました';

  @override
  String listenerLimitReachedBody(Object limit) {
    return '無料カードを $limit 回再生した後、リスナー機能が無効になりました。再度有効にするにはアップグレードしてください。';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return '無料版：リスナー対応カード $limit 枚中 $played 枚を使用しました';
  }

  @override
  String get listenerLimitDialogTitle => '無料上限に達しました';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChordsは引き続き動作しますが、$priceでアップグレードしない限りリスナー機能は無効です。';
  }

  @override
  String get upgrade => 'アップグレード';

  @override
  String get later => '後で';

  @override
  String get listenerInversionNoticeTitle => 'リスナーに関する注意';

  @override
  String get listenerInversionNoticePart1 => '複数の転回形を選択しています。FlashChordsは転回形の違いを「聞き分ける」ことができません。期待される鍵盤パターンは表示されますが、誤った転回形で弾かれた和音は ';

  @override
  String get listenerInversionNoticeAny => '「正しい」';

  @override
  String get listenerInversionNoticePart2 => ' としてマークされます。';

  @override
  String get listenerInversionNoticeDontShow => '今後表示しない';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => '和音を読み込み中...';

  @override
  String get start => '開始';

  @override
  String get configure => '設定';

  @override
  String get mainCatchPhrase => '和音を一瞬で学ぼう！';

  @override
  String get mainFeaturesTitle => '機能';

  @override
  String get mainFeatures1Title => '和音を選択';

  @override
  String get mainFeatures1Content => '集中したい和音を設定できます';

  @override
  String get mainFeatures2Title => 'タイムチャレンジ';

  @override
  String get mainFeatures2Content => 'カスタムタイマーで自分を試しましょう';

  @override
  String get mainFeatures3Title => '自動判定';

  @override
  String get mainFeatures3Content => 'FlashChordsにピアノ演奏を聴かせましょう';

  @override
  String get language_picker_title => '言語を選択';

  @override
  String get language_change_tooltip => '言語を変更';

  @override
  String get configTitle => '設定';

  @override
  String get configSelectRoots => '和音を選択';

  @override
  String get configSelectChordTypes => '和音の種類を選択';

  @override
  String get configSelectInversions => '転回形を選択';

  @override
  String get configEnableTimer => 'タイマーを有効にする';

  @override
  String get configTimerSeconds => 'タイマー（秒）';

  @override
  String get saveButton => '保存';

  @override
  String get configListener => 'マイクを有効にして聴き取り、正しいと判定する';

  @override
  String get configIncorrect => 'タイマー開始後に最初に弾かれた和音でない場合は誤りとしてマークする';

  @override
  String get configAtLeastOneOption => 'このセクションでは少なくとも1つのオプションを選択する必要があります。最後のオプションが再選択されました。もう一度お試しください。';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'リスニングモードを有効にする（将来機能）';

  @override
  String get configEnableListeningDesc => '音声検出が一致した場合、自動的に和音を正しいと判定します。';

  @override
  String get chord_major => 'メジャー';

  @override
  String get chord_minor => 'マイナー';

  @override
  String get chord_diminished => 'ディミニッシュ';

  @override
  String get chord_dominant7 => 'ドミナント7th';

  @override
  String get chord_major7 => 'メジャー7th';

  @override
  String get chord_minor7 => 'マイナー7th';

  @override
  String get chord_suspended2 => 'サス2';

  @override
  String get chord_suspended4 => 'サス4';

  @override
  String get chord_augmented => 'オーギュメント';

  @override
  String get inv_root => '基本形';

  @override
  String get inv_first => '第1転回形';

  @override
  String get inv_second => '第2転回形';

  @override
  String get configCardOrder => 'カード順';

  @override
  String get configCardOrderRandom => 'ランダム';

  @override
  String get configCardOrderSorted => '並び順';

  @override
  String get flash_incorrectCountLabel => '誤り';

  @override
  String get flash_correctCountLabel => '正しい';

  @override
  String get flash_playingMainDeck => 'メインデッキをプレイ中';

  @override
  String get flash_playingErrorDeck => 'エラーデッキをプレイ中';

  @override
  String get flash_redoButton => 'やり直し';

  @override
  String get flash_playedLabel => 'プレイ済み';

  @override
  String get flash_toGoLabel => '残り';

  @override
  String get flash_averageTimeLabel => '平均時間：';

  @override
  String get flash_timeLabel => 'タイマー';

  @override
  String get flash_timerCancelled => 'タイマーがキャンセルされました';

  @override
  String get flash_reveal => '和音を表示';

  @override
  String get flash_play_instruction => '次の和音を弾いてください\nメインデッキからランダムに選ばれます';

  @override
  String get flash_swipe_right => '正しく弾けたら右にスワイプ';

  @override
  String get flash_swipe_left => '間違えたら左にスワイプ';

  @override
  String get flash_not_sure => '自信がない？カードをタップして指使いを確認できます';

  @override
  String get flash_welcome1 => 'ここに和音名が表示されます';

  @override
  String get flash_welcome2 => 'ピアノで弾いてみましょう';

  @override
  String get flash_incorrect_count => '誤り数';

  @override
  String get flash_correct_count => '正しい数';

  @override
  String get flash_playing_main => 'メインデッキをプレイ中';

  @override
  String get flash_playing_wrong => '誤りをプレイ中';

  @override
  String get flash_play_again => 'もう一度プレイ';

  @override
  String get flash_average_time => '平均時間';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played 枚プレイ済み、残り $remaining 枚';
  }

  @override
  String get flash_mainDeck => 'メインデッキ';

  @override
  String get flash_errorDeck => 'エラーデッキ';

  @override
  String get flash_correct => '正しい';

  @override
  String get flash_incorrect => '誤り';

  @override
  String get flash_of => '／';

  @override
  String get flash_next => '次へ';

  @override
  String get summary_title => 'まとめ';

  @override
  String get summary_correct => '正しい';

  @override
  String get summary_incorrect => '誤り';

  @override
  String get summary_cards => 'カード';

  @override
  String get summary_average_time => '平均時間';

  @override
  String get summary_seconds => '秒';

  @override
  String get summary_from_main_deck => 'メインデッキ';

  @override
  String get summary_from_error_deck => 'エラーデッキ';

  @override
  String get summary_play_again => 'もう一度プレイ';

  @override
  String get summary_done => '完了';

  @override
  String get summary_accuracy => '正答率';

  @override
  String get summary_average_time_correct => '平均（正しい和音）';

  @override
  String get summary_average_time_all => '平均時間（すべての和音）';

  @override
  String get summary_unsaved_changes_title => '変更が保存されていません';

  @override
  String get summary_unsaved_changes_body => '設定を変更しました。保存する場合は、今キャンセルを押してから保存を押してください。';

  @override
  String get summary_discard => '変更を破棄';

  @override
  String get cancel => 'キャンセル';

  @override
  String get listeningActive => '聴き取り中…';

  @override
  String get listeningInactive => '聴き取りを一時停止';

  @override
  String get flash_error_101 => '音声入力が許可されていません。';

  @override
  String get flash_error_101_hint => 'FlashChordsにはマイクへのアクセス許可がありません。端末設定でマイク許可を有効にし、アプリを再起動してください。';

  @override
  String get flash_error_102 => '音声聴き取りを開始できません。';

  @override
  String get flash_error_102_hint => 'FlashChordsは音声システムを初期化できませんでした。他のアプリがマイクを使用していないか確認し、アプリを再起動してください。';

  @override
  String get flash_error_103 => '音声入力が中断されました。';

  @override
  String get flash_error_103_hint => '音声の中断により聴き取りが停止しました。マイク接続を確認し、再度開始してください。';

  @override
  String get flash_error_201 => '内部エラーが発生しました。';

  @override
  String get flash_error_201_hint => 'FlashChordsで予期しないエラーが発生しました。アプリを再起動してください。問題が続く場合は、このエラーコードを添えてサポートに連絡してください。';

  @override
  String get flash_error_301 => '少なくとも1つの値を選択する必要があります。';

  @override
  String get flash_error_301_hint => '最後に解除した選択は、少なくとも1つの値が選択されるよう再選択されました。解除するには、先に別の値を選択してください。';

  @override
  String get language_picker_scroll_hint => '他の言語を見るにはスクロールしてください';
}
