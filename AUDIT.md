# Auditoría del Proyecto Carlo Subastas

**Fecha:** 2026-10-01
**Archivos Dart analizados:** 57 (sin contar generados)
**Líneas totales en lib/:** ~7,400

---

## 1. Resumen Ejecutivo

El proyecto tiene una base estructural razonable: Riverpod con Notifier, go_router, freezed para modelos, y un sistema de tema (colores, tipografía, espaciados) centralizado. Sin embargo, acumula tres problemas serios: **idioma mezclado** (mitad inglés, mitad español en las UI strings y constantes), **estado global sobredimensionado** (un solo `VehicleRegistrationState` con 20+ campos y listas duplicadas como `exteriorPhotos` + `exteriorPhotosMap`), y **cámara desconectada de la validación** (ML Kit y Gemini existen pero no se usan en el flujo real de captura). Hay 4 dependencias sin usar en pubspec.yaml, el único test falla, y el `car_silhouette_painter.dart` tiene 997 líneas de CustomPainter que deberían ser SVGs. Faltan las funcionalidades clave del brief: no hay diagrama de daños interactivo, no hay categorías de ruedas, y la conexión con el backend Laravel no existe (solo hay un mock). **La arquitectura se rescata; el código necesita una refactorización enfocada, no un rewrite.**

---

## 2. Tabla de Hallazgos

