import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/profile_view_model_provider.dart';
import '../core/providers/auth_view_model_provider.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileViewModelProvider);
    final profileViewModel = ref.read(profileViewModelProvider.notifier);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authViewModel.logout(),
          ),
        ],
      ),
      body: profileState.isLoading
          ? Center(child: CircularProgressIndicator())
          : profileState.error != null
              ? Center(child: Text(profileState.error!, style: TextStyle(color: Colors.red)))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${profileState.profile?.name ?? "N/A"}'),
                      Text('Email: ${profileState.profile?.email ?? "N/A"}'),
                      Text('Role: ${profileState.profile?.role ?? "N/A"}'),
                    ],
                  ),
                ),
    );
  }
} 