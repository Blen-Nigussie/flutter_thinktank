import 'dart:convert';
import 'package:flutter/foundation.dart';

class JwtUtils {
  static int? getUserIdFromToken(String token) {
    try {
      // Remove "Bearer " prefix if present
      final actualToken = token.startsWith("Bearer ") ? token.substring(7) : token;

      // Split the token into parts
      final parts = actualToken.split('.');
      if (parts.length != 3) {
        debugPrint('Invalid token format');
        return null;
      }

      // Decode the payload (second part)
      final payload = utf8.decode(base64Url.decode(parts[1]));
      final jsonObject = json.decode(payload);
      
      // Get the user ID from the payload
      final userId = jsonObject['sub'];
      if (userId == null || userId == 0) {
        debugPrint('No user ID found in token');
        return null;
      }
      
      return userId is int ? userId : int.tryParse(userId.toString());
    } catch (e) {
      debugPrint('Error decoding token: $e');
      return null;
    }
  }
} 