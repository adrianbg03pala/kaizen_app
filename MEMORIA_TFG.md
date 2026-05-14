# KAIZEN - Memoria TFG

## Índice
1. Introducción
2. Descripción del Proyecto
3. Objetivos
4. Arquitectura del Sistema
5. Tecnologías Utilizadas
6. Estructura del Proyecto
7. Implementación Realizada
8. Configuración Firebase
9. Flujo de Autenticación
10. Features Planeadas
11. Timeline de Desarrollo
12. Próximos Pasos

---

## 1. Introducción

KAIZEN es una aplicación móvil desarrollada con Flutter que implementa el concepto japonés de "mejora continua". El objetivo es proporcionar una plataforma accesible y moderna para que usuarios puedan rastrear, gestionar y mejorar continuamente su vida personal y profesional.

---

## 2. Descripción del Proyecto

**Nombre**: KAIZEN - Tu viaje de mejora continua  
**Tipo**: Aplicación móvil (TFG - Trabajo de Fin de Grado)  
**Tecnología Principal**: Flutter + Firebase  
**Plataforma**: Android (Samsung SM A156B - Android 14)  
**Estado**: En desarrollo (Fase 1 completada)

### Concepto
KAIZEN (改善, "mejora continua") es una filosofía de mejora constante. La aplicación permite a los usuarios:
- Autenticarse de forma segura
- Gestionar su progreso personal
- Rastrear mejoras en diferentes áreas
- Colaborar y aprender con otros usuarios

---

## 3. Objetivos

### Objetivo Principal
Desarrollar una aplicación móvil funcional que implemente un sistema de mejora continua con autenticación segura, almacenamiento de datos en la nube y una interfaz intuitiva.

### Objetivos Específicos
- ✓ Implementar autenticación con Google Sign-In
- ✓ Configurar Firebase como backend
- ✓ Crear UI/UX moderna y responsiva
- Implementar módulo SmartPantry
- Implementar módulo Training
- Implementar Progress Tracking
- Desplegar en Google Play Store

---

## 4. Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────────┐
│                     CLIENTE (FLUTTER)                       │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────────┐   │
│  │  LoginScreen │→ │ HomeScreen   │→ │  Feature Pages │   │
│  └──────────────┘  └──────────────┘  └────────────────┘   │
│         ↓                  ↓                   ↓             │
│    Google Auth         Auth Service      Riverpod State     │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│                    FIREBASE BACKEND                         │
│  ┌──────────────────┐            ┌──────────────────────┐  │
│  │  Firebase Auth   │            │   Cloud Firestore    │  │
│  │  (Google OAuth)  │            │                      │  │
│  └──────────────────┘            │  Collections:        │  │
│                                  │  - users             │  │
│                                  │  - products          │  │
│                                  │  - progress          │  │
│                                  └──────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 5. Tecnologías Utilizadas

### Frontend
- **Flutter 3.35.7**: Framework multiplataforma para desarrollo móvil
- **Dart**: Lenguaje de programación
- **Riverpod 2.4.10**: Gestión de estado reactiva
- **GoRouter 13.0.0**: Enrutamiento declarativo
- **Google Fonts 6.1.0**: Tipografía personalizada
- **Material Design 3**: Sistema de diseño moderno

### Backend
- **Firebase Core 2.32.0**: Inicialización y configuración
- **Firebase Auth 4.17.0**: Autenticación de usuarios
- **Google Sign-In 6.3.0**: Integración con cuentas de Google
- **Firebase Analytics 10.10.0**: Análisis de uso

### Base de Datos
- **Cloud Firestore 4.17.0**: NoSQL en tiempo real
- **Google Cloud Storage**: Almacenamiento de archivos

### Desarrollo
- **Android Studio**: IDE principal
- **Flutter SDK**: Kit de desarrollo
- **Git/GitHub**: Control de versiones
- **Google Cloud Console**: Gestión de Firebase

---

## 6. Estructura del Proyecto

```
kaizen_app/
├── lib/
│   ├── main.dart                          # Entry point, routing
│   ├── firebase_options.dart              # Configuración Firebase
│   ├── core/
│   │   ├── services/
│   │   │   └── auth_service.dart          # Servicio de autenticación
│   │   └── theme/
│   │       └── app_theme.dart             # Tema de la aplicación
│   └── features/
│       ├── auth/
│       │   └── screens/
│       │       └── login_screen.dart      # Pantalla de login
│       └── home/
│           └── screens/
│               └── home_screen.dart       # Pantalla principal
├── android/
│   ├── app/
│   │   ├── google-services.json           # Configuración Firebase
│   │   └── build.gradle                   # Dependencias Android
│   └── gradle.properties
├── pubspec.yaml                           # Dependencias Flutter
├── analysis_options.yaml                  # Análisis de código
└── README.md                              # Documentación

```

---

## 7. Implementación Realizada

### Fase 1: Autenticación (✓ Completada)

#### LoginScreen
- Interfaz limpia con logo KAIZEN
- Botón "Iniciar con Google"
- Indicador de carga durante autenticación
- Manejo de errores con SnackBar
- Colores personalizados (tema oscuro)

