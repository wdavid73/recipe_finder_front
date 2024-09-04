import 'package:recipe_finder/i10n/locale/es/form_validation.dart';
import 'package:recipe_finder/i10n/locale/es/ingredients.dart';
import 'package:recipe_finder/i10n/locale/es/categories.dart';

Map<String, String> esBase = {
  'name': 'Nombre',
  'email': 'Correo',
  'email_address': 'Correo electrónico',
  'birthday': 'Fecha de nacimiento',
  // AUTH
  'login': 'Iniciar Sesión',
  'sign_up': 'Regístrate',
  'logout': 'Cerrar Sesión',
  'not_user_yet': '¿No eres usuario todavía?',
  'password': 'Contraseña',
  'new_password': 'Nueva Contraseña',
  'confirm_password': 'Confirmar contraseña',
  'forget_password': '¿Olvidaste tu contraseña?',
  "recovery_password": 'Recuperar contraseña',
  "sign_in_failed": "Inicio de sesión fallido",
  "confirm_email": "Confirmar Email",
  "confirm_email_msg":
      "Por favor ingrese su correo electrónico, para verificar que existe y seguir con su proceso de restablecimiento de contraseña",
  "password_update": "Contraseña actualizada correctamente",
  "accept__btn": "Aceptar",
  "cancel__btn": "Cancelar",
  // HOME
  'title_home': '¡Bienvenido a RecipeFinder!',
  'your_recipes': 'Tus ultimas recetas',
  'its_empty': '¡Uy! Está vacío',
  'list_empty_home': 'Parece que no tienes nada en tu lista',
  'add_new_recipe': 'Crear nueva',
  'find_by_category': 'Buscar por categoría',
  // FOUND
  'not_found_title': 'No encontrado',
  'not_found_info': 'No pudimos encontrar lo que buscabas',
  // DRAWER
  'profile': 'Perfil',
  'settings': 'Configuración',
  'my_recipes': 'Mis Recetas',
  'create_recipe': 'Crear Receta',
  // PROFILE PAGE
  'edit_profile': 'Editar Perfil',
  'num_recipes': 'N° Recetas',
  'favorite_recipes': 'Recetas Favoritas',
  'show_all': 'Mostrar Todas',
  'average_rating': 'Promedio de Calif.',
  'average_time': 'Promedio de tiempo prep.',
  'total_enable': 'N° Recetas habilitadas',
  'total_disable': 'N° Recetas deshabilitadas',
  'not_recipe_favorites': "Parece que no tienes ninguna receta como favorita",
  'total_hide': 'N° Recetas ocultas',
  // SETTING PAGE
  'report_bug': 'Reportar un error',
  'send_feedback': 'Enviar feedback',
  'account': 'Cuenta',
  'delete_account': 'Borrar cuenta',
  'feedback': 'Feedback',
  'theme': 'Tema',
  'dark_theme': 'Tema oscuro',
  'general': 'General',
  // RECIPES PAGE
  'filters': 'Filtros',
  'rating': 'Calificación',
  'category': 'Categoría',
  'cooking_time': 'Tiempo de preparación',
  'minute': 'Minutos',
  'search': 'Buscar',
  'enter_keyword': 'Introduzca aquí la palabra clave',
  'tap_search': 'Toque para buscar',
  'apply_filter': 'Aplicar Filtro',
  // CREATE RECIPE
  'name_recipe': 'Nombre de receta',
  'description_recipe': 'Descripción de receta',
  'tip_photo_recipe': 'Consejo: ¡foto de la receta terminada!',
  'tap_search_categories': 'Toque para buscar una categoría',
  'enter_keyword_categories': 'Introduzca aquí la categoría',
  'step': 'Paso',
  'steps': 'Pasos',
  'add_step': 'Agregar paso',
  'step_name': 'Nombre del paso',
  'step_action': 'Acción en el paso',
  'add_action': 'Agregar paso',
  'action': 'Acción',
  'find_ingredient': 'Buscar ingrediente',
  'select_ingredient': 'Selecciona uno o mas ingredients',
  'recipe_created': 'Receta creada exitosamente',
  'no_item_selected': 'Ningún elemento seleccionado',
  // GENERAL
  'error': '¡Error!',
  'loading': 'Cargando...',
  'not_found_item': '¡No se han encontrado elementos!',
  'save': 'Guardar',
  'update': 'Actualizar',
  'delete': 'Eliminar',
  'close': 'Cerrar',
  'open': 'Abrir',
  'register_success': 'Registro satisfactorio',
  'register_error': 'Se ha producido un error durante el registro',
  'not_user': 'Sin usuario',
  'connection_time_out':
      'La solicitud de conexión tardó mucho tiempo y fue abortada.',
  'send_time_out':
      'La solicitud de conexión tardó mucho tiempo y fue abortada.',
  'receive_time_out': 'La conexión se ha interrumpido, inténtelo de nuevo.',
  'connection_error': 'Error de conexión.',
  'bad_certificate': 'Mal certificado',
  'bad_response':
      'Respuesta con un código de estado no estándar, posiblemente debido al software del servidor. ',
  'unknown': 'Se ha producido un error desconocido al procesar la solicitud.',
  'cancel': 'La solicitud ha sido cancelada manualmente por el usuario.',
  'not_internet': 'No se ha detectado conexión a Internet, inténtelo de nuevo.',
  'image_not_found': 'Imagen no encontrada',
  'error_get_image': 'Error obteniendo la imagen.',
  'not_recipe_filters': 'Parece que no tienes recetas para este filtro.',
  'end_list': 'Has llegado al final de la lista.'
};

Map<String, String> es = {
  ...esBase,
  ...formValidations,
  ...categoriesTranslate,
  ...ingredientsTranslate
};
