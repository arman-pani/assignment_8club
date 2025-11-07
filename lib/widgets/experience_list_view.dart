import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/models/experience_model.dart';
import 'package:assignment_8club/utils/helpers.dart';
import 'package:flutter/material.dart';

// class ExperienceListView extends StatelessWidget {
//   final ExperienceLoaded state;
//   const ExperienceListView({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  const ExperienceCard({
    super.key,
    required this.onTap,
    required this.experience,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: (getDegreeRotation(index)) * 3.141 / 180,
        child: _buildImage(isSelected)
      ),
    );
  }

  Widget _buildImage(bool isSelected) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(
      isSelected ? <double>[
        1, 0, 0, 0, 0,
        0, 1, 0, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 0, 1, 0,
      ] : _grayscaleMatrix, 
    ),
      child: Image.network(
        experience.imageUrl,
        colorBlendMode: isSelected ? BlendMode.srcIn : null,
        width: 96,
        height: 96,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryAccent),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.broken_image, color: AppColors.text5),
            ),
          );
        },
      ),
    );
  }
  
}

const List<double> _grayscaleMatrix = <double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
];
