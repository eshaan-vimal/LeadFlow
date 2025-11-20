import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/repositories/lead_repository.dart';
import 'logic/bloc/lead_bloc.dart';
import 'logic/bloc/lead_event.dart';
import 'logic/bloc/theme_cubit.dart';
import 'presentation/screens/home_screen.dart';


void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) 
  {
    return RepositoryProvider(
      create: (context) => LeadRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LeadBloc(
              repository: RepositoryProvider.of<LeadRepository>(context),
            )..add(LoadLeads()),
          ),
          BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: 'LeadFlow',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              
              // Light Theme
              theme: ThemeData(
                brightness: Brightness.light,
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF2563EB),
                  surface: const Color(0xFFF8FAFC),
                ),
                textTheme: GoogleFonts.interTextTheme(),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                ),
              ),

              // Dark Theme
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: const Color(0xFF2563EB),
                  surface: const Color(0xFF121212), // Dark background
                ),
                scaffoldBackgroundColor: const Color(0xFF121212),
                textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                ),
              ),

              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}