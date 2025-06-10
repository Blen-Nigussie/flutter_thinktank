import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/dashboard_view_model.dart';
import '../widgets/drawer_content.dart';
import '../widgets/project_card.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardViewModel()..loadApprovedIdeas(),
      child: DashboardContent(),
    );
  }
}

class DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DashboardViewModel>(context);
    final uiState = viewModel.uiState;

    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        title: Center(
          child: Text(
            'ThinkTank',
            style: TextStyle(
              color: Color(0xFFFFA500),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFA500).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => viewModel.onDrawerOpen(),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerContent(),
      body: Builder(
        builder: (context) {
          if (uiState.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFA500),
              ),
            );
          }

          if (uiState.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    uiState.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadApprovedIdeas(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFA500),
                    ),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFA500).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/dashboard_bulb.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 24),

                  // Title Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Approved Ideas',
                        style: TextStyle(
                          color: Color(0xFFFFA500),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${uiState.approvedIdeas.length} Ideas',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Ideas Grid
                  if (uiState.approvedIdeas.isEmpty)
                    Center(
                      child: Text(
                        'No approved ideas yet',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: uiState.approvedIdeas.length,
                      itemBuilder: (context, index) {
                        final idea = uiState.approvedIdeas[index];
                        return ProjectCard(
                          idea: idea,
                          onTap: () {
                            // Handle idea tap
                            print('Clicked idea: ${idea.title}');
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 