| # | Área | Problema | Archivo(s) | Severidad | Acción sugerida |
|---|------|----------|------------|-----------|-----------------|
| 1 | i18n | Strings en inglés y español mezclados. Constantes (`AppConstants`), pantallas (`VehicleLookupScreen`, `VehicleDetailsScreen`, `ReviewScreen`), y photo positions están en inglés; auth, dashboard, submission en español | `app_constants.dart`, `vehicle_lookup_screen.dart`, `vehicle_details_screen.dart`, `review_screen.dart` | **Alta** | Unificar todo a español. Crear archivo de strings si se planea multi-idioma |
| 2 | Estado | `VehicleRegistrationState` tiene campos duplicados: `exteriorPhotos` (List) y `exteriorPhotosMap` (Map) para la misma data. `interiorPhotos` (List) nunca se usa. `damagePhotos` (List) nunca se usa | `vehicle_registration_state.dart` | **Alta** | Eliminar `exteriorPhotos`, `interiorPhotos`, `damagePhotos`. Quedar solo con los Maps |
| 3 | Cámara/IA | `VehicleDetectorService` (ML Kit) **nunca se llama** desde ninguna pantalla. Se importa pero no se instancia en `GuidedCaptureScreen`. La detección en tiempo real no funciona | `vehicle_detector_service.dart`, `guided_capture_screen.dart` | **Alta** | Decidir: o se integra en el stream de cámara o se elimina el servicio |
| 4 | Backend | No hay conexión real a API. Solo existe `MockVehicleRepository` con datos hardcodeados. `dio` está en pubspec pero **no se usa en ningún archivo** | `mock_vehicle_repository.dart`, `pubspec.yaml` | **Alta** | Crear capa de datos real con Dio + repositorio |
| 5 | Auth | `AuthScreen` simula login con `Future.delayed(1500ms)`. No hay token, no hay Sanctum, no hay persistencia de sesión | `auth_screen.dart` | **Alta** | Implementar auth real con Sanctum |
| 6 | Deps no usadas | `cached_network_image`, `flutter_svg`, `intl`, `dio` importados en pubspec pero **sin ningún import en el código** | `pubspec.yaml` | **Media** | Eliminar hasta que se necesiten |
| 7 | UI/Tamaño | `car_silhouette_painter.dart` = 997 líneas de CustomPainter dibujando siluetas de auto en 8 ángulos. Pesado, difícil de mantener | `car_silhouette_painter.dart` | **Media** | Reemplazar con 8 SVGs como assets |
| 8 | Colores HC | 5 colores hardcodeados fuera del tema: `Color(0xFF0A0A0A)` en auth/splash, `Color(0xFF8B5CF6)` en exterior_photos (este último ya es `AppColors.primaryLight`) | `auth_screen.dart:184-186`, `splash_screen.dart:61`, `exterior_photos_screen.dart:229` | **Media** | Mover a `AppColors` o usar los existentes |
| 9 | Font sizes HC | 6 `fontSize:` hardcodeados fuera de `AppTypography` (valores: 9, 12, 14, 18) | `guided_capture_screen.dart`, `finance_screen.dart`, `capture_progress_indicator.dart`, `photo_card.dart` | **Baja** | Usar estilos de `AppTypography` |
| 10 | Pantallas grandes | `AuthScreen` (745 líneas), `GuidedCaptureScreen` (491), `ConditionDamageScreen` (373), `ReviewScreen` (368), `ServiceHistoryScreen` (352) | Varios | **Media** | Extraer widgets privados a archivos separados en `widgets/` de cada feature |
| 11 | Código muerto | `flutter analyze` reporta dead code en `exterior_photos_screen.dart:40:27`. `exteriorPhotoTypes` en `AppConstants` es redundante (duplica `photoPositions`). Providers `setExteriorPhotos`, `setExteriorPhotosMap` no se llaman | `app_constants.dart:123-132`, `vehicle_registration_provider.dart:113-118` | **Baja** | Eliminar |
| 12 | Tests | El único test (`widget_test.dart`) falla. Cero cobertura real | `test/widget_test.dart` | **Media** | Reescribir test básico, agregar tests para provider y validación |
| 13 | UX/Daños | No hay diagrama interactivo de la silueta para marcar zona de daño. El usuario solo escribe texto en un campo "Ubicación" | `condition_damage_screen.dart` | **Alta** | Agregar widget de silueta tappable que devuelva zona |
| 14 | UX/Ruedas | No existe categoría de fotos de ruedas (requerida en el brief) | N/A | **Media** | Agregar como nueva sección |
| 15 | UX/Dashboard | Valor estimado hardcodeado "S/ 45,000 - S/ 52,000". Faltan 5 de los 10 pasos en el dashboard (keys, finance, running condition, mechanical issues, extra features) como ProgressCards | `dashboard_screen.dart:69` | **Media** | Hacer dinámico o quitar hasta tener estimación real. Agregar los 5 cards faltantes |
| 16 | Validación | `AngleValidatorService` se ejecuta **secuencialmente** con un `await Future.delayed(2s)` entre cada foto. 8 fotos = ~16+ segundos de espera bloqueante | `exterior_photos_screen.dart:88` | **Media** | Validar en paralelo con `Future.wait` |
| 17 | Errores | Sin manejo de "sin conexión" a internet. Sin retry en llamadas a Gemini. Errores de cámara se silencian en catch | `exterior_photos_screen.dart:82`, `guided_capture_screen.dart:101` | **Media** | Agregar connectivity check y UX de reintentos |
| 18 | Memoria | Las fotos se copian a app documents pero **nunca se limpian**. Un flujo con 8 exteriores + 6 interiores + N daños acumula archivos permanentes | `guided_capture_screen.dart:122-125` | **Baja** | Limpiar al hacer reset o al confirmar envío |

---

## 3. Tabla Rescatar / Reescribir / Eliminar

