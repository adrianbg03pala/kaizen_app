# 🚀 PASOS PARA CREAR ESTRUCTURA EN FIREBASE CONSOLE

**Proyecto:** `kaizen-tfg-real`  
**Base de datos:** (default)  
**Fecha:** 14 Mayo 2026

---

## ✅ YA EXISTE
- Colección `users` ✓
- Tu documento de usuario ✓

---

## 📋 CREAR EN ORDEN

### PASO 1: Crear colección "exercises"

1. En Firestore Console, click **"Iniciar colección"**
2. Nombre: `exercises`
3. Click **"Siguiente"**

---

### PASO 2: Crear subcollection "general" (dentro de exercises)

1. Dentro de `exercises`, click **"Iniciar colección"**
2. Nombre: `general`
3. Click **"Siguiente"**

---

### PASO 3: Agregar ejercicios a "general"

**Ejercicio 1: Flexiones**

Clickea **"Agregar documento"** y rellena:

```
ID del documento: flexiones

Campos:
├── name: "Flexiones"
├── description: "Ejercicio de fuerza para brazos y pecho"
├── muscle_groups: ["pecho", "brazos", "core"] (array)
├── difficulty: 5
├── default_sets: 3
├── default_reps: 10
├── duration_minutes: 15
├── instructions: ["Posición inicial: cuerpo recto", "Baja lentamente", "Sube hasta estirar"] (array)
├── equipment_needed: "ninguno"
├── variations: ["flexiones inclinadas", "flexiones declinadas"] (array)
├── category: "strength"
└── created_at: "2026-05-14"
```

**Ejercicio 2: Sentadillas**

```
ID: sentadillas

Campos:
├── name: "Sentadillas"
├── description: "Ejercicio para piernas y glúteos"
├── muscle_groups: ["piernas", "gluteos", "core"]
├── difficulty: 4
├── default_sets: 3
├── default_reps: 15
├── duration_minutes: 20
├── instructions: ["Pies al ancho de hombros", "Baja hasta 90 grados", "Sube a posición inicial"]
├── equipment_needed: "ninguno"
├── variations: ["sentadillas búlgaras", "sentadillas sumo"]
├── category: "strength"
└── created_at: "2026-05-14"
```

**Ejercicio 3: Caminar rápido**

```
ID: caminar_rapido

Campos:
├── name: "Caminar rápido"
├── description: "Cardio moderado para principiantes"
├── muscle_groups: ["piernas", "core"]
├── difficulty: 2
├── default_sets: 1
├── default_reps: 1
├── duration_minutes: 30
├── instructions: ["Ritmo: 5-6 km/h", "Mantén postura erguida", "Brazos relajados"]
├── equipment_needed: "ninguno"
├── variations: ["caminar en incline"]
├── category: "cardio"
└── created_at: "2026-05-14"
```

**Ejercicio 4: Planchas**

```
ID: planchas

Campos:
├── name: "Planchas"
├── description: "Core y estabilidad"
├── muscle_groups: ["core", "brazos", "pecho"]
├── difficulty: 6
├── default_sets: 3
├── default_reps: 30 (segundos)
├── duration_minutes: 15
├── instructions: ["Brazos extendidos", "Cuerpo recto", "Mantén 30 segundos"]
├── equipment_needed: "colchoneta"
├── variations: ["plancha lateral", "plancha con movimiento"]
├── category: "strength"
└── created_at: "2026-05-14"
```

**Ejercicio 5: Estiramientos**

```
ID: estiramientos

Campos:
├── name: "Rutina de estiramientos"
├── description: "Flexibilidad y recuperación"
├── muscle_groups: ["piernas", "brazos", "espalda"]
├── difficulty: 1
├── default_sets: 1
├── default_reps: 10 (minutos)
├── duration_minutes: 10
├── instructions: ["Estira cada grupo muscular", "Mantén 30 segundos", "Sin rebotes"]
├── equipment_needed: "colchoneta"
├── variations: ["yoga", "pilates"]
├── category: "flexibility"
└── created_at: "2026-05-14"
```

