part of invitation_domain_module;

@HiveType(typeId: kHiveTypeInvitationCode)
class InvitationCode extends HiveObject {
  InvitationCode() {
    //
  }

  factory InvitationCode.create({
    @required String chain,
    @required String symbol,
    @required String fork,
    @required String address,
    @required String subSign,
    @required String sharePrvKey,
  }) =>
      InvitationCode()
        ..chain = chain
        ..symbol = symbol
        ..fork = fork
        ..address = address
        ..subSign = subSign
        ..sharePrvKey = sharePrvKey
        ..createdAt = SystemDate.getTime();

  @HiveField(0)
  String chain;
  @HiveField(1)
  String symbol;
  @HiveField(2)
  String fork;
  @HiveField(4)
  String address;

  @HiveField(5)
  String subSign;
  @HiveField(6)
  String sharePrvKey;

  @HiveField(7)
  int createdAt;
}
