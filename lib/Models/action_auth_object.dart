class ActionAuthObject {
  final int AuthType; //TODO: Make Enum
  final Map<String, String> Headers;

  ActionAuthObject({required this.AuthType, required this.Headers});

  factory ActionAuthObject.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"AuthType": int authType, "AuthHeaders": Map<String, dynamic> headers} =>
        ActionAuthObject(AuthType: authType, Headers: headers.map((key, value) => MapEntry(key, value.toString()))),
      _ => throw const FormatException("Failed to format object.")
    };
  }

  Map<String, dynamic> toJson(){
    return {"AuthType": AuthType, "AuthHeaders": Headers};
  }
}
