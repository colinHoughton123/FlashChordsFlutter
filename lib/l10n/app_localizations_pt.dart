// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get welcomeTitle => 'Bem-vindo ao FlashChords';

  @override
  String get welcomeUpdate_Update => 'Atualização disponível';

  @override
  String get welcomeUpdate_Button_Later => 'Mais tarde';

  @override
  String get welcomeUpdate_Button_Update => 'Atualizar';

  @override
  String get listenerLimitReachedTitle => 'Escuta desativada';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'A escuta foi desativada após $limit cartas gratuitas. Faça upgrade para reativar.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Versão gratuita: $played de $limit cartas com escuta utilizadas';
  }

  @override
  String get listenerLimitDialogTitle => 'Limite gratuito atingido';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'O FlashChords continuará a funcionar, mas a escuta está desativada a menos que faça upgrade por $price.';
  }

  @override
  String get upgrade => 'Fazer upgrade';

  @override
  String get later => 'Mais tarde';

  @override
  String get listenerInversionNoticeTitle => 'Nota do modo escuta';

  @override
  String get listenerInversionNoticePart1 => 'Você selecionou mais de uma inversão. Saiba que o FlashChords não consegue “ouvir” a diferença entre inversões. Os padrões de teclas esperados serão exibidos, mas um acorde tocado na inversão errada será marcado como ';

  @override
  String get listenerInversionNoticeAny => '“correto”';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Não mostrar novamente';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Carregando acordes...';

  @override
  String get start => 'Iniciar';

  @override
  String get configure => 'Configurar';

  @override
  String get mainCatchPhrase => 'Aprenda acordes num piscar de olhos!';

  @override
  String get mainFeaturesTitle => 'Funcionalidades';

  @override
  String get mainFeatures1Title => 'Selecione seus acordes';

  @override
  String get mainFeatures1Content => 'Choose which chords to practice';

  @override
  String get mainFeatures2Title => 'Desafios cronometrados';

  @override
  String get mainFeatures2Content => 'Test your response time with customized timers';

  @override
  String get mainFeatures3Title => 'Live Listening Mode';

  @override
  String get mainFeatures3Content => 'Chords are automatically detected and scored';

  @override
  String get language_picker_title => 'Selecionar idioma';

  @override
  String get language_change_tooltip => 'Mudar idioma';

  @override
  String get configTitle => 'Configuração';

  @override
  String get configSelectRoots => 'Selecionar acordes';

  @override
  String get configSelectChordTypes => 'Selecionar tipos de acordes';

  @override
  String get configSelectInversions => 'Selecionar inversões';

  @override
  String get configEnableTimer => 'Ativar temporizador';

  @override
  String get configTimerSeconds => 'Temporizador (segundos)';

  @override
  String get saveButton => 'Salvar';

  @override
  String get configListener => 'Ativar o microfone para ouvir e marcar como Correto';

  @override
  String get configIncorrect => 'Marcar o acorde como Incorreto se não for o primeiro tocado após o início do temporizador';

  @override
  String get configAtLeastOneOption => 'Pelo menos uma opção deve ser selecionada nesta seção. A última opção foi selecionada novamente. Tente novamente.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Ativar modo de escuta (funcionalidade futura)';

  @override
  String get configEnableListeningDesc => 'Marcar automaticamente o acorde como correto quando a detecção de áudio corresponder.';

  @override
  String get chord_major => 'Maior';

  @override
  String get chord_minor => 'Menor';

  @override
  String get chord_diminished => 'Diminuto';

  @override
  String get chord_dominant7 => 'Sétima dominante';

  @override
  String get chord_major7 => 'Sétima maior';

  @override
  String get chord_minor7 => 'Sétima menor';

  @override
  String get chord_suspended2 => 'Suspenso 2';

  @override
  String get chord_suspended4 => 'Suspenso 4';

  @override
  String get chord_augmented => 'Aumentado';

  @override
  String get inv_root => 'Posição fundamental';

  @override
  String get inv_first => '1ª inversão';

  @override
  String get inv_second => '2ª inversão';

  @override
  String get configCardOrder => 'Ordem das cartas';

  @override
  String get configCardOrderRandom => 'Aleatória';

  @override
  String get configCardOrderSorted => 'Ordenada';

  @override
  String get flash_incorrectCountLabel => 'Incorreto';

  @override
  String get flash_correctCountLabel => 'Correto';

  @override
  String get flash_playingMainDeck => 'Jogando o baralho principal';

  @override
  String get flash_playingErrorDeck => 'Jogando o baralho de erros';

  @override
  String get flash_redoButton => 'REFAZER';

  @override
  String get flash_playedLabel => 'jogadas';

  @override
  String get flash_toGoLabel => 'restantes';

  @override
  String get flash_averageTimeLabel => 'Tempo médio:';

  @override
  String get flash_timeLabel => 'Temporizador';

  @override
  String get flash_timerCancelled => 'Temporizador cancelado';

  @override
  String get flash_reveal => 'Mostrar acorde';

  @override
  String get flash_play_instruction => 'Toque o seguinte acorde\nselecionado aleatoriamente do baralho principal';

  @override
  String get flash_swipe_right => 'Deslize para a direita se você tocou corretamente';

  @override
  String get flash_swipe_left => 'Deslize para a esquerda se você tocou incorretamente';

  @override
  String get flash_not_sure => 'Não tem certeza? Toque no cartão para ver a digitação';

  @override
  String get flash_welcome1 => 'O nome de um acorde será exibido aqui';

  @override
  String get flash_welcome2 => 'Toque-o no seu piano';

  @override
  String get flash_incorrect_count => 'Contagem de incorretos';

  @override
  String get flash_correct_count => 'Contagem de corretos';

  @override
  String get flash_playing_main => 'Jogando o baralho principal';

  @override
  String get flash_playing_wrong => 'Jogando os erros';

  @override
  String get flash_play_again => 'Jogar novamente';

  @override
  String get flash_average_time => 'Tempo médio';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played jogadas, $remaining restantes';
  }

  @override
  String get flash_mainDeck => 'Baralho principal';

  @override
  String get flash_errorDeck => 'Baralho de erros';

  @override
  String get flash_correct => 'Correto';

  @override
  String get flash_incorrect => 'Incorreto';

  @override
  String get flash_of => 'de';

  @override
  String get flash_next => 'Próximo';

  @override
  String get summary_title => 'Resumo';

  @override
  String get summary_correct => 'Correto';

  @override
  String get summary_incorrect => 'Incorreto';

  @override
  String get summary_cards => 'Cartas';

  @override
  String get summary_average_time => 'Tempo médio';

  @override
  String get summary_seconds => 'segundos';

  @override
  String get summary_from_main_deck => 'Baralho principal';

  @override
  String get summary_from_error_deck => 'Baralho de erros';

  @override
  String get summary_play_again => 'Play again using errors deck';

  @override
  String get summary_done => 'Start Over';

  @override
  String get summary_accuracy => 'Precisão';

  @override
  String get summary_average_time_correct => 'Média (acordes corretos)';

  @override
  String get summary_average_time_all => 'Tempo médio (todos os acordes)';

  @override
  String get summary_unsaved_changes_title => 'Você não salvou suas alterações';

  @override
  String get summary_unsaved_changes_body => 'Você fez uma alteração na configuração. Se quiser salvar, pressione CANCELAR agora e depois pressione SALVAR.';

  @override
  String get summary_discard => 'Descartar alterações';

  @override
  String get cancel => 'Cancelar';

  @override
  String get listeningActive => 'Ouvindo…';

  @override
  String get listeningInactive => 'Escuta pausada';

  @override
  String get flash_error_101 => 'A entrada de áudio não é permitida.';

  @override
  String get flash_error_101_hint => 'O FlashChords não tem permissão para acessar o microfone. Ative o acesso ao microfone nas configurações do dispositivo e reinicie o app.';

  @override
  String get flash_error_102 => 'Não foi possível iniciar a escuta de áudio.';

  @override
  String get flash_error_102_hint => 'O FlashChords não conseguiu inicializar o sistema de áudio. Verifique se nenhum outro app está usando o microfone e reinicie o app.';

  @override
  String get flash_error_103 => 'A entrada de áudio foi interrompida.';

  @override
  String get flash_error_103_hint => 'A escuta parou devido a uma interrupção de áudio. Verifique a conexão do microfone e reinicie a escuta.';

  @override
  String get flash_error_201 => 'Ocorreu um erro interno.';

  @override
  String get flash_error_201_hint => 'O FlashChords encontrou um erro inesperado. Reinicie o app. Se o problema persistir, entre em contato com o suporte com este código de erro.';

  @override
  String get flash_error_301 => 'Pelo menos um valor deve ser selecionado.';

  @override
  String get flash_error_301_hint => 'Sua última desmarcação foi selecionada novamente para garantir que um valor esteja selecionado. Para desmarcá-lo, selecione outro valor primeiro.';

  @override
  String get language_picker_scroll_hint => 'Role para ver mais idiomas';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'Como funciona';

  @override
  String get howItWorksBody => 'Coloque seu dispositivo no piano. Para cada cartão, toque o acorde mostrado. Se o ouvinte estiver ativado (Configuração) e você tocar as teclas corretas antes do timer acabar (se estiver ativado), o FlashChords™ marcará como correto e mostrará o próximo cartão. Se o ouvinte estiver desativado, marque você mesmo: marca de verificação ou deslize para a direita para correto, X ou deslize para a esquerda para incorreto. Toque no cartão para ver as teclas esperadas.\n\nObservação: acordes em oitavas muito baixas podem ser mais difíceis de detectar em alguns dispositivos ou teclados.';

  @override
  String get upgradeReenableListener => 'Upgrade to re-enable the listener';
}
