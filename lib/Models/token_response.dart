class TokenResponse {
  final String Message;
  final String Token;

  const TokenResponse({required this.Message, required this.Token});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {"Message": String Message, "Token": String Token} =>
        TokenResponse(Message: Message, Token: Token),
      _ => throw const FormatException("Failed to format response.")
    };
  }
}