| Archivo/Módulo | Veredicto | Razón |
|----------------|-----------|-------|
| `lib/core/theme/` (4 archivos) | **Rescatar** | Sistema de tema bien estructurado con AdaptiveColors, tipografía y spacing |
| `lib/core/router/` (3 archivos) | **Rescatar** | Rutas limpias, solo necesita ajustes menores |
| `lib/core/constants/app_constants.dart` | **Reescribir** | Traducir strings, eliminar `exteriorPhotoTypes` duplicado, separar config de foto |
| `lib/models/vehicle.dart` | **Rescatar** | Modelo freezed limpio |
| `lib/models/vehicle_registration_state.dart` | **Reescribir** | Eliminar campos duplicados, agregar campos para ruedas |
| `lib/models/photo_position.dart` | **Rescatar** | Enum + data class limpios |
| `lib/shared/providers/vehicle_registration_provider.dart` | **Reescribir** | Eliminar métodos muertos, limpiar duplicación de foto APIs |
| `lib/shared/providers/theme_provider.dart` | **Rescatar** | Simple y correcto |
| `lib/shared/widgets/` (8 archivos) | **Rescatar** | Widgets reutilizables bien hechos |
| `lib/features/auth/` | **Reescribir** | Reemplazar mock auth con Sanctum real, simplificar animaciones (745 líneas) |
| `lib/features/splash/` | **Rescatar** | Solo necesita usar colores del tema |
| `lib/features/vehicle_lookup/` | **Reescribir** | Traducir, reemplazar mock con API real |
| `lib/features/dashboard/` | **Reescribir** | Agregar cards faltantes, quitar valor estimado hardcodeado |
| `lib/features/vehicle_details/` | **Reescribir** | Solo necesita traducción |
| `lib/features/extra_features/` | **Rescatar** | Ya traducido, funcional |
| `lib/features/keys/` | **Rescatar** | Funcional |
| `lib/features/finance/` | **Rescatar** | Ya traducido |
| `lib/features/running_condition/` | **Rescatar** | Funcional |
| `lib/features/mechanical_issues/` | **Rescatar** | Funcional |
| `lib/features/photos/presentation/` | **Reescribir** | Integrar ML Kit en el flujo o eliminarlo, paralelizar validación |
| `lib/features/photos/services/vehicle_detector_service.dart` | **Reescribir o eliminar** | Existe pero nunca se llama |
| `lib/features/photos/services/angle_validator_service.dart` | **Rescatar** | Funciona, solo optimizar la secuencialidad |
| `lib/features/photos/widgets/car_silhouette_painter.dart` | **Eliminar → SVGs** | 997 líneas de CustomPainter |
| `lib/features/photos/widgets/` (otros 5) | **Rescatar** | Funcionales |
| `lib/features/condition_damage/` | **Reescribir** | Agregar diagrama interactivo, traducir damage types |
| `lib/features/service_history/` | **Rescatar** | Ya traducido, funcional |
| `lib/features/review/` | **Reescribir** | Traducir todas las strings |
| `lib/features/submission_status/` | **Rescatar** | Ya traducido, buen timeline widget |
| `lib/features/vehicle_lookup/data/mock_vehicle_repository.dart` | **Eliminar** | Reemplazar con repositorio real |
| `test/widget_test.dart` | **Reescribir** | Test roto, sin cobertura |

---

## 4. Estructura de Carpetas Propuesta

Mantener la estructura actual feature-first pero formalizarla:

