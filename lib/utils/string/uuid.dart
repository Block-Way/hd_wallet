part of utils;

String generateUuidV4WithoutDashes() => Uuid().v4().replaceAll('-', '');

String generateUuidV4() => Uuid().v4();
