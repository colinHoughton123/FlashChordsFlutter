// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get welcomeTitle => 'Bienvenue sur FlashChords';

  @override
  String get welcomeUpdate_Update => 'Mise à jour disponible';

  @override
  String get welcomeUpdate_Button_Later => 'Plus tard';

  @override
  String get welcomeUpdate_Button_Update => 'Mettre à jour';

  @override
  String get listenerLimitReachedTitle => 'Écoute désactivée';

  @override
  String listenerLimitReachedBody(Object limit) {
    return 'L’écoute a été désactivée après $limit cartes gratuites jouées. Passez à la version supérieure pour la réactiver.';
  }

  @override
  String freeUsageStatus(Object limit, Object played) {
    return 'Version gratuite : $played cartes avec écoute utilisées sur $limit';
  }

  @override
  String get listenerLimitDialogTitle => 'Limite gratuite atteinte';

  @override
  String listenerLimitDialogBody(Object price) {
    return 'FlashChords continuera de fonctionner, mais l’écoute est désactivée sauf si vous passez à la version supérieure pour $price.';
  }

  @override
  String get upgrade => 'Mettre à niveau';

  @override
  String get later => 'Plus tard';

  @override
  String get listenerInversionNoticeTitle => 'Note sur l’écoute';

  @override
  String get listenerInversionNoticePart1 => 'Vous avez sélectionné plus d’une inversion. Sachez que FlashChords ne peut pas « entendre » la différence entre les inversions. Les schémas de touches attendus seront affichés, mais un accord joué dans la mauvaise inversion sera marqué comme ';

  @override
  String get listenerInversionNoticeAny => '« correct »';

  @override
  String get listenerInversionNoticePart2 => '.';

  @override
  String get listenerInversionNoticeDontShow => 'Ne plus afficher';

  @override
  String get listenerInversionNoticeGotIt => 'OK';

  @override
  String get loadingChords => 'Chargement des accords...';

  @override
  String get start => 'Démarrer';

  @override
  String get configure => 'Configurer';

  @override
  String get mainCatchPhrase => 'Apprenez les accords en un éclair !';

  @override
  String get mainFeaturesTitle => 'Fonctionnalités';

  @override
  String get mainFeatures1Title => 'Sélectionnez vos accords';

  @override
  String get mainFeatures1Content => 'Choisissez les accords à pratiquer';

  @override
  String get mainFeatures2Title => 'Défis chronométrés';

  @override
  String get mainFeatures2Content => 'Testez votre temps de réaction avec des minuteurs personnalisés';

  @override
  String get mainFeatures3Title => 'Mode d’écoute en direct';

  @override
  String get mainFeatures3Content => 'Les accords sont automatiquement détectés et évalués';

  @override
  String get language_picker_title => 'Choisir la langue';

  @override
  String get language_change_tooltip => 'Changer de langue';

  @override
  String get configTitle => 'Configuration';

  @override
  String get configSelectRoots => 'Sélectionner les accords';

  @override
  String get configSelectChordTypes => 'Sélectionner les types d’accords';

  @override
  String get configSelectInversions => 'Sélectionner les inversions';

  @override
  String get configEnableTimer => 'Activer le minuteur';

  @override
  String get configTimerSeconds => 'Minuteur (secondes)';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get configListener => 'Activer le microphone pour écouter et marquer Correct';

  @override
  String get configIncorrect => 'Si ce n\'est pas le premier accord après le démarrage du minuteur, marquez-le comme incorrect.';

  @override
  String get configAtLeastOneOption => 'Au moins une option doit être sélectionnée dans cette section. La dernière option a été re-sélectionnée. Veuillez réessayer.';

  @override
  String get configOK => 'OK';

  @override
  String get configEnableListening => 'Activer le mode Écoute (fonction à venir)';

  @override
  String get configEnableListeningDesc => 'Marquer automatiquement l’accord comme correct lorsque la détection audio correspond.';

  @override
  String get chord_major => 'Majeur';

  @override
  String get chord_minor => 'Mineur';

  @override
  String get chord_diminished => 'Diminué';

  @override
  String get chord_dominant7 => 'Septième de dominante';

  @override
  String get chord_major7 => 'Septième majeure';

  @override
  String get chord_minor7 => 'Septième mineure';

  @override
  String get chord_suspended2 => 'Suspendu 2';

  @override
  String get chord_suspended4 => 'Suspendu 4';

  @override
  String get chord_augmented => 'Augmenté';

  @override
  String get inv_root => 'Position fondamentale';

  @override
  String get inv_first => '1re inversion';

  @override
  String get inv_second => '2e inversion';

  @override
  String get configCardOrder => 'Ordre des cartes';

  @override
  String get configCardOrderRandom => 'Aléatoire';

  @override
  String get configCardOrderSorted => 'Trié';

  @override
  String get flash_incorrectCountLabel => 'Incorrect';

  @override
  String get flash_correctCountLabel => 'Correct';

  @override
  String get flash_playingMainDeck => 'Lecture du paquet principal';

  @override
  String get flash_playingErrorDeck => 'Lecture du paquet d’erreurs';

  @override
  String get flash_redoButton => 'REFAIRE';

  @override
  String get flash_playedLabel => 'jouées';

  @override
  String get flash_toGoLabel => 'restantes';

  @override
  String get flash_averageTimeLabel => 'Temps moyen :';

  @override
  String get flash_timeLabel => 'Minuteur';

  @override
  String get flash_timerCancelled => 'Minuteur annulé';

  @override
  String get flash_reveal => 'Afficher l’accord';

  @override
  String get flash_play_instruction => 'Jouez l’accord suivant\nsélectionné aléatoirement dans le paquet principal';

  @override
  String get flash_swipe_right => 'Glissez à droite si vous l’avez joué correctement';

  @override
  String get flash_swipe_left => 'Glissez à gauche si vous l’avez joué incorrectement';

  @override
  String get flash_not_sure => 'Pas sûr ? Touchez la carte pour voir le doigté';

  @override
  String get flash_welcome1 => 'Le nom d’un accord s’affichera ici';

  @override
  String get flash_welcome2 => 'Jouez-le sur votre piano';

  @override
  String get flash_incorrect_count => 'Nombre d’erreurs';

  @override
  String get flash_correct_count => 'Nombre de réussites';

  @override
  String get flash_playing_main => 'Lecture du paquet principal';

  @override
  String get flash_playing_wrong => 'Lecture des erreurs';

  @override
  String get flash_play_again => 'Rejouer';

  @override
  String get flash_average_time => 'Temps moyen';

  @override
  String flash_cards_played(Object played, Object remaining) {
    return '$played jouées, $remaining restantes';
  }

  @override
  String get flash_mainDeck => 'Paquet principal';

  @override
  String get flash_errorDeck => 'Paquet d’erreurs';

  @override
  String get flash_correct => 'Correct';

  @override
  String get flash_incorrect => 'Incorrect';

  @override
  String get flash_of => 'sur';

  @override
  String get flash_next => 'Suivant';

  @override
  String get summary_title => 'Résumé';

  @override
  String get summary_correct => 'Correct';

  @override
  String get summary_incorrect => 'Incorrect';

  @override
  String get summary_cards => 'Cartes';

  @override
  String get summary_average_time => 'Temps moyen';

  @override
  String get summary_seconds => 'secondes';

  @override
  String get summary_from_main_deck => 'Paquet principal';

  @override
  String get summary_from_error_deck => 'Paquet d’erreurs';

  @override
  String get summary_play_again => 'Rejouer avec le paquet d’erreurs';

  @override
  String get summary_done => 'Recommencer';

  @override
  String get summary_accuracy => 'Précision';

  @override
  String get summary_average_time_correct => 'Moyenne (accords corrects)';

  @override
  String get summary_average_time_all => 'Temps moyen (tous les accords)';

  @override
  String get summary_unsaved_changes_title => 'Vous n’avez pas enregistré vos modifications';

  @override
  String get summary_unsaved_changes_body => 'Vous avez modifié la configuration. Si vous voulez enregistrer, appuyez sur ANNULER maintenant, puis sur ENREGISTRER.';

  @override
  String get summary_discard => 'Ignorer les modifications';

  @override
  String get cancel => 'Annuler';

  @override
  String get listeningActive => 'Écoute…';

  @override
  String get listeningInactive => 'Écoute en pause';

  @override
  String get flash_error_101 => 'L’entrée audio n’est pas autorisée.';

  @override
  String get flash_error_101_hint => 'FlashChords n’a pas l’autorisation d’accéder au microphone. Veuillez activer l’accès au microphone dans les réglages de votre appareil et redémarrer l’app.';

  @override
  String get flash_error_102 => 'Impossible de démarrer l’écoute audio.';

  @override
  String get flash_error_102_hint => 'FlashChords n’a pas pu initialiser le système audio. Vérifiez qu’aucune autre app n’utilise le microphone et redémarrez l’app.';

  @override
  String get flash_error_103 => 'L’entrée audio a été interrompue.';

  @override
  String get flash_error_103_hint => 'L’écoute s’est arrêtée en raison d’une interruption audio. Vérifiez la connexion de votre microphone et relancez l’écoute.';

  @override
  String get flash_error_201 => 'Une erreur interne s’est produite.';

  @override
  String get flash_error_201_hint => 'FlashChords a rencontré une erreur inattendue. Veuillez redémarrer l’app. Si le problème persiste, contactez le support avec ce code d’erreur.';

  @override
  String get flash_error_301 => 'Au moins une valeur doit être sélectionnée.';

  @override
  String get flash_error_301_hint => 'Votre dernière désélection a été re-sélectionnée afin de garantir qu’une valeur est sélectionnée. Pour la désélectionner, sélectionnez d’abord une autre valeur.';

  @override
  String get language_picker_scroll_hint => 'Faites défiler pour voir plus de langues';

  @override
  String get listenerStarting => 'Starting listener...';

  @override
  String get howItWorksTitle => 'Comment ça marche';

  @override
  String get howItWorksBody => 'Placez votre appareil sur votre piano. Pour chaque carte, jouez l’accord affiché. Si l’écouteur est activé (Configuration) et que vous jouez les bonnes touches avant la fin du minuteur (s’il est activé), FlashChords™ le marquera comme correct et affichera la carte suivante. Si l’écouteur est désactivé, marquez-le vous‑même : coche ou glissement vers la droite pour correct, X ou glissement vers la gauche pour incorrect. Touchez la carte pour voir les touches attendues.\n\nRemarque : les accords dans des octaves très basses peuvent être plus difficiles à détecter sur certains appareils ou claviers.';

  @override
  String get upgradeReenableListener => 'Mettre à niveau pour réactiver l’écouteur';
}
