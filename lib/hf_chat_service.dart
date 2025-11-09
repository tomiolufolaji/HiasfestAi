import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HFChatService {
  final String apiKey = "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";
  final String apiUrl = "https://router.huggingface.co/v1/chat/completions";
  final Duration timeout = const Duration(seconds: 30);

  Future<String> sendMessage(String userMessage) async {
    try {
      final headers = {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      };

      final body = jsonEncode({
        "messages": [
          {"role": "user", "content": userMessage},
        ],
        "model": "openai/gpt-oss-20b:groq",
        "stream": false,
      });

      final response = await http
          .post(Uri.parse(apiUrl), headers: headers, body: body)
          .timeout(timeout);

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          final content = data["choices"]?[0]?["message"]?["content"];
          if (content != null && content.toString().isNotEmpty) {
            return content.toString();
          } else {
            return "No response content found in the API response.";
          }
        } catch (e) {
          return "Error parsing response: $e";
        }
      } else {
        return "Error ${response.statusCode}: ${response.body}";
      }
    } on TimeoutException {
      return "Request timed out after ${timeout.inSeconds} seconds. Please try again.";
    } on http.ClientException catch (e) {
      return "Network error: ${e.message}. Please check your internet connection.";
    } on FormatException catch (e) {
      return "Error parsing response: $e";
    } on Exception catch (e) {
      return "Unexpected error: $e";
    }
  }
}
