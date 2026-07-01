import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/splash_screen.dart';
import '../../features/vehicle_lookup/presentation/vehicle_lookup_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/vehicle_details/presentation/vehicle_details_screen.dart';
import '../../features/extra_features/presentation/extra_features_screen.dart';
import '../../features/keys/presentation/keys_screen.dart';
import '../../features/finance/presentation/finance_screen.dart';
import '../../features/running_condition/presentation/running_condition_screen.dart';
import '../../features/mechanical_issues/presentation/mechanical_issues_screen.dart';
import '../../features/photos/presentation/photo_introduction_screen.dart';
import '../../features/photos/presentation/photo_ready_screen.dart';
import '../../features/photos/presentation/exterior_photos_screen.dart';
import '../../features/photos/presentation/guided_capture_screen.dart';
import '../../features/photos/presentation/interior_photos_screen.dart';
import '../../features/condition_damage/presentation/condition_damage_screen.dart';
import '../../features/service_history/presentation/service_history_screen.dart';
import '../../features/review/presentation/review_screen.dart';
import '../../features/submission_status/presentation/submission_status_screen.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.vehicleLookup,
      name: 'vehicleLookup',
      builder: (context, state) => const VehicleLookupScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.vehicleDetails,
      name: 'vehicleDetails',
      builder: (context, state) => const VehicleDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.extraFeatures,
      name: 'extraFeatures',
      builder: (context, state) => const ExtraFeaturesScreen(),
    ),
    GoRoute(
      path: AppRoutes.keys,
      name: 'keys',
      builder: (context, state) => const KeysScreen(),
    ),
    GoRoute(
      path: AppRoutes.finance,
      name: 'finance',
      builder: (context, state) => const FinanceScreen(),
    ),
    GoRoute(
      path: AppRoutes.runningCondition,
      name: 'runningCondition',
      builder: (context, state) => const RunningConditionScreen(),
    ),
    GoRoute(
      path: AppRoutes.mechanicalIssues,
      name: 'mechanicalIssues',
      builder: (context, state) => const MechanicalIssuesScreen(),
    ),
    GoRoute(
      path: AppRoutes.photoIntroduction,
      name: 'photoIntroduction',
      builder: (context, state) => const PhotoIntroductionScreen(),
    ),
    GoRoute(
      path: AppRoutes.photoReady,
      name: 'photoReady',
      builder: (context, state) => const PhotoReadyScreen(),
    ),
    GoRoute(
      path: AppRoutes.exteriorPhotos,
      name: 'exteriorPhotos',
      builder: (context, state) => const ExteriorPhotosScreen(),
    ),
    GoRoute(
      path: AppRoutes.guidedCapture,
      name: 'guidedCapture',
      builder: (context, state) => const GuidedCaptureScreen(),
    ),
    GoRoute(
      path: AppRoutes.interiorPhotos,
      name: 'interiorPhotos',
      builder: (context, state) => const InteriorPhotosScreen(),
    ),
    GoRoute(
      path: AppRoutes.conditionDamage,
      name: 'conditionDamage',
      builder: (context, state) => const ConditionDamageScreen(),
    ),
    GoRoute(
      path: AppRoutes.serviceHistory,
      name: 'serviceHistory',
      builder: (context, state) => const ServiceHistoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.review,
      name: 'review',
      builder: (context, state) => const ReviewScreen(),
    ),
    GoRoute(
      path: AppRoutes.submissionStatus,
      name: 'submissionStatus',
      builder: (context, state) => const SubmissionStatusScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Route not found: ${state.uri.path}'),
    ),
  ),
);
