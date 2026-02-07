// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get welcomeTitle => 'FlashChords에 오신 것을 환영합니다';

  @override
  String get welcomeUpdate_Update => '업데이트 사용 가능';

  @override
  String get welcomeUpdate_Button_Later => '나중에';

  @override
  String get welcomeUpdate_Button_Update => '업데이트';

  @override
  String get listenerLimitReachedTitle => '청취 기능 비활성화됨';

  @override
  String listenerLimitReachedBody(Object limit) {
    return '$limit개의 무료 카드 플레이 후 청취 기능이 비활성화되었습니다. 다시 활성화하려면 업그레이드하세요.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return '무료 버전: 청취 기능이 포함된 카드 $limit개 중 $played개 사용됨';
  }

  @override
  String get listenerLimitDialogTitle => '무료 한도에 도달했습니다';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords는 계속 작동하지만, $price에 업그레이드하지 않으면 청취 기능이 비활성화됩니다.';
  }

  @override
  String get upgrade => '업그레이드';

  @override
  String get later => '나중에';

  @override
  String get listenerInversionNoticeTitle => '청취 안내';

  @override
  String get listenerInversionNoticePart1 => '둘 이상의 전위를 선택했습니다. FlashChords는 전위 간의 차이를 “들을” 수 없다는 점을 유의하세요. 예상되는 건반 패턴이 표시되지만, 잘못된 전위로 연주된 화음은 ';

  @override
  String get listenerInversionNoticeAny => '“정확함”';

  @override
  String get listenerInversionNoticePart2 => '으로 표시됩니다.';

  @override
  String get listenerInversionNoticeDontShow => '다시 표시하지 않기';

  @override
  String get listenerInversionNoticeGotIt => '확인';

  @override
  String get loadingChords => '화음 불러오는 중...';

  @override
  String get start => '시작';

  @override
  String get configure => '설정';

  @override
  String get mainCatchPhrase => '화음을 빠르게 배워보세요!';

  @override
  String get mainFeaturesTitle => '기능';

  @override
  String get mainFeatures1Title => '화음 선택';

  @override
  String get mainFeatures1Content => 'Choose which chords to practice';

  @override
  String get mainFeatures2Title => '시간 제한 챌린지';

  @override
  String get mainFeatures2Content => 'Test your response time with customized timers';

  @override
  String get mainFeatures3Title => 'Live Listening Mode';

  @override
  String get mainFeatures3Content => 'Chords are automatically detected and scored';

  @override
  String get language_picker_title => '언어 선택';

  @override
  String get language_change_tooltip => '언어 변경';

  @override
  String get configTitle => '구성';

  @override
  String get configSelectRoots => '화음 선택';

  @override
  String get configSelectChordTypes => '화음 유형 선택';

  @override
  String get configSelectInversions => '전위 선택';

  @override
  String get configEnableTimer => '타이머 사용';

  @override
  String get configTimerSeconds => '타이머 (초)';

  @override
  String get saveButton => '저장';

  @override
  String get configListener => '마이크를 활성화하여 듣고 정확함으로 표시';

  @override
  String get configIncorrect => '타이머 시작 후 첫 번째로 연주된 화음이 아니면 틀림으로 표시';

  @override
  String get configAtLeastOneOption => '이 섹션에서는 최소 한 가지 옵션을 선택해야 합니다. 마지막 옵션이 다시 선택되었습니다. 다시 시도하세요.';

  @override
  String get configOK => '확인';

  @override
  String get configEnableListening => '청취 모드 활성화 (향후 기능)';

  @override
  String get configEnableListeningDesc => '오디오 감지가 일치하면 화음을 자동으로 정확함으로 표시합니다.';

  @override
  String get chord_major => '메이저';

  @override
  String get chord_minor => '마이너';

  @override
  String get chord_diminished => '디미니쉬드';

  @override
  String get chord_dominant7 => '도미넌트 7th';

  @override
  String get chord_major7 => '메이저 7th';

  @override
  String get chord_minor7 => '마이너 7th';

  @override
  String get chord_suspended2 => '서스펜디드 2';

  @override
  String get chord_suspended4 => '서스펜디드 4';

  @override
  String get chord_augmented => '어그먼티드';

  @override
  String get inv_root => '루트 포지션';

  @override
  String get inv_first => '1전위';

  @override
  String get inv_second => '2전위';

  @override
  String get configCardOrder => '카드 순서';

  @override
  String get configCardOrderRandom => '무작위';

  @override
  String get configCardOrderSorted => '정렬됨';

  @override
  String get flash_incorrectCountLabel => '틀림';

  @override
  String get flash_correctCountLabel => '정확함';

  @override
  String get flash_playingMainDeck => '메인 덱 진행 중';

  @override
  String get flash_playingErrorDeck => '오류 덱 진행 중';

  @override
  String get flash_redoButton => '다시하기';

  @override
  String get flash_playedLabel => '플레이됨';

  @override
  String get flash_toGoLabel => '남음';

  @override
  String get flash_averageTimeLabel => '평균 시간:';

  @override
  String get flash_timeLabel => '타이머';

  @override
  String get flash_timerCancelled => '타이머 취소됨';

  @override
  String get flash_reveal => '화음 보기';

  @override
  String get flash_play_instruction => '다음 화음을 연주하세요\n메인 덱에서 무작위로 선택됨';

  @override
  String get flash_swipe_right => '정확히 연주했다면 오른쪽으로 스와이프';

  @override
  String get flash_swipe_left => '틀리게 연주했다면 왼쪽으로 스와이프';

  @override
  String get flash_not_sure => '확실하지 않나요? 손가락 위치를 보려면 카드를 탭하세요';

  @override
  String get flash_welcome1 => '여기에 화음 이름이 표시됩니다';

  @override
  String get flash_welcome2 => '피아노에서 연주해 보세요';

  @override
  String get flash_incorrect_count => '틀림 횟수';

  @override
  String get flash_correct_count => '정확함 횟수';

  @override
  String get flash_playing_main => '메인 덱 진행 중';

  @override
  String get flash_playing_wrong => '오류 진행 중';

  @override
  String get flash_play_again => '다시 플레이';

  @override
  String get flash_average_time => '평균 시간';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played개 플레이됨, $remaining개 남음';
  }

  @override
  String get flash_mainDeck => '메인 덱';

  @override
  String get flash_errorDeck => '오류 덱';

  @override
  String get flash_correct => '정확함';

  @override
  String get flash_incorrect => '틀림';

  @override
  String get flash_of => '중';

  @override
  String get flash_next => '다음';

  @override
  String get summary_title => '요약';

  @override
  String get summary_correct => '정확함';

  @override
  String get summary_incorrect => '틀림';

  @override
  String get summary_cards => '카드';

  @override
  String get summary_average_time => '평균 시간';

  @override
  String get summary_seconds => '초';

  @override
  String get summary_from_main_deck => '메인 덱';

  @override
  String get summary_from_error_deck => '오류 덱';

  @override
  String get summary_play_again => 'Play again using errors deck';

  @override
  String get summary_done => 'Start Over';

  @override
  String get summary_accuracy => '정확도';

  @override
  String get summary_average_time_correct => '평균 (정확한 화음)';

  @override
  String get summary_average_time_all => '평균 시간 (모든 화음)';

  @override
  String get summary_unsaved_changes_title => '변경 사항이 저장되지 않았습니다';

  @override
  String get summary_unsaved_changes_body => '설정에서 변경을 했습니다. 저장하려면 지금 CANCEL을 누른 후 SAVE를 누르세요.';

  @override
  String get summary_discard => '변경 사항 버리기';

  @override
  String get cancel => '취소';

  @override
  String get listeningActive => '청취 중…';

  @override
  String get listeningInactive => '청취 일시 중지됨';

  @override
  String get flash_error_101 => '오디오 입력이 허용되지 않습니다.';

  @override
  String get flash_error_101_hint => 'FlashChords에 마이크 접근 권한이 없습니다. 기기 설정에서 마이크 권한을 활성화하고 앱을 다시 시작하세요.';

  @override
  String get flash_error_102 => '오디오 청취를 시작할 수 없습니다.';

  @override
  String get flash_error_102_hint => 'FlashChords가 오디오 시스템을 초기화할 수 없습니다. 다른 앱이 마이크를 사용 중인지 확인하고 앱을 다시 시작하세요.';

  @override
  String get flash_error_103 => '오디오 입력이 중단되었습니다.';

  @override
  String get flash_error_103_hint => '오디오 중단으로 인해 청취가 중지되었습니다. 마이크 연결을 확인하고 다시 시작하세요.';

  @override
  String get flash_error_201 => '내부 오류가 발생했습니다.';

  @override
  String get flash_error_201_hint => 'FlashChords에서 예기치 않은 오류가 발생했습니다. 앱을 다시 시작하세요. 문제가 지속되면 이 오류 코드와 함께 지원팀에 문의하세요.';

  @override
  String get flash_error_301 => '최소 한 가지 값을 선택해야 합니다.';

  @override
  String get flash_error_301_hint => '마지막 선택 해제가 다시 선택되어 최소 한 가지 값이 선택되도록 했습니다. 해제하려면 먼저 다른 값을 선택하세요.';

  @override
  String get language_picker_scroll_hint => '더 많은 언어를 보려면 스크롤하세요';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => '사용 방법';

  @override
  String get howItWorksBody => '기기를 피아노 위에 놓으세요. 각 플래시카드에 표시된 코드를 연주합니다. 리스너가 켜져 있고(설정), 타이머가 끝나기 전에 올바른 건반을 연주하면(타이머가 활성화된 경우) FlashChords™가 정답으로 표시하고 다음 카드를 보여줍니다. 리스너가 꺼져 있으면 직접 표시하세요: 정답은 체크 표시 또는 오른쪽 스와이프, 오답은 X 또는 왼쪽 스와이프. 카드를 탭하면 예상되는 건반을 확인할 수 있습니다.\n\n참고: 매우 낮은 옥타브의 코드는 일부 기기나 키보드에서 감지하기 어려울 수 있습니다.';

  @override
  String get upgradeReenableListener => 'Upgrade to re-enable the listener';
}
