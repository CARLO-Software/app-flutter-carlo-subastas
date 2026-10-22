import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/providers.dart';

const _warningLights = [
  {'id': 'check_engine', 'name': 'Check Engine', 'icon': Icons.engineering_outlined, 'color': Color(0xFF886F4C)},
  {'id': 'aceite', 'name': 'Aceite', 'icon': Icons.oil_barrel_outlined, 'color': Color(0xFF886F4C)},
  {'id': 'bateria', 'name': 'Batería', 'icon': Icons.battery_alert_outlined, 'color': Color(0xFF886F4C)},
  {'id': 'temperatura', 'name': 'Temperatura', 'icon': Icons.thermostat_outlined, 'color': Color(0xFF886F4C)},
  {'id': 'frenos', 'name': 'Frenos', 'icon': Icons.do_not_step_outlined, 'color': Color(0xFF7D3831)},
  {'id': 'abs', 'name': 'ABS', 'icon': Icons.blur_circular_outlined, 'color': Color(0xFF55778B)},
  {'id': 'airbag', 'name': 'Airbag', 'icon': Icons.airline_seat_recline_normal_outlined, 'color': Color(0xFF55778B)},
  {'id': 'presion_llantas', 'name': 'Presión de llantas', 'icon': Icons.tire_repair_outlined, 'color': Color(0xFF886F4C)},
  {'id': 'ninguna', 'name': 'Ninguna', 'icon': Icons.check_circle_outline, 'color': Color(0xFF707070)},
];

class WarningLightsScreen extends ConsumerStatefulWidget {
  const WarningLightsScreen({super.key});

  @override
  ConsumerState<WarningLightsScreen> createState() => _WarningLightsScreenState();
}

class _WarningLightsScreenState extends ConsumerState<WarningLightsScreen> {
  bool _isAnalyzing = false;

  Future<void> _analyze() async {
    setState(() => _isAnalyzing = true);
    ref.read(vehicleRegistrationProvider.notifier).confirmWarningLights();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    context.push(AppRoutes.vehicleInfoHub);
    setState(() => _isAnalyzing = false);
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(vehicleRegistrationProvider.select((s) => s.warningLights));

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Luces del tablero'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _isAnalyzing ? null : () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¿Alguna de estas luces permanece encendida cuando el motor está en marcha?',
                        style: AppTypography.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacing.vGapXs,
                      Text(
                        'Selecciona todas las que apliquen',
                        style: AppTypography.bodyMedium.copyWith(color: Colors.white54),
                      ),
                      AppSpacing.vGapXxl,
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.95,
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                        ),
                        itemCount: _warningLights.length,
                        itemBuilder: (context, index) {
                          final light = _warningLights[index];
                          final id = light['id'] as String;
                          final name = light['name'] as String;
                          final icon = light['icon'] as IconData;
                          final color = light['color'] as Color;
                          final isNinguna = id == 'ninguna';
                          final isSelected = isNinguna
                              ? selected.contains('ninguna')
                              : selected.contains(id);

                          return GestureDetector(
                            onTap: _isAnalyzing
                                ? null
                                : () {
                                    final notifier = ref.read(vehicleRegistrationProvider.notifier);
                                    if (isNinguna) {
                                      for (final l in _warningLights) {
                                        final lid = l['id'] as String;
                                        if (lid != 'ninguna' && selected.contains(lid)) {
                                          notifier.toggleWarningLight(lid);
                                        }
                                      }
                                      notifier.toggleWarningLight('ninguna');
                                    } else {
                                      if (selected.contains('ninguna')) {
                                        notifier.toggleWarningLight('ninguna');
                                      }
                                      notifier.toggleWarningLight(id);
                                    }
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2A2A),
                                borderRadius: AppSpacing.borderRadiusLg,
                                border: Border.all(
                                  color: isSelected ? color : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? color.withValues(alpha: 0.25)
                                          : color.withValues(alpha: 0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      icon,
                                      color: isSelected ? color : color.withValues(alpha: 0.7),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    name,
                                    style: AppTypography.labelSmall.copyWith(
                                      color: isSelected ? Colors.white : Colors.white70,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: const Color(0xFF1E1E1E),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: selected.isNotEmpty && !_isAnalyzing ? _analyze : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          disabledBackgroundColor: Colors.white24,
                          disabledForegroundColor: Colors.white38,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppSpacing.borderRadiusXl,
                          ),
                        ),
                        child: Text(
                          _isAnalyzing ? 'Analizando...' : 'Continuar',
                          style: AppTypography.button.copyWith(
                            color: selected.isNotEmpty && !_isAnalyzing ? Colors.black : Colors.white38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isAnalyzing)
            Container(
              color: const Color(0xFF1E1E1E).withValues(alpha: 0.85),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Analizando respuestas...',
                      style: AppTypography.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
