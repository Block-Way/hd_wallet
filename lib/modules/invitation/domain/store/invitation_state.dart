part of invitation_domain_module;

abstract class InvitationState
    implements Built<InvitationState, InvitationStateBuilder> {
// Constructors

  factory InvitationState() {
    return _$InvitationState._(
      invitations: BuiltList(),
      invitationCodes: BuiltList(),
    );
  }

  InvitationState._();

  static Serializer<InvitationState> get serializer =>
      _$invitationStateSerializer;

  BuiltList<Invitation> get invitations;

  BuiltList<InvitationCode> get invitationCodes;
}
