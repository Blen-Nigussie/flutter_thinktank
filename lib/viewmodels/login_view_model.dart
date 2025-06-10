import 'package:flutter/material.dart';
import '../models/login_ui_state.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  LoginUiState _uiState = LoginUiState();

  LoginViewModel({ApiService? apiService, TokenManager? tokenManager})
      : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager();

  LoginUiState get uiState => _uiState;

  void updateEmail(String email) {
    _uiState = _uiState.copyWith(email: email);
    notifyListeners();
  }

  void updatePassword(String password) {
    _uiState = _uiState.copyWith(password: password);
    notifyListeners();
  }

  Future<void> login() async {
    if (_uiState.email.isEmpty || _uiState.password.isEmpty) {
      _uiState = _uiState.copyWith(error: 'Please enter both email and password');
      notifyListeners();
      return;
    }

    _uiState = _uiState.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final response = await _apiService.login(
        email: _uiState.email,
        password: _uiState.password,
      );

      if (response.accessToken != null) {
        await _tokenManager.saveToken(response.accessToken!);
        _uiState = _uiState.copyWith(isLoading: false);
      } else {
        _uiState = _uiState.copyWith(
          isLoading: false,
          error: 'Login failed: No token received',
        );
      }
    } catch (e) {
      String errorMessage;
      if (e is SocketTimeoutException) {
        errorMessage = 'Connection timed out. Please try again';
      } else if (e is UnknownHostException) {
        errorMessage = 'Cannot reach server. Please check your connection';
      } else {
        errorMessage = 'Login failed: ${e.toString()}';
      }
      _uiState = _uiState.copyWith(isLoading: false, error: errorMessage);
    }
    notifyListeners();
  }
} 