---

### PASO 4: Crear subcollection "running" (dentro de exercises)

1. En `exercises`, click **"Iniciar colección"**
2. Nombre: `running`
3. Click **"Siguiente"**

**Ejercicio 1: Warm-up (Calentamiento)**

```
ID: warmup

Campos:
├── name: "Warm-up - Trote suave"
├── description: "Calentamiento antes de entrenar"
├── distance_km: 1.0
├── estimated_time_minutes: 10
├── intensity: "easy"
├── pace_range: "7-8 km/h"
├── type: "steady"
├── instructions: ["Trota suavemente 5 min", "Acelera gradualmente", "Termina con 5 km/h"]
└── created_at: "2026-05-14"
```

**Ejercicio 2: Easy Run (Carrera fácil)**

```
ID: easy_run

Campos:
├── name: "Easy Run - Ritmo conversación"
├── description: "Carrera de recuperación o construcción base"
├── distance_km: 5.0
├── estimated_time_minutes: 45
├── intensity: "easy"
├── pace_range: "5.5-6.5 km/h"
├── type: "steady"
├── instructions: ["Mantén ritmo constante", "Deberías poder conversar", "No aceleres al final"]
└── created_at: "2026-05-14"
```

**Ejercicio 3: Tempo Run (Carrera de ritmo)**

```
ID: tempo_run

Campos:
├── name: "Tempo Run - Ritmo sostenido"
├── description: "Entrena resistencia anaeróbica"
├── distance_km: 5.0
├── estimated_time_minutes: 38
├── intensity: "moderate"
├── pace_range: "5.0-5.5 km/h"
├── type: "steady"
├── instructions: ["Calienta 10 min", "Corre a ritmo fuerte", "Enfría 5 min"]
└── created_at: "2026-05-14"
```

**Ejercicio 4: Interval Training (Intervalos)**

```
ID: intervals

Campos:
├── name: "Interval Training - HIIT"
├── description: "Intervalos rápidos y lentos"
├── distance_km: 5.0
├── estimated_time_minutes: 30
├── intensity: "hard"
├── pace_range: "6.0-9.0 km/h (varía)"
├── type: "interval"
├── instructions: ["Calienta", "Sprint 1 min rápido", "Recupera 1 min lento", "Repite 5 veces"]
└── created_at: "2026-05-14"
```

**Ejercicio 5: Long Run (Carrera larga)**

```
ID: long_run

Campos:
├── name: "Long Run - Distancia"
├── description: "Construye resistencia aeróbica"
├── distance_km: 10.0
├── estimated_time_minutes: 90
├── intensity: "easy"
├── pace_range: "5.5-6.5 km/h"
├── type: "steady"
├── instructions: ["Ritmo constante", "No aceleres", "Toma agua regularmente"]
└── created_at: "2026-05-14"
```

---

### PASO 5: Crear subcollection "musculacion" (dentro de exercises)

1. En `exercises`, click **"Iniciar colección"**
2. Nombre: `musculacion`
3. Click **"Siguiente"**

**Ejercicio 1: Press banca**

```
ID: press_banca

Campos:
├── name: "Press banca"
├── description: "Pecho, hombros, tríceps"
├── primary_muscle: "pecho"
├── secondary_muscles: ["hombros", "triceps"]
├── difficulty: 7
├── default_sets: 4
├── default_reps: 8
├── rest_seconds: 120
├── weight_range: "20-100"
├── instructions: ["Acuéstate en banco", "Baja barra a pecho", "Sube explosivamente"]
├── variations: ["press inclinado", "press con mancuernas"]
├── equipment_needed: "barra, pesas"
├── alternative_exercises: ["flexiones", "press con mancuernas"]
└── created_at: "2026-05-14"
```

**Ejercicio 2: Sentadilla con barra**

