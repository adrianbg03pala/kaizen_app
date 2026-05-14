# 🏗️ ESTRUCTURA FIREBASE COMPLETA - KAIZEN

## 📋 ÍNDICE
1. Flujo de usuario (onboarding)
2. Estructura Firestore
3. Dashboards por tipo
4. Premium vs Gratis

---

## 1️⃣ FLUJO DE USUARIO (ONBOARDING)

### Primer inicio después de login:

```
LoginScreen ✓
     ↓
ProfileSetup (Seleccionar tipo)
     ↓
┌─────────────────────────────────────┐
│ ¿CUÁL ES TU TIPO DE ENTRENAMIENTO? │
├─────────────────────────────────────┤
│ 1. 🏃 GENERAL FITNESS               │
│    (Mantenimiento, edad 40+)         │
│                                      │
│ 2. 🏃‍♂️ RUNNING                        │
│    (Planificación de carreras)       │
│                                      │
│ 3. 💪 MUSCULACIÓN                    │
│    (Levantamiento de pesas)          │
└─────────────────────────────────────┘
```

---

## 2️⃣ PREGUNTAS SEGÚN TIPO ELEGIDO

### A) GENERAL FITNESS

```
Pregunta 1: Tu edad
- 40-50 años
- 50-60 años
- 60+ años

Pregunta 2: Tu nivel actual
- Sedentario (poco actividad)
- Activo (algo de ejercicio)
- Muy activo (entreno regularmente)

Pregunta 3: Objetivo principal
- Mantenerme en forma
- Perder peso
- Ganar resistencia
- Mejorar flexibilidad

Pregunta 4: ¿Cuántos días puedes entrenar?
- 2 días/semana
- 3 días/semana
- 4 días/semana
- 5+ días/semana

Pregunta 5: Duración sesión
- 20-30 minutos
- 30-45 minutos
- 45+ minutos
```

### B) RUNNING

```
Pregunta 1: Tu nivel
- Nunca he corrido
- Corro ocasionalmente
- Corro regularmente

Pregunta 2: Tu objetivo
- Correr 5km
- Correr 10km
- Medio maratón (21km)
- Maratón (42km)

Pregunta 3: Tiempo para lograrlo
- 1 mes
- 2 meses
- 3 meses
- 6 meses

Pregunta 4: ¿Cuántos días puedes entrenar?
- 2 días/semana
- 3 días/semana
- 4 días/semana
- 5+ días/semana

Pregunta 5: Ritmo actual (si conoce)
- Corro a X km/h
- No sé, calcúlalo
```

### C) MUSCULACIÓN

```
Pregunta 1: Tu nivel
- Principiante (nunca entrené)
- Intermedio (tengo experiencia)
- Avanzado (entreno hace años)

Pregunta 2: Tu objetivo
- Ganar masa muscular
- Definir (cut)
- Mantenimiento
- Fuerza máxima

Pregunta 3: Peso objetivo
- (input libre)

Pregunta 4: ¿Cuántos días puedes entrenar?
- 2 días/semana
- 3 días/semana
- 4 días/semana
- 5+ días/semana
- 6+ días/semana

Pregunta 5: Experiencia con pesos
- Principiante
- Intermedio
- Avanzado
```

---

## 3️⃣ ESTRUCTURA FIRESTORE

### COLECCIONES PRINCIPALES

