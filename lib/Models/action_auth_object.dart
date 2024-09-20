class ActionAuthObject {
  final int AuthType; //TODO: Make Enum
  final Map<String, String> Headers;

  ActionAuthObject({required this.AuthType, required this.Headers});

  factory ActionAuthObject.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"AuthType": int authType, "AuthHeaders": Map<String, String> headers} =>
        ActionAuthObject(AuthType: authType, Headers: headers),
      _ => throw const FormatException("Failed to format object.")
    };
  }
}