```
lib/
├── main.dart
├── app.dart                          # MaterialApp (extraer de main)
├── core/
│   ├── constants/
│   │   └── app_constants.dart        # Solo configs no-UI
│   ├── network/
│   │   ├── api_client.dart           # Dio configurado con Sanctum
│   │   └── api_endpoints.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   └── theme/
│       ├── app_colors.dart
│       ├── app_spacing.dart
│       ├── app_theme.dart
│       └── app_typography.dart
├── models/
│   ├── vehicle.dart
│   ├── vehicle_registration_state.dart
│   ├── photo_position.dart
│   ├── damage_item.dart              # Extraer de registration_state
│   └── models.dart                   # Barrel
├── shared/
│   ├── providers/
│   │   ├── auth_provider.dart        # Token + usuario actual
│   │   ├── vehicle_registration_provider.dart
│   │   └── theme_provider.dart
│   └── widgets/
│       ├── primary_button.dart
│       ├── secondary_button.dart
│       ├── app_text_field.dart
│       ├── section_header.dart
│       ├── selectable_chip.dart
│       ├── selectable_option_card.dart
│       ├── progress_card.dart
│       ├── status_badge.dart
│       ├── info_card.dart
│       └── widgets.dart              # Barrel
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   └── auth_repository.dart
│   │   ├── presentation/
│   │   │   ├── auth_screen.dart
│   │   │   └── loading_screen.dart
│   │   └── widgets/
│   │       ├── login_form.dart
│   │       ├── register_form.dart
│   │       └── social_buttons.dart
│   ├── inspection/                    # Ejemplo: feature "inspection"
│   │   ├── data/
│   │   │   └── inspection_repository.dart   # POST a API Laravel
│   │   ├── presentation/
│   │   │   ├── vehicle_lookup_screen.dart
│   │   │   ├── dashboard_screen.dart
│   │   │   ├── review_screen.dart
│   │   │   └── submission_status_screen.dart
│   │   ├── providers/
│   │   │   └── inspection_provider.dart     # Si se necesita
│   │   └── widgets/
│   │       ├── vehicle_summary_card.dart
│   │       ├── progress_overview.dart
│   │       └── timeline_widget.dart
│   ├── photos/
│   │   ├── data/                     # (vacío por ahora, fotos son locales)
│   │   ├── presentation/
│   │   │   ├── exterior_photos_screen.dart
│   │   │   ├── interior_photos_screen.dart
│   │   │   └── guided_capture_screen.dart
│   │   ├── providers/
│   │   │   └── guided_capture_provider.dart
│   │   ├── services/
│   │   │   ├── angle_validator_service.dart
│   │   │   └── vehicle_detector_service.dart  # Solo si se usa
│   │   └── widgets/
│   │       ├── camera_overlay_widget.dart
│   │       ├── capture_progress_indicator.dart
│   │       ├── photo_card.dart
│   │       └── photo_preview_dialog.dart
│   ├── damage/
│   │   ├── presentation/
│   │   │   └── condition_damage_screen.dart
│   │   └── widgets/
│   │       └── damage_diagram.dart          # NUEVO: silueta interactiva
│   └── ...                           # Resto de steps (keys, finance, etc.)
└── assets/
    ├── images/
    │   └── car_silhouettes/          # 8 SVGs reemplazando el painter
    └── icons/
```

La diferencia con la actual: capa `data/` para repositorios reales, `core/network/` para Dio, y la feature `inspection` agrupando las pantallas del flujo principal.

---

## 5. Sistema de Diseño Propuesto

### Tokens (ya existentes, confirmar/completar)

| Token | Valor actual | Estado |
|-------|-------------|--------|
| **Colores primarios** | `#6327E2`, `#8B5CF6`, `#4C1D95` | OK |
| **Colores accent** | `#AEF318`, `#C5F74D`, `#8BC612` | OK |
| **Colores semánticos** | success `#10B981`, warning `#F59E0B`, error `#EF4444`, info `#3B82F6` | OK |
| **Colores adaptativos** | 20+ tokens en `AdaptiveColors` | OK, bien implementado |
| **Tipografía** | Inter, 15 estilos definidos (display → caption) | OK pero no siempre usado |
| **Espaciados** | Base 4px, escala xxs(2)→xxxl(64) | OK |
| **Radios** | xs(4)→full(999) | OK |
| **Sombras** | Solo en `AdaptiveColors.shadow` | Falta escala (sm, md, lg) |
| **Duración animaciones** | fast(200), normal(300), slow(500) | OK pero poco usados |

### Componentes Base (6 existentes + 2 nuevos sugeridos)

