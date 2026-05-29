import 'package:dopamine_diary/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:dopamine_diary/core/common/cubits/locale/locale_cubit.dart';
import 'package:dopamine_diary/core/theme/theme.dart';
import 'package:dopamine_diary/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/analytics/bloc/analytics_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/detox/bloc/detox_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/home/bloc/home_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/log/bloc/activity_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/main_scaffold.dart';
import 'package:dopamine_diary/features/diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:dopamine_diary/init_dependencies.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // Init intl cho cả vi và en để DateFormat('E', '<locale>') chạy đúng.
  await initializeDateFormatting('vi', null);
  await initializeDateFormatting('en', null);
  runApp(
    MultiBlocProvider(
      providers: [
        // Core
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<LocaleCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        // Dopamine
        BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
        BlocProvider(create: (_) => serviceLocator<ActivityBloc>()),
        BlocProvider(create: (_) => serviceLocator<AnalyticsBloc>()),
        BlocProvider(create: (_) => serviceLocator<DetoxBloc>()),
        BlocProvider(create: (_) => serviceLocator<OnboardingBloc>()),
      ],
      child: const DopamineDiaryApp(),
    ),
  );
}

class DopamineDiaryApp extends StatelessWidget {
  const DopamineDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale?>(
      builder: (context, locale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dopamine Diary',
          theme: AppTheme.lightThemeMode,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MainScaffold(),
        );
      },
    );
  }
}
