class Profiles {
  // final String owneruid;
  final String docuid;
  final String title;
  final String encryptedemail;
  final String encryptedpass;
  final String key;

  Profiles({
    required this.docuid,
    required this.title,
    required this.encryptedemail,
    required this.encryptedpass,
    required this.key,
  });
}