| # | Componente | Estado | Notas |
|---|-----------|--------|-------|
| 1 | `PrimaryButton` | Existe, OK | Full-width, loading state, icon support |
| 2 | `SecondaryButton` | Existe, OK | Outlined variant |
| 3 | `AppTextField` | Existe, OK | Label, hint, error, prefix/suffix icons |
| 4 | `SectionHeader` | Existe, OK | Title + optional subtitle |
| 5 | `SelectableChip` | Existe, OK | Para tags/opciones |
| 6 | `SelectableOptionCard` | Existe, OK | Para opciones radio-like |
| 7 | **`BottomActionBar`** | **NUEVO** | Extraer el patrón `Container + BoxShadow + PrimaryButton` que se repite en 6+ pantallas |
| 8 | **`DamageDiagram`** | **NUEVO** | Silueta de auto interactiva con zonas tocables |

El patrón de bottom bar con sombra se repite en: `exterior_photos_screen`, `condition_damage_screen`, `service_history_screen`, `vehicle_details_screen`, `review_screen`. Debe ser un widget reutilizable.

---

## 6. Diagnóstico de Cámara y Plan de Prueba

### Estado actual del flujo de captura

```
GuidedCaptureScreen
  ├── Inicializa CameraController (ResolutionPreset.high)
  ├── Muestra CameraPreview + CameraOverlayWidget (silueta estática)
  ├── Al presionar botón → takePicture() → guarda en app documents
  ├── Muestra PhotoPreviewDialog (aceptar/retomar)
  └── Al aceptar → guarda en provider → avanza a siguiente ángulo

ExteriorPhotosScreen
  ├── Muestra grid de 8 posiciones con fotos tomadas
  └── Al presionar "Continuar" → _validateAllPhotos()
      ├── Lee cada foto como bytes
      ├── Llama AngleValidatorService.validateAngle() con Gemini
      ├── Espera 2 segundos entre cada foto (secuencial)
      └── Si todas válidas → confirmPhotos() → dashboard
```

### Qué se valida hoy

| Validación | Implementado | Funciona | Integrado en flujo |
|-----------|-------------|----------|-------------------|
| Detección de vehículo (ML Kit) | Si (`VehicleDetectorService`) | Probablemente (YUV→NV21 conversion existe) | **NO** — nunca se llama |
| Validación de ángulo (Gemini) | Si (`AngleValidatorService`) | Si, cuando hay API key | Si, al finalizar |
| Detección de borrosidad | No | — | — |
| Overlay/guía visual | Si (silueta estática) | Si | Si |
| Indicador de nivel (giroscopio) | No | — | — |
| Compresión de imagen | No (se guarda raw JPEG de cámara) | — | — |

### Fallos probables

1. **ML Kit es código muerto**: `VehicleDetectorService` se instancia con `ObjectDetectorOptions(classifyObjects: true)` pero el modelo base de ML Kit detecta objetos genéricos, no específicamente autos. Los labels pueden no incluir "car". El código asume "el objeto más grande = vehículo" como workaround, pero esto nunca se probó porque nunca se llama.

2. **Gemini secuencial + delay**: 8 fotos × (API call ~2-5s + 2s delay forzado) = 32-56 segundos bloqueantes. El usuario ve "Validando fotos..." sin saber cuál se valida.

3. **Sin compresión**: `ResolutionPreset.high` produce JPEGs de 2-4MB. Enviar 8 exteriores + 6 interiores al backend sin comprimir = 30-60MB por inspección.

4. **Memoria**: Las fotos se copian a `getApplicationDocumentsDirectory()` y nunca se borran. Un usuario que hace varias inspecciones acumula cientos de MB.

5. **Gemini fallback permisivo**: Si la respuesta de Gemini no es parseable, `_parseResponse` devuelve `valid()` (línea 140 de angle_validator). Falso positivo silencioso.

6. **Sin retry**: Si la llamada a Gemini falla por red, se marca como `valid()` en el catch (exterior_photos_screen.dart:82). El error se silencia.

7. **Orientación**: La conversión YUV→NV21 en `VehicleDetectorService` no maneja rotación de preview vs. imagen capturada en todos los dispositivos Android.

### Plan de prueba recomendado

