#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para crear la estructura completa de Firebase para KAIZEN
Autor: Claude
Fecha: 14 Mayo 2026
"""

import firebase_admin
from firebase_admin import credentials, firestore
import json
from datetime import datetime
import os
from pathlib import Path
import glob

# ============================================================================
# CONFIGURACIÓN
# ============================================================================

print("=" * 80)
print("🚀 KAIZEN - Firebase Initialization Script")
print("=" * 80)

# Buscar archivo de credenciales en múltiples ubicaciones
def find_firebase_credentials():
    """Busca el archivo de credenciales de Firebase en múltiples ubicaciones"""

    search_paths = [
        "kaizen-tfg-real-21f46994f7b5.json",  # El archivo exacto
        "firebase-key.json",  # En la carpeta actual
        os.path.expanduser("~/Downloads/*firebase*.json"),  # Downloads
        os.path.expanduser("~/Desktop/*firebase*.json"),  # Desktop
        os.path.expanduser("~/Documents/*firebase*.json"),  # Documents
        "./*firebase*.json",
        "./*adminsdk*.json",
    ]

    print("\n🔍 Buscando archivo de credenciales Firebase...\n")

    for pattern in search_paths:
        if "*" in pattern:
            files = glob.glob(pattern)
            if files:
                print(f"✅ Encontrado: {files[0]}")
                return files[0]
        elif os.path.exists(pattern):
            print(f"✅ Encontrado: {pattern}")
            return pattern

    return None

# Buscar credenciales
CREDENTIALS_PATH = find_firebase_credentials()

if not CREDENTIALS_PATH:
    print("""
❌ No se encontró el archivo de credenciales Firebase

Por favor:
1. Descarga el archivo JSON desde Google Cloud Console
2. Colócalo en una de estas ubicaciones:
   - C:\\Projects\\kaizen_app\\
   - C:\\Users\\[TuUsuario]\\Downloads\\
   - C:\\Users\\[TuUsuario]\\Desktop\\
3. Intenta de nuevo