```
firestore/
│
├── users/
│   └── {userId}/
│       ├── profile
│       │   ├── name
│       │   ├── email
│       │   ├── age
│       │   ├── weight (kg)
│       │   ├── height (cm)
│       │   ├── photo_url
│       │   ├── training_type (general|running|musculacion)
│       │   ├── created_at
│       │   └── updated_at
│       │
│       ├── training_preferences
│       │   ├── level (principiante|intermedio|avanzado)
│       │   ├── days_per_week (2|3|4|5|6)
│       │   ├── session_duration (20|30|45|60)
│       │   ├── goal (específico según tipo)
│       │   ├── experience_years
│       │   └── created_at
│       │
│       ├── current_plan  (documento, no subcollection)
│       │   ├── plan_id (referencia a training_plans)
│       │   ├── start_date
│       │   ├── end_date
│       │   ├── status (active|completed|paused)
│       │   ├── progress_percentage
│       │   └── ai_personalization (JSON con parámetros IA)
│       │
│       ├── workout_history/  (subcollection)
│       │   └── {workoutId}
│       │       ├── date
│       │       ├── exercises
│       │       │   └── [{
│       │       │       ├── exercise_id
│       │       │       ├── exercise_name
│       │       │       ├── sets_completed
│       │       │       ├── reps_completed
│       │       │       ├── weight_used (si aplica)
│       │       │       ├── duration (minutos)
│       │       │       └── difficulty_felt (1-10)
│       │       │     }]
│       │       ├── total_duration
│       │       ├── notes
│       │       ├── feeling (1-10)
│       │       └── created_at
│       │
│       ├── measurements/  (subcollection - para tracking)
│       │   └── {measurementId}
│       │       ├── date
│       │       ├── weight
│       │       ├── measurements (pecho, cintura, brazos, etc.)
│       │       ├── energy_level (1-10)
│       │       └── notes
│       │
│       ├── shopping_list/  (subcollection)
│       │   └── {itemId}
│       │       ├── name
│       │       ├── quantity
│       │       ├── unit (kg|L|unidades)
│       │       ├── category (frutas|proteínas|verduras|etc.)
│       │       ├── price_per_unit
│       │       ├── total_price
│       │       ├── is_checked (bool)
│       │       ├── suggested_by_ai (bool - si IA lo sugirió)
│       │       └── date_added
│       │
│       └── analytics/  (subcollection)
│           └── {monthId}
│               ├── month
│               ├── workouts_completed
│               ├── avg_intensity
│               ├── total_duration
│               ├── weight_progression
│               ├── streak_days
│               └── achievements
│
├── exercises/  (GLOBAL - compartido)
│   ├── general/
│   │   └── {exerciseId}
│   │       ├── name
│   │       ├── description
│   │       ├── muscle_groups
│   │       ├── difficulty (1-10)
│   │       ├── default_sets
│   │       ├── default_reps
│   │       ├── duration_minutes
│   │       ├── video_url (deixado para después)
│   │       ├── instructions (array)
│   │       ├── equipment_needed
│   │       ├── variations
│   │       ├── category (cardio|strength|flexibility|etc.)
│   │       └── created_at
│   │
│   ├── running/
│   │   └── {exerciseId}
│   │       ├── name (Warm-up, Easy Run, Tempo Run, etc.)
│   │       ├── description
│   │       ├── distance_km
│   │       ├── estimated_time_minutes
│   │       ├── intensity (easy|moderate|hard|max)
│   │       ├── pace_range (km/h)
│   │       ├── type (steady|interval|fartlek|recovery)
│   │       ├── instructions
│   │       └── created_at
│   │
│   └── musculacion/
│       └── {exerciseId}
│           ├── name
│           ├── description
│           ├── primary_muscle
│           ├── secondary_muscles
│           ├── difficulty (1-10)
│           ├── default_sets
│           ├── default_reps
│           ├── rest_seconds
│           ├── weight_range (min-max kg)
│           ├── instructions
│           ├── variations
│           ├── equipment_needed
│           ├── alternative_exercises
│           └── created_at
│
├── training_plans/  (PLANTILLAS base para IA)
│   ├── general/
│   │   ├── {planId} - plan_principiante_2dias
│   │   │   ├── name
│   │   │   ├── description
│   │   │   ├── level
│   │   │   ├── days_per_week
│   │   │   ├── duration_weeks
│   │   │   ├── sessions
│   │   │   │   └── [{
│   │   │   │       ├── day
│   │   │   │       ├── exercises (array de exercise_ids)
│   │   │   │       └── focus_area
│   │   │   │     }]
│   │   │   ├── progression_rules (cómo avanza)
│   │   │   └── created_at
│   │   └── ...más planes
│   │
│   ├── running/
│   │   ├── {planId} - plan_5k_1mes
│   │   │   ├── name
│   │   │   ├── description
│   │   │   ├── target_distance
│   │   │   ├── duration_weeks
│   │   │   ├── sessions
│   │   │   │   └── [{
│   │   │   │       ├── week
│   │   │   │       ├── day
│   │   │   │       ├── exercise (tipo de corrida)
│   │   │   │       ├── distance_km
│   │   │   │       └── pace
│   │   │   │     }]
│   │   │   └── created_at
│   │   └── ...más planes
│   │
│   └── musculacion/
│       ├── {planId} - plan_principiante_ganancia
│       │   ├── name
│       │   ├── description
│       │   ├── level
│       │   ├── days_per_week
│       │   ├── duration_weeks
│       │   ├── sessions
│       │   │   └── [{
│       │   │       ├── day
│       │   │       ├── exercises (array con exercise_ids + sets/reps)
│       │   │       ├── focus_area
│       │   │       └── rest_between_exercises
│       │   │     }]
│       │   ├── progression_formula (cómo aumenta peso)
│       │   └── created_at
│       └── ...más planes
│
└── ai_calculations/  (Estructura para IA - si no usamos API)
    ├── {userId}/
    │   ├── last_calculation
    │   ├── parameters_history
    │   └── generated_plans
```

---

## 4️⃣ DASHBOARDS POR TIPO

### A) GENERAL FITNESS DASHBOARD