**Fase 1: Prueba aislada de servicios (sin UI)**

```dart
// test/services/angle_validator_test.dart
// Usar imágenes de ejemplo guardadas en test/fixtures/
// Testear: foto frontal correcta, foto lateral cuando se espera frontal,
// foto sin vehículo, imagen corrupta, timeout de API

void main() {
  final validator = AngleValidatorService(apiKey: testApiKey);

  test('valida ángulo frontal correcto', () async {
    final bytes = File('test/fixtures/car_front.jpg').readAsBytesSync();
    final result = await validator.validateAngle(
      imageBytes: bytes,
      expectedAngle: PhotoAngle.front,
    );
    expect(result.isValid, true);
  });

  test('rechaza lateral cuando espera frontal', () async {
    final bytes = File('test/fixtures/car_side.jpg').readAsBytesSync();
    final result = await validator.validateAngle(
      imageBytes: bytes,
      expectedAngle: PhotoAngle.front,
    );
    expect(result.isValid, false);
  });
}
```

**Fase 2: Pantalla de diagnóstico de cámara (debug screen)**

Una pantalla temporal accesible desde dashboard que muestre:
- Preview de cámara con bounding box de ML Kit en tiempo real
- FPS del procesamiento
- Resultado de detección (detected/aligned/coverage%)
- Botón para capturar y validar ángulo con Gemini
- Log de respuestas de Gemini

**Fase 3: Enfoque recomendado para producción**

| Componente | Recomendación | Razón |
|-----------|---------------|-------|
| Detección en tiempo real | **Eliminar ML Kit**. Usar solo overlay de silueta + Gemini post-captura | ML Kit base no distingue autos de otros objetos. Un modelo custom requiere entrenamiento. El overlay ya guía suficiente al usuario |
| Validación de ángulo | **Mantener Gemini pero en paralelo** | `Future.wait()` en vez de secuencial. Mostrar progreso por foto |
| Borrosidad | **Varianza del Laplaciano**, server-side al enviar | Calcularla en Dart es costoso; mejor en el backend antes de aceptar |
| Compresión | **`imageQuality: 80` + max 1920px de largo** | Reducir de ~3MB a ~300KB por foto |
| Nivel/horizonte | **No** hasta tener data de que los usuarios toman fotos torcidas | YAGNI |

---

## 7. Veredicto

### Opción A: Refactorizar sobre el proyecto actual

**Esta es la recomendación.**

El proyecto tiene:
- Arquitectura correcta (Riverpod + go_router + freezed)
- Sistema de tema funcional y bien pensado
- Widgets reutilizables ya creados
- Flujo de wizard que funciona end-to-end (aunque con mocks)
- Solo 1 warning de `flutter analyze`

Lo que tiene NO es un desastre — es un prototipo con deuda controlada. El 60% del código se rescata tal cual. El otro 40% necesita traducción, limpieza de campos muertos, y reemplazo de mocks por APIs reales. Un rewrite descartaría todo lo que ya funciona para reescribir lo mismo.

### Plan de refactorización por fases

Cada fase es un PR independiente que deja la app funcional.

**Fase 1: Limpieza (1-2 días)**
- [ ] Eliminar dependencias no usadas (`cached_network_image`, `flutter_svg`, `intl`, `dio` — re-agregar dio cuando se implemente API real)
- [ ] Eliminar campos muertos de `VehicleRegistrationState` (`exteriorPhotos`, `interiorPhotos`, `damagePhotos`)
- [ ] Eliminar métodos muertos del notifier (`setExteriorPhotos`, `setExteriorPhotosMap`, `removeExteriorPhoto`, `addExteriorPhoto`)
- [ ] Eliminar `AppConstants.exteriorPhotoTypes` (duplicado de `photoPositions`)
- [ ] Eliminar `VehicleDetectorService` (ML Kit) y la dependencia `google_mlkit_object_detection`
- [ ] Fix dead code warning en `exterior_photos_screen.dart:40`
- [ ] Reescribir `widget_test.dart` para que pase
- Criterio de terminado: `flutter analyze` = 0 issues, `flutter test` = pass

