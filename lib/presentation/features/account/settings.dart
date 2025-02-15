import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/theme/index.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  bool isDark = context.read<ThemeCubit>().isDarkTheme;
                  return SwitchListTile(
                    secondary:
                        Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                    title: Text("Switch ${isDark ? "Light" : "Dark"}"),
                    value: isDark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ));
  }
}