El archivo debe contener "firebase" o "adminsdk" en el nombre.
    """)
    exit(1)

# Inicializar Firebase
print(f"\n📁 Usando credenciales: {CREDENTIALS_PATH}")
print("\n⏳ Conectando a Firebase...\n")

try:
    cred = credentials.Certificate(CREDENTIALS_PATH)
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    print("✅ Firebase conectado correctamente\n")
except Exception as e:
    print(f"❌ Error al conectar Firebase: {e}")
    print(f"   Verifica que el archivo sea válido: {CREDENTIALS_PATH}")
    exit(1)

# ============================================================================
# EJERCICIOS - GENERAL
# ============================================================================

EXERCISES_GENERAL = [
    {
        "id": "flexiones",
        "name": "Flexiones",
        "description": "Ejercicio clásico de fuerza para brazos, pecho y hombros",
        "muscle_groups": ["pecho", "brazos", "hombros", "core"],
        "difficulty": 5,
        "default_sets": 3,
        "default_reps": 10,
        "duration_minutes": 15,
        "instructions": [
            "Colócate boca abajo con las manos al ancho de los hombros",
            "Mantén el cuerpo recto de pies a cabeza",
            "Baja lentamente hasta casi tocar el suelo",
            "Sube empujando con brazos hasta la posición inicial"
        ],
        "equipment_needed": "ninguno",
        "variations": ["flexiones inclinadas", "flexiones declinadas", "flexiones diamante"],
        "category": "strength",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "sentadillas",
        "name": "Sentadillas",
        "description": "Ejercicio fundamental para piernas y glúteos",
        "muscle_groups": ["piernas", "gluteos", "core"],
        "difficulty": 4,
        "default_sets": 3,
        "default_reps": 15,
        "duration_minutes": 20,
        "instructions": [
            "Pies al ancho de los hombros",
            "Baja lentamente flexionando rodillas hasta 90 grados",
            "Mantén la espalda recta durante todo el movimiento",
            "Sube volviendo a la posición inicial"
        ],
        "equipment_needed": "ninguno",
        "variations": ["sentadillas búlgaras", "sentadillas sumo", "wall sit"],
        "category": "strength",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "caminar_rapido",
        "name": "Caminar rápido",
        "description": "Cardio moderado ideal para principiantes y personas mayores",
        "muscle_groups": ["piernas", "core", "cardiovascular"],
        "difficulty": 2,
        "default_sets": 1,
        "default_reps": 1,
        "duration_minutes": 30,
        "instructions": [
            "Mantén un ritmo de 5-6 km/h",
            "Mantén la postura erguida",
            "Brazos relajados moviendo naturalmente",
            "Respira profundamente de forma constante"
        ],
        "equipment_needed": "ninguno",
        "variations": ["caminar en incline", "caminar con mancuernas"],
        "category": "cardio",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "planchas",
        "name": "Planchas",
        "description": "Ejercicio isométrico para fortalecer el core",
        "muscle_groups": ["core", "brazos", "pecho", "espalda"],
        "difficulty": 6,
        "default_sets": 3,
        "default_reps": 30,
        "duration_minutes": 15,
        "instructions": [
            "Colócate boca abajo apoyado en antebrazos y punteras",
            "Mantén el cuerpo completamente recto",
            "Contrae abdominales",
            "Aguanta la posición 30 segundos o más"
        ],
        "equipment_needed": "colchoneta",
        "variations": ["plancha lateral", "plancha con movimiento", "plancha alta"],
        "category": "strength",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "estiramientos",
        "name": "Rutina de estiramientos",
        "description": "Ejercicios de flexibilidad y recuperación",
        "muscle_groups": ["piernas", "brazos", "espalda", "cuello"],
        "difficulty": 1,
        "default_sets": 1,
        "default_reps": 10,
        "duration_minutes": 10,
        "instructions": [
            "Estira cada grupo muscular lentamente",
            "Mantén cada estiramiento 30 segundos",
            "No hagas rebotes durante los estiramientos",
            "Respira profundamente durante el estiramiento"
        ],
        "equipment_needed": "colchoneta",
        "variations": ["yoga", "pilates", "tai chi"],
        "category": "flexibility",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "burpees",
        "name": "Burpees",
        "description": "Ejercicio full-body de alta intensidad",
        "muscle_groups": ["pecho", "piernas", "brazos", "core", "cardiovascular"],
        "difficulty": 8,
        "default_sets": 3,
        "default_reps": 10,
        "duration_minutes": 10,
        "instructions": [
            "De pie, agáchate y coloca manos en el suelo",
            "Salta hacia atrás para quedar en posición de flexión",
            "Haz una flexión",
            "Salta hacia adelante",
            "Salta hacia arriba con brazos levantados"
        ],
        "equipment_needed": "ninguno",
        "variations": ["burpees sin salto", "burpees con flexión"],
        "category": "cardio",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "mountain_climbers",
        "name": "Mountain Climbers",
        "description": "Cardio explosivo que fortalece core",
        "muscle_groups": ["core", "piernas", "brazos", "cardiovascular"],
        "difficulty": 7,
        "default_sets": 3,
        "default_reps": 30,
        "duration_minutes": 10,
        "instructions": [
            "Colócate en posición de flexión",
            "Lleva una rodilla hacia el pecho rapidamente",
            "Alterna las piernas rápidamente como si corrieras",
            "Mantén el core contraído"
        ],
        "equipment_needed": "ninguno",
        "variations": ["mountain climbers lentos"],
        "category": "cardio",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "sentadillas_salto",
        "name": "Sentadillas con salto",
        "description": "Sentadillas explosivas con salto al final",
        "muscle_groups": ["piernas", "gluteos", "cardiovascular"],
        "difficulty": 7,
        "default_sets": 3,
        "default_reps": 12,
        "duration_minutes": 10,
        "instructions": [
            "Haz una sentadilla normal",
            "Desde la posición baja, salta explosivamente hacia arriba",
            "Cae suavemente y repite"
        ],
        "equipment_needed": "ninguno",
        "variations": ["sentadillas con salto alternado"],
        "category": "cardio",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "leg_raises",
        "name": "Elevaciones de pierna",
        "description": "Fortalecimiento de abdominales inferiores",
        "muscle_groups": ["core", "abdominales"],
        "difficulty": 6,
        "default_sets": 3,
        "default_reps": 12,
        "duration_minutes": 10,
        "instructions": [
            "Acuéstate boca arriba",
            "Levanta las piernas hasta 90 grados",
            "Baja lentamente sin tocar el suelo",
            "Repite el movimiento"
        ],
        "equipment_needed": "colchoneta",
        "variations": ["leg raises en barra", "leg raises en máquina"],
        "category": "strength",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "rotaciones_tronco",
        "name": "Rotaciones de tronco",
        "description": "Movilidad y fortalecimiento de oblicuos",
        "muscle_groups": ["core", "oblicuos"],
        "difficulty": 3,
        "default_sets": 3,
        "default_reps": 20,
        "duration_minutes": 10,
        "instructions": [
            "De pie con pies al ancho de hombros",
            "Cruza brazos sobre pecho",
            "Rota el tronco hacia un lado y luego otro",
            "Mantén caderas fijas"
        ],
        "equipment_needed": "ninguno",
        "variations": ["rotaciones con peso"],
        "category": "flexibility",
        "created_at": datetime.now().isoformat()
    },
]

# ============================================================================
# EJERCICIOS - RUNNING
# ============================================================================

EXERCISES_RUNNING = [
    {
        "id": "warmup",
        "name": "Warm-up - Trote suave",
        "description": "Calentamiento esencial antes de entrenar",
        "distance_km": 1.0,
        "estimated_time_minutes": 10,
        "intensity": "easy",
        "pace_range": "7-8 km/h",
        "type": "steady",
        "instructions": [
            "Trota suavemente durante 5 minutos",
            "Acelera gradualmente el ritmo",
            "Termina con 5 km/h antes de comenzar el entrenamiento principal"
        ],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "easy_run",
        "name": "Easy Run - Ritmo conversación",
        "description": "Carrera de recuperación o construcción de base aeróbica",
        "distance_km": 5.0,
        "estimated_time_minutes": 45,
        "intensity": "easy",
        "pace_range": "5.5-6.5 km/h",
        "type": "steady",
        "instructions": [
            "Mantén un ritmo constante durante toda la carrera",
            "Deberías poder conversar sin problemas",
            "No aceleres al final de la carrera",
            "Respira profundamente de forma controlada"
        ],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "tempo_run",
        "name": "Tempo Run - Ritmo sostenido",
        "description": "Entrena resistencia anaeróbica y velocidad",
        "distance_km": 5.0,
        "estimated_time_minutes": 38,
        "intensity": "moderate",
        "pace_range": "5.0-5.5 km/h",
        "type": "steady",
        "instructions": [
            "Calienta durante 10 minutos",
            "Corre a ritmo fuerte pero controlado",
            "Mantén la intensidad durante 20-25 minutos",
            "Enfría durante 5 minutos"
        ],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "intervals",
        "name": "Interval Training - HIIT",
        "description": "Intervalos rápidos y lentos para máxima intensidad",
        "distance_km": 5.0,
        "estimated_time_minutes": 30,
        "intensity": "hard",
        "pace_range": "6.0-9.0 km/h (varía)",
        "type": "interval",
        "instructions": [
            "Calienta durante 5 minutos",
            "Corre 1 minuto a ritmo muy rápido (sprint)",
            "Corre 1 minuto a ritmo lento (recuperación)",
            "Repite 5 veces el ciclo rápido-lento",
            "Enfría durante 5 minutos"
        ],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "long_run",
        "name": "Long Run - Distancia",
        "description": "Construye resistencia aeróbica y base de resistencia",
        "distance_km": 10.0,
        "estimated_time_minutes": 90,
        "intensity": "easy",
        "pace_range": "5.5-6.5 km/h",
        "type": "steady",
        "instructions": [
            "Mantén un ritmo constante y cómodo",
            "No aceleres durante la carrera",
            "Toma agua regularmente cada 15-20 minutos",
            "Enfría caminando los últimos 5 minutos"
        ],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "fartlek",
        "name": "Fartlek - Juego de velocidades",
        "description": "Combinación libre de velocidades rápidas y lentas",
        "distance_km": 6.0,
        "estimated_time_minutes": 45,
        "intensity": "moderate",
        "pace_range": "5.5-7.5 km/h",
        "type": "interval",
        "instructions": [
            "Calienta durante 10 minutos",
            "Alterna entre tramos rápidos y lentos libremente",
            "Corre rápido durante 2-3 minutos, luego lento 2-3 minutos",
            "Repite varios ciclos"
        ],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "recovery_run",
        "name": "Recovery Run - Carrera de recuperación",
        "description": "Carrera muy fácil para recuperación entre entrenamientos",
        "distance_km": 3.0,
        "estimated_time_minutes": 30,
        "intensity": "very_easy",
        "pace_range": "6.0-7.0 km/h",
        "type": "steady",
        "instructions": [
            "Corre a un ritmo muy cómodo",
            "Es más rápido que caminar pero muy fácil",
            "Fokus en la recuperación, no en el esfuerzo",
            "Mantén la frecuencia cardíaca baja"
        ],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "ladder_workout",
        "name": "Ladder Workout - Entrenamientos escalonados",
        "description": "Aumenta y disminuye la intensidad en escalera",
        "distance_km": 6.0,
        "estimated_time_minutes": 45,
        "intensity": "hard",
        "pace_range": "5.5-8.5 km/h",
        "type": "interval",
        "instructions": [
            "1 min rápido, 1 min lento",
            "2 min rápido, 1 min lento",
            "3 min rápido, 1 min lento",
            "Baja la escalera: 2 min, 1 min lento, 1 min rápido"
        ],
        "created_at": datetime.now().isoformat()
    },
]

# ============================================================================
# EJERCICIOS - MUSCULACIÓN
# ============================================================================

EXERCISES_MUSCULACION = [
    {
        "id": "press_banca",
        "name": "Press banca",
        "description": "Ejercicio fundamental para pecho, hombros y tríceps",
        "primary_muscle": "pecho",
        "secondary_muscles": ["hombros", "triceps"],
        "difficulty": 7,
        "default_sets": 4,
        "default_reps": 8,
        "rest_seconds": 120,
        "weight_range": "20-100",
        "instructions": [
            "Acuéstate en banco horizontal",
            "Agarra la barra al ancho de los hombros",
            "Baja la barra hasta el pecho de forma controlada",
            "Sube explosivamente hasta la posición inicial",
            "Mantén siempre el control del movimiento"
        ],
        "variations": ["press inclinado", "press con mancuernas", "press multipower"],
        "equipment_needed": "barra, pesas, banco",
        "alternative_exercises": ["flexiones", "press con mancuernas"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "sentadilla_barra",
        "name": "Sentadilla con barra",
        "description": "Ejercicio rey para piernas y glúteos",
        "primary_muscle": "piernas",
        "secondary_muscles": ["gluteos", "core"],
        "difficulty": 8,
        "default_sets": 4,
        "default_reps": 6,
        "rest_seconds": 180,
        "weight_range": "40-150",
        "instructions": [
            "Coloca la barra en los hombros",
            "Pies al ancho de caderas",
            "Baja flexionando rodillas hasta 90 grados",
            "Mantén la espalda recta",
            "Sube explosivamente"
        ],
        "variations": ["sentadilla búlgara", "sentadilla goblet", "hack squat"],
        "equipment_needed": "barra, pesas, rack",
        "alternative_exercises": ["leg press", "sentadilla con mancuernas"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "peso_muerto",
        "name": "Peso muerto",
        "description": "Ejercicio completo para espalda, piernas y core",
        "primary_muscle": "espalda",
        "secondary_muscles": ["piernas", "core", "brazos"],
        "difficulty": 9,
        "default_sets": 3,
        "default_reps": 5,
        "rest_seconds": 180,
        "weight_range": "60-180",
        "instructions": [
            "Colócate frente a la barra",
            "Agarra la barra con manos al ancho de hombros",
            "Espalda recta, mira hacia adelante",
            "Sube la barra usando las piernas",
            "Baja de forma controlada"
        ],
        "variations": ["peso muerto rumano", "sumo deadlift", "deficit deadlift"],
        "equipment_needed": "barra, pesas",
        "alternative_exercises": ["trap bar deadlift"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "dominadas",
        "name": "Dominadas",
        "description": "Ejercicio fundamental para espalda y brazos",
        "primary_muscle": "espalda",
        "secondary_muscles": ["biceps", "core"],
        "difficulty": 8,
        "default_sets": 3,
        "default_reps": 6,
        "rest_seconds": 120,
        "weight_range": "0-30",
        "instructions": [
            "Agarra la barra con manos separadas",
            "Sube hasta que la barbilla supere la barra",
            "Baja de forma controlada",
            "Completa el rango completo de movimiento"
        ],
        "variations": ["dominadas cerradas", "dominadas asistidas", "dominadas ponderadas"],
        "equipment_needed": "barra dominadas",
        "alternative_exercises": ["lat pulldown", "remo"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "curl_biceps",
        "name": "Curl de bíceps",
        "description": "Aislamiento de brazos clásico",
        "primary_muscle": "biceps",
        "secondary_muscles": ["antebrazo"],
        "difficulty": 3,
        "default_sets": 3,
        "default_reps": 10,
        "rest_seconds": 60,
        "weight_range": "5-25",
        "instructions": [
            "De pie con mancuernas a los lados",
            "Sube las mancuernas flexionando los codos",
            "Sube hasta los hombros",
            "Baja de forma controlada sin balancear"
        ],
        "variations": ["curl predicador", "curl araña", "curl alternado"],
        "equipment_needed": "mancuernas",
        "alternative_exercises": ["curl barra", "curl cuerda"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "remo_barra",
        "name": "Remo con barra",
        "description": "Fortalecimiento de espalda media y baja",
        "primary_muscle": "espalda",
        "secondary_muscles": ["biceps", "core"],
        "difficulty": 7,
        "default_sets": 4,
        "default_reps": 6,
        "rest_seconds": 120,
        "weight_range": "40-100",
        "instructions": [
            "Inclina el torso hasta 45 grados",
            "Agarra la barra con manos separadas",
            "Tira de la barra hacia el abdomen",
            "Baja de forma controlada",
            "Mantén la espalda recta durante todo el movimiento"
        ],
        "variations": ["remo predicador", "remo con mancuernas"],
        "equipment_needed": "barra, pesas",
        "alternative_exercises": ["lat pulldown", "remo máquina"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "press_militar",
        "name": "Press militar",
        "description": "Fortalecimiento de hombros y tríceps",
        "primary_muscle": "hombros",
        "secondary_muscles": ["triceps", "pecho"],
        "difficulty": 7,
        "default_sets": 3,
        "default_reps": 8,
        "rest_seconds": 120,
        "weight_range": "20-60",
        "instructions": [
            "De pie con barra a la altura de hombros",
            "Presiona la barra hacia arriba",
            "Sube hasta estirar los brazos completamente",
            "Baja bajo control"
        ],
        "variations": ["press sentado", "press con mancuernas", "press máquina"],
        "equipment_needed": "barra, pesas",
        "alternative_exercises": ["press con mancuernas"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "extension_triceps",
        "name": "Extensión de tríceps",
        "description": "Aislamiento específico de tríceps",
        "primary_muscle": "triceps",
        "secondary_muscles": [],
        "difficulty": 4,
        "default_sets": 3,
        "default_reps": 12,
        "rest_seconds": 60,
        "weight_range": "5-20",
        "instructions": [
            "De pie o sentado con peso sobre la cabeza",
            "Baja el peso detrás de la cabeza flexionando codos",
            "Sube estirando los brazos",
            "Mantén los codos fijos"
        ],
        "variations": ["extensión cuerda", "extensión banca", "extensión con mancuerna"],
        "equipment_needed": "mancuerna, cuerda o máquina",
        "alternative_exercises": ["fondos", "press cerrado"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "fondos",
        "name": "Fondos en paralelas",
        "description": "Ejercicio compound para pecho y tríceps",
        "primary_muscle": "pecho",
        "secondary_muscles": ["triceps", "hombros"],
        "difficulty": 7,
        "default_sets": 3,
        "default_reps": 8,
        "rest_seconds": 120,
        "weight_range": "0-30",
        "instructions": [
            "Agarra las barras paralelas",
            "Sube del suelo con los brazos extendidos",
            "Baja flexionando los codos",
            "Sube hasta la posición inicial"
        ],
        "variations": ["fondos asistidos", "fondos ponderados"],
        "equipment_needed": "barras paralelas",
        "alternative_exercises": ["flexiones", "máquina de fondos"],
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "leg_press",
        "name": "Leg Press - Máquina de prensa de piernas",
        "description": "Alternativa segura a sentadilla",
        "primary_muscle": "piernas",
        "secondary_muscles": ["gluteos"],
        "difficulty": 5,
        "default_sets": 4,
        "default_reps": 10,
        "rest_seconds": 120,
        "weight_range": "50-150",
        "instructions": [
            "Siéntate en la máquina",
            "Coloca pies en la plataforma",
            "Baja la plataforma flexionando rodillas",
            "Sube extendiendo las piernas",
            "No bloquees las rodillas arriba"
        ],
        "variations": ["leg press horizontal", "leg press angled"],
        "equipment_needed": "máquina leg press",
        "alternative_exercises": ["sentadilla", "hack squat"],
        "created_at": datetime.now().isoformat()
    },
]

# ============================================================================
# PLANES DE ENTRENAMIENTO
# ============================================================================

TRAINING_PLANS_GENERAL = [
    {
        "id": "general_principiante_2dias",
        "name": "General Fitness - Principiante (2 días/semana)",
        "description": "Rutina básica para comenzar sin experiencia previa",
        "level": "principiante",
        "days_per_week": 2,
        "duration_weeks": 12,
        "sessions": [
            {
                "day": "lunes",
                "exercises": ["caminar_rapido", "flexiones", "sentadillas"],
                "focus_area": "cardio y fuerza general",
                "duration_minutes": 45
            },
            {
                "day": "jueves",
                "exercises": ["caminar_rapido", "planchas", "estiramientos"],
                "focus_area": "core y flexibilidad",
                "duration_minutes": 40
            }
        ],
        "progression_rules": "Aumenta repeticiones cada 2 semanas",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "general_intermedio_3dias",
        "name": "General Fitness - Intermedio (3 días/semana)",
        "description": "Rutina más completa para personas con algo de experiencia",
        "level": "intermedio",
        "days_per_week": 3,
        "duration_weeks": 12,
        "sessions": [
            {
                "day": "lunes",
                "exercises": ["flexiones", "sentadillas", "caminar_rapido"],
                "focus_area": "fuerza general",
                "duration_minutes": 50
            },
            {
                "day": "miercoles",
                "exercises": ["planchas", "burpees", "mountain_climbers"],
                "focus_area": "core y cardio",
                "duration_minutes": 45
            },
            {
                "day": "viernes",
                "exercises": ["sentadillas_salto", "leg_raises", "estiramientos"],
                "focus_area": "piernas y movilidad",
                "duration_minutes": 50
            }
        ],
        "progression_rules": "Aumenta series o intensidad cada semana",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "general_avanzado_4dias",
        "name": "General Fitness - Avanzado (4 días/semana)",
        "description": "Rutina desafiante para personas con buena condición física",
        "level": "avanzado",
        "days_per_week": 4,
        "duration_weeks": 12,
        "sessions": [
            {
                "day": "lunes",
                "exercises": ["burpees", "flexiones", "mountain_climbers"],
                "focus_area": "cardio y fuerza",
                "duration_minutes": 45
            },
            {
                "day": "martes",
                "exercises": ["sentadillas", "sentadillas_salto", "leg_raises"],
                "focus_area": "piernas",
                "duration_minutes": 50
            },
            {
                "day": "jueves",
                "exercises": ["planchas", "rotaciones_tronco", "mountain_climbers"],
                "focus_area": "core",
                "duration_minutes": 45
            },
            {
                "day": "sabado",
                "exercises": ["burpees", "flexiones", "sentadillas_salto"],
                "focus_area": "circuito completo",
                "duration_minutes": 60
            }
        ],
        "progression_rules": "Aumenta velocidad y reducce descanso",
        "created_at": datetime.now().isoformat()
    }
]

TRAINING_PLANS_RUNNING = [
    {
        "id": "running_5k_1mes",
        "name": "Corre 5K en 1 mes",
        "description": "Plan intenso para llegar a 5K en 4 semanas",
        "target_distance": 5,
        "duration_weeks": 4,
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "running_10k_3meses",
        "name": "Corre 10K en 3 meses",
        "description": "Plan progresivo para completar 10K",
        "target_distance": 10,
        "duration_weeks": 12,
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "running_media_maraton",
        "name": "Media Maratón en 12 semanas",
        "description": "Entrena para correr 21K",
        "target_distance": 21,
        "duration_weeks": 12,
        "created_at": datetime.now().isoformat()
    }
]

TRAINING_PLANS_MUSCULACION = [
    {
        "id": "musculacion_principiante_ganancia",
        "name": "Musculación - Principiante (Ganancia)",
        "description": "Construir base muscular desde cero",
        "level": "principiante",
        "days_per_week": 3,
        "duration_weeks": 12,
        "progression_formula": "Aumenta peso 5% cada 2 semanas",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "musculacion_intermedio_ganancia",
        "name": "Musculación - Intermedio (Ganancia)",
        "description": "Aumento de volumen muscular",
        "level": "intermedio",
        "days_per_week": 4,
        "duration_weeks": 12,
        "progression_formula": "Aumenta peso 2-3 kg cada semana",
        "created_at": datetime.now().isoformat()
    },
    {
        "id": "musculacion_avanzado_ganancia",
        "name": "Musculación - Avanzado (Ganancia)",
        "description": "Programa de hipertrofia máxima",
        "level": "avanzado",
        "days_per_week": 5,
        "duration_weeks": 12,
        "progression_formula": "Progresión personalizada según respuesta",
        "created_at": datetime.now().isoformat()
    }
]

# ============================================================================
# FUNCIÓN PARA CREAR DOCUMENTOS
# ============================================================================

def create_exercises(collection_path, exercises_list):
    """Crea una lista de ejercicios en Firestore"""
    try:
        for exercise in exercises_list:
            exercise_id = exercise.pop("id")
            db.collection(collection_path).document(exercise_id).set(exercise)
            print(f"  ✅ {exercise_id}")
        return True
    except Exception as e:
        print(f"  ❌ Error: {e}")
        return False

def create_plans(collection_path, plans_list):
    """Crea una lista de planes en Firestore"""
    try:
        for plan in plans_list:
            plan_id = plan.pop("id")
            db.collection(collection_path).document(plan_id).set(plan)
            print(f"  ✅ {plan_id}")
        return True
    except Exception as e:
        print(f"  ❌ Error: {e}")
        return False

# ============================================================================
# CREAR ESTRUCTURA
# ============================================================================

print("\n📁 Creando estructura de Firestore...\n")

# Ejercicios - General
print("➕ Creando ejercicios GENERAL...")
if create_exercises("exercises/general/exercises_data", EXERCISES_GENERAL):
    print(f"   {len(EXERCISES_GENERAL)} ejercicios creados ✓\n")

# Ejercicios - Running
print("➕ Creando ejercicios RUNNING...")
if create_exercises("exercises/running/exercises_data", EXERCISES_RUNNING):
    print(f"   {len(EXERCISES_RUNNING)} ejercicios creados ✓\n")

# Ejercicios - Musculación
print("➕ Creando ejercicios MUSCULACIÓN...")
if create_exercises("exercises/musculacion/exercises_data", EXERCISES_MUSCULACION):
    print(f"   {len(EXERCISES_MUSCULACION)} ejercicios creados ✓\n")

# Planes - General
print("➕ Creando planes GENERAL...")
if create_plans("training_plans/general/plans_data", TRAINING_PLANS_GENERAL):
    print(f"   {len(TRAINING_PLANS_GENERAL)} planes creados ✓\n")

# Planes - Running
print("➕ Creando planes RUNNING...")
if create_plans("training_plans/running/plans_data", TRAINING_PLANS_RUNNING):
    print(f"   {len(TRAINING_PLANS_RUNNING)} planes creados ✓\n")

# Planes - Musculación
print("➕ Creando planes MUSCULACIÓN...")
if create_plans("training_plans/musculacion/plans_data", TRAINING_PLANS_MUSCULACION):
    print(f"   {len(TRAINING_PLANS_MUSCULACION)} planes creados ✓\n")

# ============================================================================
# RESUMEN
# ============================================================================

print("=" * 80)
print("✅ ¡ESTRUCTURA COMPLETA CREADA EN FIREBASE!")
print("=" * 80)
print(f"""
RESUMEN:
- Ejercicios GENERAL: {len(EXERCISES_GENERAL)}
- Ejercicios RUNNING: {len(EXERCISES_RUNNING)}
- Ejercicios MUSCULACIÓN: {len(EXERCISES_MUSCULACION)}
- Planes GENERAL: {len(TRAINING_PLANS_GENERAL)}
- Planes RUNNING: {len(TRAINING_PLANS_RUNNING)}
- Planes MUSCULACIÓN: {len(TRAINING_PLANS_MUSCULACION)}

Total: {len(EXERCISES_GENERAL) + len(EXERCISES_RUNNING) + len(EXERCISES_MUSCULACION)} ejercicios
Total: {len(TRAINING_PLANS_GENERAL) + len(TRAINING_PLANS_RUNNING) + len(TRAINING_PLANS_MUSCULACION)} planes

🎯 La app ya puede usar estos datos.
📱 Próximo paso: Conectar Flutter con Firestore
""")

print("=" * 80)