**Fase 2: Traducción (1 día)**
- [ ] Traducir todas las strings de `AppConstants` (photo positions, features, issues, damage types) a español
- [ ] Traducir pantallas: `VehicleLookupScreen`, `VehicleDetailsScreen`, `ReviewScreen`
- [ ] Unificar `app_title` a "Carlo Subastas"
- [ ] Reemplazar colores hardcodeados con tokens de `AppColors`
- [ ] Reemplazar `fontSize:` hardcodeados con estilos de `AppTypography`
- Criterio de terminado: grep de strings en inglés = solo nombres de código y enums

**Fase 3: Siluetas SVG + Widget BottomActionBar (1-2 días)**
- [ ] Crear 8 SVGs de siluetas de auto (o usar assets libres) → `assets/images/car_silhouettes/`
- [ ] Reemplazar `CarSilhouetteWidget` (997 líneas de CustomPainter) con `SvgPicture.asset()`
- [ ] Re-agregar `flutter_svg` a pubspec
- [ ] Extraer `BottomActionBar` de las 6 pantallas que repiten el patrón
- Criterio de terminado: `car_silhouette_painter.dart` eliminado, 6 pantallas usando `BottomActionBar`

**Fase 4: Cámara optimizada (2-3 días)**
- [ ] Agregar compresión de fotos (`imageQuality: 80`, resize a max 1920px)
- [ ] Paralelizar validación de ángulo con `Future.wait()`
- [ ] Mostrar progreso individual por foto durante validación
- [ ] Quitar `Future.delayed(2s)` entre validaciones
- [ ] Cambiar fallback de Gemini: en vez de marcar como válido al fallar, mostrar "No se pudo validar, ¿continuar?"
- [ ] Limpiar fotos anteriores al hacer `reset()`
- Criterio de terminado: validación de 8 fotos < 10 segundos, fotos pesan < 500KB cada una

**Fase 5: Diagrama de daños interactivo (2-3 días)**
- [ ] Crear `DamageDiagramWidget`: silueta de auto con zonas definidas (capó, puertas, parachoques, etc.)
- [ ] Al tocar una zona → se pre-llena el campo "Ubicación" con el nombre de la zona
- [ ] Indicador visual de zonas con daño reportado
- [ ] Traducir `damageTypes` a español
- Criterio de terminado: usuario puede tocar zona en diagrama, se marca visualmente, se registra el daño

**Fase 6: Backend real con Sanctum (3-5 días)**
- [ ] Agregar `dio` de vuelta con interceptor para token Sanctum
- [ ] Crear `AuthRepository` con login/register/logout reales
- [ ] Crear `VehicleLookupRepository` con API de consulta de placa
- [ ] Crear `InspectionRepository` con POST de inspección + upload de fotos
- [ ] Persistir token con `shared_preferences` o `flutter_secure_storage`
- [ ] Manejar errores de red: sin conexión, token expirado, server error
- Criterio de terminado: flujo completo funciona contra API Laravel real

**Fase 7: Fotos de ruedas + dashboard completo (1-2 días)**
- [ ] Agregar sección de fotos de ruedas (4 posiciones)
- [ ] Agregar los 5 ProgressCards faltantes al dashboard
- [ ] Hacer el valor estimado dinámico (o quitarlo)
- Criterio de terminado: dashboard muestra 10 pasos, todos navegables y funcionales

---

**Tiempo estimado total: 11-18 días de trabajo enfocado.**

Empezar desde cero (Opción C) tomaría más tiempo y re-implementaría lo que ya funciona. Un proyecto nuevo (Opción B) tendría sentido solo si la arquitectura base fuera incorrecta — pero Riverpod + go_router + freezed es exactamente lo que usaría un proyecto nuevo.
