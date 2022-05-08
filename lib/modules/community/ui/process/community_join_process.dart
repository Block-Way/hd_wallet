part of community_ui_module;

class CommunityJoinProcess {
  static Future<void> checkCanJoin({
    @required BuildContext context,
    @required CommunityInfo info,
    @required Future<CommunityTeam> Function(String teamId) onGetTeamInfo,
    @required
        Future<bool> Function({String fork, String fromAddress}) onCheckOnChain,
    CommunityTeam team,
    Function(bool) onJoinResult,
  }) async {
    if (team != null ? !team.canJoin : !info.canJoin) {
      showJoinStatusDialog(
        context,
        message: tr('community:join_lbl_can_not_content'),
      );
      return;
    }

    try {
      LoadingDialog.show(context);
      final newTeam = team ?? await onGetTeamInfo(info.id);

      if (info.joinIsOnChain) {
        // Check again
        if (!newTeam.canJoin) {
          LoadingDialog.dismiss(context);
          showJoinStatusDialog(
            context,
            message: tr('community:join_lbl_can_not_content'),
          );
          return;
        }

        final success = await onCheckOnChain(
          fork: newTeam.fork,
          fromAddress: newTeam.owner,
        );

        LoadingDialog.dismiss(context);
        if (success != true) {
          showJoinStatusDialog(
            context,
            message: tr('community:join_msg_api_error'),
          );
          return;
        }
      }
      LoadingDialog.dismiss(context);
      // I can join
      if (info.joinIsOnChain) {
        showJoinOnChainDialog(
          context,
          newTeam?.options?.telegramAccount ?? '-',
        );
      } else {
        CommunityJoinPage.open(info, newTeam).then((value) {
          if (onJoinResult != null && value != null) {
            onJoinResult(value);
          }
        });
      }
    } catch (error) {
      LoadingDialog.dismiss(context);
      if (error is AssertionError) {
        showJoinStatusDialog(
          context,
          message: error.message.toString(),
        );
        return;
      }
      final responseError = Request().getResponseError(error);
      if (responseError.statusCode == 400) {
        showJoinStatusDialog(
          context,
          message: responseError.message,
        );
        return;
      }
      rethrow;
    }
  }
}
