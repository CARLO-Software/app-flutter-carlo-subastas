import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_screen.dart';
import '../../features/auth/presentation/loading_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/vehicle_lookup/presentation/vehicle_lookup_screen.dart';
import '../../features/vehicle_lookup/presentation/vehicle_result_screen.dart';
import '../../features/onboarding/presentation/notification_permission_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/vehicle_details/presentation/vehicle_info_hub_screen.dart';
import '../../features/vehicle_details/presentation/vehicle_details_screen.dart';
import '../../features/extra_features/presentation/extra_features_screen.dart';
import '../../features/keys/presentation/keys_screen.dart';
import '../../features/finance/presentation/finance_screen.dart';
import '../../features/running_condition/presentation/running_condition_screen.dart';
import '../../features/mechanical_issues/presentation/mechanical_issues_screen.dart';
import '../../features/photos/presentation/photo_introduction_screen.dart';
import '../../features/photos/presentation/exterior_photos_screen.dart';
import '../../features/photos/presentation/guided_capture_screen.dart';
import '../../features/photos/presentation/interior_photos_screen.dart';
import '../../features/proof_of_purchase/presentation/proof_of_purchase_screen.dart';
import '../../features/smoking/presentation/smoking_screen.dart';
import '../../features/private_plate/presentation/private_plate_screen.dart';
import '../../features/photos/presentation/wheels_photos_screen.dart';
import '../../features/tire_condition/presentation/tire_condition_screen.dart';
import '../../features/seat_material/presentation/seat_material_screen.dart';
import '../../features/tool_pack/presentation/tool_pack_screen.dart';
import '../../features/locking_wheel_nut/presentation/locking_wheel_nut_screen.dart';
import '../../features/paintwork/presentation/paintwork_problems_screen.dart';
import '../../features/broken_fittings/presentation/broken_fittings_screen.dart';
import '../../features/wheel_damage/presentation/wheel_damage_screen.dart';
import '../../features/photos/presentation/tire_photos_screen.dart';
import '../../features/tire_condition/presentation/tire_damage_screen.dart';
import '../../features/condition_damage/presentation/condition_damage_screen.dart';
import '../../features/condition_damage/presentation/warning_lights_screen.dart';
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
      path: AppRoutes.auth,
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: AppRoutes.loading,
      name: 'loading',
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: AppRoutes.vehicleLookup,
      name: 'vehicleLookup',
      builder: (context, state) => const VehicleLookupScreen(),
    ),
    GoRoute(
      path: AppRoutes.vehicleResult,
      name: 'vehicleResult',
      builder: (context, state) => const VehicleResultScreen(),
    ),
    GoRoute(
      path: AppRoutes.notificationPermission,
      name: 'notificationPermission',
      builder: (context, state) => const NotificationPermissionScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.vehicleInfoHub,
      name: 'vehicleInfoHub',
      builder: (context, state) => const VehicleInfoHubScreen(),
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
      path: AppRoutes.proofOfPurchase,
      name: 'proofOfPurchase',
      builder: (context, state) => const ProofOfPurchaseScreen(),
    ),
    GoRoute(
      path: AppRoutes.smoking,
      name: 'smoking',
      builder: (context, state) => const SmokingScreen(),
    ),
    GoRoute(
      path: AppRoutes.privatePlate,
      name: 'privatePlate',
      builder: (context, state) => const PrivatePlateScreen(),
    ),
    GoRoute(
      path: AppRoutes.wheelsPhotos,
      name: 'wheelsPhotos',
      builder: (context, state) => const WheelsPhotosScreen(),
    ),
    GoRoute(
      path: AppRoutes.tireCondition,
      name: 'tireCondition',
      builder: (context, state) => const TireConditionScreen(),
    ),
    GoRoute(
      path: AppRoutes.seatMaterial,
      name: 'seatMaterial',
      builder: (context, state) => const SeatMaterialScreen(),
    ),
    GoRoute(
      path: AppRoutes.toolPack,
      name: 'toolPack',
      builder: (context, state) => const ToolPackScreen(),
    ),
    GoRoute(
      path: AppRoutes.lockingWheelNut,
      name: 'lockingWheelNut',
      builder: (context, state) => const LockingWheelNutScreen(),
    ),
    GoRoute(
      path: AppRoutes.paintworkProblems,
      name: 'paintworkProblems',
      builder: (context, state) => const PaintworkProblemsScreen(),
    ),
    GoRoute(
      path: AppRoutes.brokenFittings,
      name: 'brokenFittings',
      builder: (context, state) => const BrokenFittingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.wheelDamage,
      name: 'wheelDamage',
      builder: (context, state) => const WheelDamageScreen(),
    ),
    GoRoute(
      path: AppRoutes.tirePhotos,
      name: 'tirePhotos',
      builder: (context, state) => const TirePhotosScreen(),
    ),
    GoRoute(
      path: AppRoutes.tireDamage,
      name: 'tireDamage',
      builder: (context, state) => const TireDamageScreen(),
    ),
    GoRoute(
      path: AppRoutes.warningLights,
      name: 'warningLights',
      builder: (context, state) => const WarningLightsScreen(),
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
