import 'package:assignment_8club/bloc/experience/experience_bloc.dart';
import 'package:assignment_8club/bloc/onboarding_flow/onboarding_flow_cubit.dart';
import 'package:assignment_8club/bloc/question/question_bloc.dart';
import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_strings.dart';
import 'package:assignment_8club/repositories/experience_repository.dart';
import 'package:assignment_8club/scaffold_with_appbar.dart';
import 'package:assignment_8club/utils/dio_handler.dart';
import 'package:assignment_8club/utils/video_service.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHandler.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.base1,
          elevation: 0,
        ),
        scaffoldBackgroundColor: AppColors.base1,
      ),
      title: AppStrings.appName,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Dio>(create: (context) => DioHandler.dio),

          RepositoryProvider<ExperienceRepository>(
            create: (context) => ExperienceRepository(context.read<Dio>()),
          ),
          RepositoryProvider<VideoService>(create: (context) => VideoService()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ExperienceBloc>(
              create: (context) => ExperienceBloc(
                experienceRepository: context.read<ExperienceRepository>(),
              ),
            ),
            BlocProvider<QuestionBloc>(
              create: (context) {
                final playerController = PlayerController();
                final audioController = RecorderController()
                  ..androidEncoder = AndroidEncoder.aac
                  ..androidOutputFormat = AndroidOutputFormat.mpeg4
                  ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
                  ..sampleRate = 16000;
                return QuestionBloc(context.read<VideoService>(), audioController, playerController);
              },
            ),
            BlocProvider(create: (_) => OnboardingFlowCubit()),
          ],

          child: ScaffoldWithAppbar(),
        ),
      ),
    );
  }
}