```
┌────────────────────────────────────┐
│  GENERAL FITNESS - TU PROGRESO     │
├────────────────────────────────────┤
│                                    │
│ 📊 ESTADÍSTICAS DEL MES            │
│ Entrenamientos: 8/12 completados   │
│ Streak: 5 días consecutivos        │
│ Tiempo total: 4h 30min             │
│                                    │
│ 📈 PROGRESO FÍSICO                 │
│ Peso: 78 kg → 76 kg ↓ (bueno!)    │
│ Flexibilidad: +15% mejora          │
│                                    │
│ 🎯 PRÓXIMO ENTRENAMIENTO           │
│ Hoy: Sesión General 30min          │
│ Intensidad: Media                  │
│ [Empezar entrenamiento]            │
│                                    │
│ 📋 ÚLTIMOS ENTRENAMIENTOS          │
│ • Ayer - General 30min - ✓         │
│ • Hace 2 días - General 25min - ✓  │
│ • Hace 3 días - General 30min - ✓  │
│                                    │
└────────────────────────────────────┘
```

### B) RUNNING DASHBOARD

```
┌────────────────────────────────────┐
│  RUNNING - OBJETIVO 10K            │
├────────────────────────────────────┤
│                                    │
│ 🏃 PROGRESO HACIA 10K              │
│ Meta: 10 km en 3 meses             │
│ Progreso: ████████░░ 78%           │
│ Semanas: 9/12 completadas          │
│                                    │
│ 📊 ESTADÍSTICAS                    │
│ Distancia total: 42.5 km           │
│ Mejor tiempo: 48:30 (5km)          │
│ Ritmo promedio: 5:45 /km           │
│                                    │
│ 📈 EVOLUCIÓN                       │
│ Velocidad: 8.5 → 10.2 km/h ↑       │
│ Resistencia: +2.3 km en promedio   │
│                                    │
│ 🎯 PRÓXIMO ENTRENAMIENTO           │
│ Tipo: Tempo Run                    │
│ Distancia: 5 km                    │
│ Ritmo: 5:40 /km                    │
│ [Empezar carrera]                  │
│                                    │
│ 🔥 RACHA: 7 días consecutivos ⭐   │
│                                    │
└────────────────────────────────────┘
```

### C) MUSCULACIÓN DASHBOARD

```
┌────────────────────────────────────┐
│  MUSCULACIÓN - GANANCIA DE MASA    │
├────────────────────────────────────┤
│                                    │
│ 💪 PROGRESO GENERAL                │
│ Peso corporal: 75 kg → 78 kg ↑     │
│ Grasa corporal: 18% → 16% ↓        │
│ Masa muscular: +2.5 kg estimado    │
│                                    │
│ 🏋️ EVOLUCIÓN DE FUERZA             │
│ Sentadilla: 80kg → 95kg (+18.75%)  │
│ Press banca: 60kg → 70kg (+16.67%) │
│ Peso muerto: 100kg → 115kg (+15%)  │
│                                    │
│ 📊 ENTRENAMIENTOS                  │
│ Este mes: 12/12 completados ✓      │
│ Streak: 18 días consecutivos 🔥    │
│ Volumen total: 48,500 kg           │
│                                    │
│ 🎯 PRÓXIMO ENTRENAMIENTO           │
│ Día: Pecho + Tríceps               │
│ Ejercicios: 5                      │
│ Duración est.: 60 minutos          │
│ [Empezar sesión]                   │
│                                    │
│ 📈 OBJETIVOS                       │
│ Peso final: 80 kg (Falta: 2 kg)    │
│ Press banca 100kg (Falta: 30kg)    │
│                                    │
└────────────────────────────────────┘
```

---

## 5️⃣ PREMIUM vs GRATIS

### GRATIS
- ✅ Entrenamientos básicos
- ✅ Dashboard simple
- ✅ Historial de entrenamientos
- ✅ Lista de compra básica
- ✅ 2 tipos de entrenamientos (elegir 1)

### PREMIUM (Decidimos después)
- 🔓 Todos los tipos de entrenamientos
- 🔓 IA avanzada (Gemini integrado)
- 🔓 Personalización completa
- 🔓 Videos explicativos
- 🔓 Dashboard avanzado con gráficas
- 🔓 Seguimiento de medidas (peso, perimetros)
- 🔓 Análisis de progreso
- 🔓 Notificaciones y recordatorios
- 🔓 Sync con servicios externos
- 🔓 Y más...

---

## 6️⃣ CÓMO FUNCIONA LA IA (Estructura interna)

```
Usuario responde preguntas
    ↓
IA (Gemini o interna) recibe parámetros:
- Tipo de entrenamiento
- Nivel
- Objetivo
- Días disponibles
- Peso/edad/experiencia
    ↓
IA genera:
1. Plan personalizado (semanas 1-12)
2. Selecciona ejercicios de la BD
3. Ajusta series/reps/peso según nivel
4. Crea progresión semanal
    ↓
Se guarda en Firebase como "current_plan"
    ↓
App muestra al usuario su plan personalizado
```

---

## 📝 RESUMEN

**Archivo:** `ESTRUCTURA_FIREBASE_COMPLETA.md`  
**Fecha:** 14 Mayo 2026  
**Estado:** Listo para crear en Firebase  
**Próximo paso:** Crear colecciones y documentos en Firestore
