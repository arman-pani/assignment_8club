import 'package:assignment_8club/bloc/experience/experience_bloc.dart';
import 'package:assignment_8club/bloc/experience/experience_event.dart';
import 'package:assignment_8club/bloc/experience/experience_state.dart';
import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_strings.dart';
import 'package:assignment_8club/constants/app_textstyles.dart';
import 'package:assignment_8club/widgets/experience_list_view.dart';
import 'package:assignment_8club/widgets/multiline_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExperienceSelectionScreen extends StatefulWidget {
  const ExperienceSelectionScreen({super.key});

  @override
  State<ExperienceSelectionScreen> createState() =>
      _ExperienceSelectionScreenState();
}

class _ExperienceSelectionScreenState extends State<ExperienceSelectionScreen> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExperienceBloc>().add(LoadExperiencesEvent());
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ExperienceBloc, ExperienceState>(
        builder: (context, state) {
          if (state is ExperienceLoading || state is ExperienceInitial) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryAccent),
            );
          }

          if (state is ExperienceError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.b2.copyWith(color: Colors.red),
              ),
            );
          }

          final experiences = (state as ExperienceLoaded).experiences;
          final selectedExperiences = state.selectedExperiences;
          return Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                spacing: 4.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.first,
                    style: AppTextStyles.s1.copyWith(color: AppColors.text5),
                  ),
                  Text(
                    AppStrings.experienceSelectionTitle,
                    style: AppTextStyles.b2.copyWith(color: AppColors.text1),
                  ),
                ],
              ),
              SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: experiences.length,
                  itemBuilder: (context, index) {
                    final experience = experiences[index];
                    final isSelected = selectedExperiences.contains(experience);
                    return ExperienceCard(
                      experience: experience,
                      index: index,
                      isSelected: isSelected,
                      onTap: () => context.read<ExperienceBloc>().add(
                        SelectExperienceEvent(experience),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12.0),
                ),
              ),
              MultilineTextfield(
                controller: _textController,
                maxLines: 5,
                maxLength: 250,
                hintText: AppStrings.experienceSelectionHint,
                onChanged: (value) {
                  context.read<ExperienceBloc>().add(UpdateExperienceDescriptionEvent(value));
                },
              ),
            ],
          );
        },
    );
  }
}
