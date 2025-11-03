import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.white,
          ],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'My Projects',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Here are some of my recent works',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildProjectCard(
            context,
            title: 'E-Commerce Website',
            description: 'A full-stack e-commerce platform with payment integration, user authentication, and admin dashboard.',
            technologies: ['Flutter', 'Firebase', 'Stripe'],
            imageIcon: Icons.shopping_cart,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildProjectCard(
            context,
            title: 'Task Management App',
            description: 'A productivity app for managing tasks with real-time collaboration features and cloud sync.',
            technologies: ['Flutter', 'Firebase', 'Cloud Firestore'],
            imageIcon: Icons.task_alt,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          _buildProjectCard(
            context,
            title: 'Portfolio Website',
            description: 'A responsive portfolio website showcasing projects and skills with modern design.',
            technologies: ['React', 'Node.js', 'MongoDB'],
            imageIcon: Icons.web,
            color: Colors.purple,
          ),
          const SizedBox(height: 16),
          _buildProjectCard(
            context,
            title: 'Social Media Dashboard',
            description: 'Analytics dashboard for social media metrics with real-time data visualization.',
            technologies: ['Flutter', 'REST API', 'Charts'],
            imageIcon: Icons.dashboard,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildProjectCard(
            context,
            title: 'Weather App',
            description: 'Beautiful weather forecast app with location-based services and detailed weather information.',
            technologies: ['Flutter', 'Weather API', 'Geolocation'],
            imageIcon: Icons.cloud,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String title,
    required String description,
    required List<String> technologies,
    required IconData imageIcon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                imageIcon,
                size: 80,
                color: color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: technologies.map((tech) {
                    return Chip(
                      label: Text(
                        tech,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: color.withOpacity(0.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.link, size: 18),
                      label: const Text('View Project'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
