# examen 3

Aplicación móvil desarrollada con **Flutter** que permite explorar personajes de *Los Simpson*, buscar personajes por nombre, gestionar favoritos y navegar entre sus detalles de manera sencilla.

La aplicación permite registrar un nombre de usuario localmente y mantener una lista de favoritos asociada a ese nombre, utilizando almacenamiento local para conservar las preferencias entre sesiones.

## Funcionalidades

### Registro de usuario
- Permite registrar un usuario mediante su nombre.
- Guarda el nombre del usuario localmente mediante `SharedPreferences`.
- Permite recuperar el nombre guardado al volver a abrir la aplicación.
- Utiliza el nombre registrado para identificar los favoritos correspondientes al usuario.

> El registro es local y no representa una autenticación mediante contraseña ni una cuenta en un servidor.

### Gestión de favoritos
- Permite marcar personajes como favoritos.
- Asocia los favoritos al nombre del usuario registrado.
- Permite consultar los favoritos correspondientes al usuario actual.


### Búsqueda de personajes
- Permite buscar personajes por su nombre.
- Permite encontrar varios personajes que coincidan con el texto ingresado.
- Realiza la búsqueda sobre los personajes de la página actualmente cargada.

### Paginación
- Permite avanzar a la página siguiente y regresar a la anterior.
- Deshabilita el boton de regreso para la primer pagina, y el boton siguiente para la ultima.


### Actualización de contenido
- Permite recargar la lista mediante el gesto de deslizar hacia abajo (*pull-to-refresh*).
- Facilita volver a consultar los personajes de la página actual.

### Navegación entre pantallas
- Permite acceder al detalle de un personaje desde la lista.
- Facilita el desplazamiento entre la lista de personajes y sus detalles.


## Tecnologías utilizadas

- **Flutter:** desarrollo de la interfaz móvil.
- **Dart:** lenguaje de programación.
- **Dio:** realización de peticiones HTTP a la API.
- **Provider:** gestión y comunicación del estado de los favoritos.
- **SharedPreferences:** almacenamiento local del nombre de usuario y de las preferencias guardadas.
- **sqflite:** para el almacenamiento de los personajes favoritos por usuario.
- **The Simpsons API:** obtención de información de los personajes.

API utilizada: https://thesimpsonsapi.com/

## Funcionamiento general

1. El usuario registra su nombre.
2. La aplicación guarda localmente el nombre registrado.
3. Se cargan los personajes desde la API.
4. El usuario puede buscar personajes, navegar por las páginas y consultar sus detalles.
5. Puede marcar personajes como favoritos.
6. Los favoritos se asocian al nombre del usuario registrado y se recuperan desde el almacenamiento local.
7. El usuario puede actualizar la lista deslizando hacia abajo.

## Persistencia de datos

La aplicación utiliza almacenamiento local para conservar información entre ejecuciones.

Los datos se organizan conceptualmente de la siguiente manera:

| Dato | Finalidad |
|---|---|
| Nombre de usuario | Identificar al usuario registrado localmente. |
| Favoritos | Mantener los personajes favoritos asociados al nombre. |
| Página actual | Controlar la navegación por las páginas de personajes durante el uso. |

**Nota:** `SharedPreferences` es adecuado para preferencias sencillas. No debe considerarse una base de datos segura ni un sistema de autenticación.
