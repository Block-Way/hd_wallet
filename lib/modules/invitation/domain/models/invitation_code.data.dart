part of invitation_domain_module;

class InvitationCodeData {
  InvitationCodeData({
    required this.subSign,
    required this.sharePrvKey,
  });
  final String subSign;
  final String sharePrvKey;
}
