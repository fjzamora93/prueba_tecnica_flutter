# pruebakidsandclouds

Arquitectura base del proyecto: 

```
/lib
├── core/
│   ├── theme/
│   ├── navigation/
│   ├── exceptions/
│   ├── helper/
│   └── di/            # inyección de dependencias
├── data/
│   ├── datasources/        # Clases que consumen APIs o fuentes de datos
│   ├── models/             # Modelos que representan los datos crudos
│   └── repositories_impl/  # Implementación de repositorios
├── domain/
│   ├── entities/           # Entidades puras, independientes del framework
│   ├── repositories/       # Interfaces abstractas para los repositorios
│   └── usecases/           # Lógica de negocio
├── presentation/
│   ├── providers/          # Riverpod providers
│   ├── pages/              # Pantallas
│   └── widgets/            # Componentes reutilizables
└── main.dart
```


# Retrofit.dart

La combinación de Retrofit y Dio permite realizar peticiones https de una manera mucho más segura (provocando menos errores), ya que automatiza el proceso a través de una clase abstracta que realiza toda la petición por nosotros. Para que funcione, únicamente hay que declarar las siguietnes clases:
- El servicio que nos interese (api_service.dart)
- El modelo correspondiente a dicho servicio.

LUego de crearlos, se debe ejecutar el siguiente comando:

```
  flutter pub run build_runner build --delete-conflicting-outputs
```
Este comando generará las clases análogas al servicio y el modelo y se llamarán como la clase original pero con la terminación .g.dart. A partir de ahí, realizar una petición será tan sencilo como esto:

```flutter

part 'user_api_service.g.dart'; // Este archivo se generará

@RestApi(baseUrl: "https://dummyjson.com")
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET("/users/{id}")
  Future<User> getUserById(@Path("id") String id);

  @POST("/users")
  Future<User> createUser(@Body() Map<String, dynamic> userJson);

  @DELETE("/users/{id}")
  Future<void> deleteUser(@Path("id") String id);
}
```

# Tests

```
flutter test test/kidsandclouds/data/repositories/event_repository_test.dart
```



# Interceptores

Para gestionar las solicitudes https se utilizan interceptores que están como dependencia en la capa de Services.

Estos interceptores se encargan de inyectar directamente los headers necesarios a cada petición, y dentro es posible reconocer:
- Tokens (extraidos de secure storage).
- BaseUrl: url base para hacer llamadas a la API.

Siguiendo este principio, podemos ver que las peticiones están completamente centralizadas, de tal forma que en caso de que cambiase la url de base bastaría con modificarla en el módulo de inyección de dependencias.

Por su parte, si se quisiera modifica rel sistema para gestionar los tokens, bastaría con hacerlo desde los siguietnes ficheros:
- authentication/security/token_storage.dart
- authentication/security/auth_interceptor.dart


# Logs de la aplicación

Para optimizar el debugin y el sistema de logs de la aplicación en general se ha creado una clase Log (core/helper/log_helper.dart) que se encarga de gestionar los logs en modo kDebugMode. El sistema de logs puede llamarse desde cualquier parte de la aplicación y sigue el siguiente esquema:

- **Log.e**: Logs de error.
- **Log.d**: Logs de debug.
- **Log.w**: Logs de warning.
- **Log.i**: logs meramente informativos.
- **Log.s**: logs de éxito.

# Inyección de dependencias

Las dependencias no se inyectan de forma manual, sino que están centralizadas en el directorio core/di. EL sistema de inyección de dependencias se maneja a través de Riverpod, de tal forma que no es necesario declarar variables o crear instancias. Siguiendo este principio, tampoco es necesario declarar variables globales para toda la aplicación ni propiedades estáticas.

Como única excpeción, la inyección de dependencias relacionadas con la autentificación estarán encapsuladas dentro del módulo de auth (con el objetivo de poder reutilizar ese bloque de código completo en el futuro).

# Api de muestra y dummy data

- https://dummyjson.com
