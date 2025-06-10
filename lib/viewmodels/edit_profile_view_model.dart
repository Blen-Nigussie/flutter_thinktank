import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import '../models/edit_profile_ui_state.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';
import '../utils/jwt_utils.dart';

class EditProfileViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  EditProfileUiState _uiState = EditProfileUiState();
  int? _currentUserId;

  EditProfileUiState get uiState => _uiState;

  EditProfileViewModel({
    ApiService? apiService,
    TokenManager? tokenManager,
  })  : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      _updateState(isLoading: true, error: null);
      final token = await _tokenManager.getToken();
      if (token != null) {
        final userId = JwtUtils.getUserIdFromToken(token);
        if (userId == null) {
          _updateState(
            error: "Could not get user ID from token",
            isLoading: false,
          );
          return;
        }

        _currentUserId = userId;

        // Get user profile
        final userResponse = await _apiService.getUserProfile(token, userId);
        if (userResponse.statusCode == 200) {
          final userData = json.decode(userResponse.body);
          final profileId = userData['profile']?['id'];

          if (profileId == null) {
            // Create new profile
            final createRequest = {
              'fullName': '${userData['firstName']} ${userData['lastName']}',
              'email': userData['email'],
              'profilePicture': null,
            };

            final createResponse = await _apiService.createProfile(token, createRequest);
            if (createResponse.statusCode == 200) {
              final profileData = json.decode(createResponse.body);
              _updateState(
                firstName: userData['firstName'],
                lastName: userData['lastName'],
                email: userData['email'],
                profilePicture: profileData['profilePicture'],
                isLoading: false,
              );
            } else {
              _updateState(
                error: "Failed to create profile: ${createResponse.reasonPhrase}",
                isLoading: false,
              );
            }
          } else {
            // Get existing profile
            final profileResponse = await _apiService.getProfile(token, profileId);
            if (profileResponse.statusCode == 200) {
              final profileData = json.decode(profileResponse.body);
              _updateState(
                firstName: userData['firstName'],
                lastName: userData['lastName'],
                email: userData['email'],
                profilePicture: profileData['profilePicture'],
                isLoading: false,
              );
            } else {
              _updateState(
                error: "Failed to load profile: ${profileResponse.reasonPhrase}",
                isLoading: false,
              );
            }
          }
        } else {
          _updateState(
            error: "Failed to load user profile: ${userResponse.reasonPhrase}",
            isLoading: false,
          );
        }
      } else {
        _updateState(
          error: "No token found",
          isLoading: false,
        );
      }
    } catch (e) {
      _updateState(
        error: "Failed to connect to server: $e",
        isLoading: false,
      );
    }
  }

  void onFieldChange(EditProfileUiState Function(EditProfileUiState) updater) {
    _uiState = updater(_uiState);
    notifyListeners();
  }

  Future<void> onSaveChanges() async {
    try {
      _updateState(isLoading: true, error: null);
      final token = await _tokenManager.getToken();
      if (token != null) {
        final userId = _currentUserId;
        if (userId == null) {
          _updateState(
            error: "User ID not found. Please try again.",
            isLoading: false,
          );
          return;
        }

        final updateRequest = {
          'firstName': _uiState.firstName,
          'lastName': _uiState.lastName,
          'email': _uiState.email,
        };

        final userResponse = await _apiService.updateUser(token, userId, updateRequest);
        if (userResponse.statusCode == 200) {
          // Refresh user profile
          final refreshResponse = await _apiService.getUserProfile(token, userId);
          if (refreshResponse.statusCode == 200) {
            final userData = json.decode(refreshResponse.body);
            _updateState(
              firstName: userData['firstName'],
              lastName: userData['lastName'],
              email: userData['email'],
              isLoading: false,
              saveSuccess: true,
              error: null,
            );
          } else {
            _updateState(
              isLoading: false,
              saveSuccess: true,
              error: null,
            );
          }
        } else {
          _updateState(
            error: "Failed to update user: ${userResponse.reasonPhrase}",
            isLoading: false,
          );
        }
      } else {
        _updateState(
          error: "No token found. Please login again.",
          isLoading: false,
        );
      }
    } catch (e) {
      _updateState(
        error: "Failed to connect to server: $e",
        isLoading: false,
      );
    }
  }

  Future<void> uploadProfilePicture(String imagePath) async {
    try {
      _updateState(isLoading: true, error: null);
      final token = await _tokenManager.getToken();
      if (token != null) {
        final file = File(imagePath);
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('${_apiService.baseUrl}/api/profile/picture'),
        );

        request.headers['Authorization'] = 'Bearer $token';
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );

        final response = await request.send();
        if (response.statusCode == 200) {
          final responseData = await response.stream.bytesToString();
          final imageUrl = json.decode(responseData)['imageUrl'];
          _updateState(
            profilePicture: imageUrl,
            isLoading: false,
          );
        } else {
          _updateState(
            error: "Failed to upload image: ${response.reasonPhrase}",
            isLoading: false,
          );
        }
      }
    } catch (e) {
      _updateState(
        error: "Failed to connect to server: $e",
        isLoading: false,
      );
    }
  }

  void _updateState({
    String? firstName,
    String? lastName,
    String? email,
    String? profilePicture,
    bool? isLoading,
    String? error,
    bool? saveSuccess,
  }) {
    _uiState = _uiState.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      profilePicture: profilePicture,
      isLoading: isLoading,
      error: error,
      saveSuccess: saveSuccess,
    );
    notifyListeners();
  }
} 