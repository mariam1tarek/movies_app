import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/common/localization/locale_view_model.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = LocaleViewModel.instance;

    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.yellow, width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Flag(
                flag: '🇺🇸',
                selected: !vm.isArabic,
                onTap: () => vm.setLocale(const Locale('en')),
              ),
              const SizedBox(width: 6),
              _Flag(
                flag: '🇪🇬',
                selected: vm.isArabic,
                onTap: () => vm.setLocale(const Locale('ar')),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Flag extends StatelessWidget {
  const _Flag({required this.flag, required this.selected, required this.onTap});

  final String flag;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.yellow : Colors.transparent,
        ),
        child: Text(flag, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
