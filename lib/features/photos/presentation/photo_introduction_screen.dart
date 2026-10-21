import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';

class PhotoIntroductionScreen extends ConsumerWidget {
  const PhotoIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => context.push(AppRoutes.exteriorPhotos),
        child: SizedBox.expand(
          child: Image.asset(
            'assets/images/arte-2.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
