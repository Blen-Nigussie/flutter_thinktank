import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/feedback_view_model.dart';
import '../models/idea.dart';
import '../services/token_manager.dart';
import 'idea_pool_list_screen.dart';
import 'feedback_screen.dart';
import 'reviewed_ideas_screen.dart';
import 'edit_feedback_screen.dart';

class AdminFeedbackNav extends StatelessWidget {
  final String token;
  final NavigatorState navController;
  final Function(Idea) onEditFeedback;
  final Function(Idea) onDeleteFeedback;

  const AdminFeedbackNav({
    Key? key,
    required this.token,
    required this.navController,
    required this.onEditFeedback,
    required this.onDeleteFeedback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokenManager = TokenManager();
    final userRole = tokenManager.getUserRole();

    if (userRole != "admin") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navController.pushReplacementNamed('dashboard');
      });
      return const SizedBox.shrink();
    }

    return ChangeNotifierProvider(
      create: (_) => FeedbackViewModel(),
      child: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (_) => IdeaPoolListScreen(
                  onReviewIdea: (idea) {
                    context.read<FeedbackViewModel>().selectIdea(idea);
                    Navigator.pushNamed(context, '/feedback_detail');
                  },
                  onViewReviewedIdeas: () {
                    Navigator.pushNamed(context, '/reviewed_ideas');
                  },
                  onBack: () {
                    navController.pushReplacementNamed('dashboard');
                  },
                ),
              );
            case '/feedback_detail':
              return MaterialPageRoute(
                builder: (_) => Consumer<FeedbackViewModel>(
                  builder: (context, viewModel, _) {
                    final selectedIdea = viewModel.uiState.selectedIdea;
                    if (selectedIdea != null) {
                      return FeedbackScreen(
                        navController: Navigator.of(context),
                        viewModel: viewModel,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            case '/reviewed_ideas':
              return MaterialPageRoute(
                builder: (_) => Consumer<FeedbackViewModel>(
                  builder: (context, viewModel, _) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      viewModel.loadApprovedIdeas(token);
                    });
                    return ReviewedIdeasScreen(
                      onBack: () {
                        navController.pushReplacementNamed('dashboard');
                      },
                      onEditFeedback: (idea) {
                        viewModel.selectIdea(idea);
                        Navigator.pushNamed(context, '/edit_feedback');
                      },
                      onDeleteFeedback: (idea) {
                        viewModel.deleteFeedback(token, int.parse(idea.id));
                      },
                      isAdmin: true,
                    );
                  },
                ),
              );
            case '/edit_feedback':
              return MaterialPageRoute(
                builder: (_) => Consumer<FeedbackViewModel>(
                  builder: (context, viewModel, _) {
                    final selectedIdea = viewModel.uiState.selectedIdea;
                    if (selectedIdea != null) {
                      return EditFeedbackScreen(
                        idea: selectedIdea,
                        currentFeedback: selectedIdea.feedback?.firstOrNull?.comment ?? "",
                        onSave: (newFeedback) {
                          viewModel.updateFeedback(
                            token: token,
                            ideaId: int.parse(selectedIdea.id),
                            feedback: newFeedback,
                          );
                          navController.pushReplacementNamed('dashboard');
                        },
                        onBack: () {
                          navController.pushReplacementNamed('dashboard');
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const SizedBox.shrink(),
              );
          }
        },
      ),
    );
  }
} 