```
ID: sentadilla_barra

Campos:
├── name: "Sentadilla con barra"
├── description: "Piernas y glúteos con carga"
├── primary_muscle: "piernas"
├── secondary_muscles: ["gluteos", "core"]
├── difficulty: 8
├── default_sets: 4
├── default_reps: 6
├── rest_seconds: 180
├── weight_range: "40-150"
├── instructions: ["Barra en hombros", "Baja hasta 90 grados", "Sube explosivamente"]
├── variations: ["sentadilla búlgara", "sentadilla goblet"]
├── equipment_needed: "barra, pesas, rack"
├── alternative_exercises: ["leg press", "sentadilla con mancuernas"]
└── created_at: "2026-05-14"
```

**Ejercicio 3: Peso muerto**

```
ID: peso_muerto

Campos:
├── name: "Peso muerto"
├── description: "Espalda, piernas, core"
├── primary_muscle: "espalda"
├── secondary_muscles: ["piernas", "core", "brazos"]
├── difficulty: 9
├── default_sets: 3
├── default_reps: 5
├── rest_seconds: 180
├── weight_range: "60-180"
├── instructions: ["Agarra la barra", "Espalda recta", "Sube con piernas"]
├── variations: ["peso muerto rumano", "sumo deadlift"]
├── equipment_needed: "barra, pesas"
├── alternative_exercises: ["trap bar deadlift"]
└── created_at: "2026-05-14"
```

**Ejercicio 4: Dominadas**

```
ID: dominadas

Campos:
├── name: "Dominadas"
├── description: "Espalda y brazos"
├── primary_muscle: "espalda"
├── secondary_muscles: ["biceps", "core"]
├── difficulty: 8
├── default_sets: 3
├── default_reps: 6
├── rest_seconds: 120
├── weight_range: "0-30" (peso adicional)
├── instructions: ["Agarra barra ancha", "Sube hasta barbilla", "Baja controlado"]
├── variations: ["dominadas cerradas", "dominadas asistidas"]
├── equipment_needed: "barra dominadas"
├── alternative_exercises: ["lat pulldown", "remo"]
└── created_at: "2026-05-14"
```

**Ejercicio 5: Curl de bíceps**

```
ID: curl_biceps

Campos:
├── name: "Curl de bíceps"
├── description: "Brazos - aislamiento"
├── primary_muscle: "biceps"
├── secondary_muscles: ["antebrazo"]
├── difficulty: 3
├── default_sets: 3
├── default_reps: 10
├── rest_seconds: 60
├── weight_range: "5-25"
├── instructions: ["Mancuernas a los lados", "Sube hasta hombros", "Baja lentamente"]
├── variations: ["curl predicador", "curl araña"]
├── equipment_needed: "mancuernas"
├── alternative_exercises: ["curl barra", "curl cuerda"]
└── created_at: "2026-05-14"
```

---

### PASO 6: Crear colección "training_plans"

1. Click **"Iniciar colección"**
2. Nombre: `training_plans`
3. Click **"Siguiente"**

---

### PASO 7: Crear planes para "general"

**Plan 1: Principiante 2 días/semana**

```
ID: general_principiante_2dias

Campos:
├── name: "General Fitness - Principiante (2 días/semana)"
├── description: "Rutina básica para comenzar"
├── level: "principiante"
├── days_per_week: 2
├── duration_weeks: 12
├── sessions: (array de objetos)
│   ├── Session 1:
│   │   ├── day: "lunes"
│   │   ├── exercises: ["caminar_rapido", "flexiones", "sentadillas"]
│   │   └── focus_area: "cardio y fuerza"
│   └── Session 2:
│       ├── day: "jueves"
│       ├── exercises: ["caminar_rapido", "planchas", "estiramientos"]
│       └── focus_area: "core y flexibilidad"
├── progression_rules: "Aumenta reps cada 2 semanas"
└── created_at: "2026-05-14"
```

**Plan 2: Intermedio 3 días/semana**