#### AuthService
- Gestión de Google Sign-In
- Autenticación con Firebase
- Guardado de usuario en Firestore
- Método de logout
- Acceso a usuario actual

#### HomeScreen
- Bienvenida personalizada con nombre del usuario
- Visualización de email
- Botón para cerrar sesión
- Navegación con GoRouter

#### Routing
- Implementación de GoRouter
- Rutas: `/login` y `/` (home)
- Navegación programática
- Material App Router

---

## 8. Configuración Firebase

### Proyecto
- **Nombre**: kaizen-tfg-real
- **ID**: kaizen-tfg-real
- **Región**: europe-west1

### Servicios Habilitados
1. **Authentication**
   - Google Sign-In configurado
   - OAuth 2.0 activo
   - SHA-1 registrado para Android

2. **Cloud Firestore**
   - Modo: Native
   - Ubicación: europe-west1
   - Base de datos: (default)
   - Security Rules configuradas

3. **Firebase Analytics**
   - Recopilación de datos de uso
   - Eventos personalizados

### Security Rules (Firestore)
```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
  }
}
```

---

## 9. Flujo de Autenticación

### Diagrama de Secuencia
```
Usuario                 LoginScreen          AuthService            Firebase
  │                          │                    │                    │
  ├─ Toca "Iniciar Google" ──→│                    │                    │
  │                          │─ signInWithGoogle()─→│                    │
  │                          │                    │─ GoogleSignIn────→│
  │                          │                    │                    │
  │  (Selecciona cuenta)     │                    │                    │
  │←──────────────────────────────────────────────│←──────────────────│
  │                          │                    │                    │
  │                          │←─ UserCredential──│←FirebaseAuth.signIn
  │                          │                    │                    │
  │                          │                    │─ Guardar en BD────→│
  │                          │                    │                    │
  │←─ SnackBar "Bienvenido"──│←─ User────────────│                    │
  │                          │                    │                    │
  └─ Navega a HomeScreen ────→│                    │                    │
```

### Pasos
1. Usuario abre app → LoginScreen
2. Toca "Iniciar con Google"
3. Google Sign-In abre selector de cuentas
4. Usuario selecciona su cuenta de Google
5. Firebase Auth verifica credenciales
6. Datos guardados en Firestore (colección: users)
7. SnackBar confirma login: "¡Bienvenido, [Nombre]!"
8. Navegación a HomeScreen
9. HomeScreen muestra nombre y email del usuario
10. Botón "Cerrar sesión" disponible

---

## 10. Features Planeadas

### SmartPantry (Fase 2)
**Descripción**: Gestión inteligente de inventario
- Agregar productos al inventario
- Rastrear cantidades
- Notificaciones de bajo stock
- Historial de cambios

### Training (Fase 3)
**Descripción**: Módulo de aprendizaje y mejora
- Cursos y lecciones
- Badges de logros
- Seguimiento de progreso
- Recomendaciones personalizadas

### Progress Tracking (Fase 3)
**Descripción**: Seguimiento de progreso personal
- Objetivos personales
- Métricas de progreso
- Gráficos de tendencias
- Historial de mejoras

### Dashboard (Fase 4)
**Descripción**: Visualización de datos
- Resumen de progreso
- Estadísticas principales
- Gráficos y métricas
- Recomendaciones

---

## 11. Timeline de Desarrollo

| Fase | Mes | Features | Estado |
|------|-----|----------|--------|
| 1 | Mayo 2026 | Setup Firebase, Autenticación, HomeScreen | ✓ Completa |
| 2 | Junio 2026 | SmartPantry, Schema BD | En progreso |
| 3 | Julio 2026 | Training, Progress Tracking | Planeado |
| 4 | Agosto 2026 | Dashboard, Testing, Deployment | Planeado |

---

## 12. Próximos Pasos

### Corto Plazo (Próximas 2 semanas)
1. Implementar SmartPantry
   - Diseñar UI/UX
   - Crear modelos de datos
   - Implementar CRUD

2. Definir Schema Firestore
   - Colección: products
   - Colección: user_progress
   - Relaciones y subcollections

3. Testing
   - Pruebas unitarias
   - Pruebas de integración
   - Pruebas de UI

### Mediano Plazo (Próximo mes)
1. Implementar Training Module
2. Agregar Progress Tracking
3. Feedback y iteración con tutora
4. Mejoras en UI/UX basadas en feedback

### Largo Plazo (Final del TFG)
1. Implementar Dashboard
2. Optimizaciones de rendimiento
3. Testing completo
4. Documentación
5. Preparación para deployment

---

## Conclusión

Se ha completado exitosamente la Fase 1 del proyecto KAIZEN con una autenticación funcional, backend configurado y navegación implementada. La aplicación está lista para agregar features principales en las próximas fases. La arquitectura está preparada para escalar y añadir funcionalidades complejas manteniendo buenas prácticas de código y seguridad.

---

**Fecha**: 13 de Mayo de 2026  
**Autor**: Adrián Blanco García  
**Tutor/a**: [Nombre del/la tutor/a]