```
ID: general_intermedio_3dias

Campos:
├── name: "General Fitness - Intermedio (3 días/semana)"
├── description: "Rutina más completa"
├── level: "intermedio"
├── days_per_week: 3
├── duration_weeks: 12
├── sessions: (array)
│   ├── Lunes: ["flexiones", "sentadillas", "caminar_rapido"]
│   ├── Miércoles: ["planchas", "flexiones", "estiramientos"]
│   └── Viernes: ["sentadillas", "planchas", "caminar_rapido"]
├── progression_rules: "Aumenta series o intensidad"
└── created_at: "2026-05-14"
```

---

### PASO 8: Crear planes para "running"

**Plan 1: 5K en 1 mes**

```
ID: running_5k_1mes

Campos:
├── name: "Corre 5K en 1 mes"
├── description: "Plan intenso para llegar a 5K"
├── target_distance: 5
├── duration_weeks: 4
├── sessions: (array por semana)
│   ├── Semana 1:
│   │   ├── Lunes: warmup (1km)
│   │   ├── Miércoles: easy_run (3km)
│   │   └── Viernes: easy_run (2km)
│   ├── Semana 2:
│   │   ├── Lunes: warmup (1km)
│   │   ├── Miércoles: easy_run (4km)
│   │   └── Viernes: easy_run (3km)
│   ├── Semana 3:
│   │   ├── Lunes: tempo_run (4km)
│   │   ├── Miércoles: easy_run (3km)
│   │   └── Viernes: intervals (5km)
│   └── Semana 4:
│       ├── Lunes: easy_run (3km)
│       ├── Miércoles: easy_run (4km)
│       └── Viernes: TEST 5K
└── created_at: "2026-05-14"
```

**Plan 2: 10K en 3 meses**

```
ID: running_10k_3meses

Campos:
├── name: "Corre 10K en 3 meses"
├── description: "Plan progresivo para 10K"
├── target_distance: 10
├── duration_weeks: 12
├── sessions: (12 semanas con progresión gradual)
└── created_at: "2026-05-14"
```

---

### PASO 9: Crear planes para "musculacion"

**Plan 1: Principiante Ganancia muscular**

```
ID: musculacion_principiante_ganancia

Campos:
├── name: "Musculación - Principiante (Ganancia)"
├── description: "Construir base muscular"
├── level: "principiante"
├── days_per_week: 3
├── duration_weeks: 12
├── sessions: (array)
│   ├── Día 1 (Pecho):
│   │   └── exercises: ["press_banca", "flexiones"]
│   ├── Día 2 (Piernas):
│   │   └── exercises: ["sentadilla_barra", "curl_biceps"]
│   └── Día 3 (Espalda):
│       └── exercises: ["peso_muerto", "dominadas"]
├── progression_formula: "Aumenta peso 5% cada 2 semanas"
└── created_at: "2026-05-14"
```

**Plan 2: Intermedio Ganancia**

```
ID: musculacion_intermedio_ganancia

Campos:
├── name: "Musculación - Intermedio (Ganancia)"
├── description: "Aumento de volumen"
├── level: "intermedio"
├── days_per_week: 4
├── duration_weeks: 12
├── sessions: (4 días split)
└── created_at: "2026-05-14"
```

---

## 🎯 RESUMEN DE LO QUE CREAR

```
exercises/
├── general/ (5 ejercicios)
├── running/ (5 ejercicios)
└── musculacion/ (5 ejercicios)

training_plans/
├── general_principiante_2dias
├── general_intermedio_3dias
├── running_5k_1mes
├── running_10k_3meses
├── musculacion_principiante_ganancia
└── musculacion_intermedio_ganancia
```

---

## ⚠️ NOTAS IMPORTANTES

1. **Array en Firestore:** Cuando veas `["item1", "item2"]`, clickea **Agregar elemento** en el array
2. **Subcollections:** Se crean dentro de documentos
3. **Números:** Usa números (no strings) para `difficulty`, `sets`, `reps`, etc.
4. **Fechas:** Usa formato ISO: `2026-05-14`

---

**¿EMPEZAMOS? ¿Por dónde quieres empezar?**

