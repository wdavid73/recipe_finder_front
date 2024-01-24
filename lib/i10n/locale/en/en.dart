import 'package:recipe_finder/i10n/locale/en/categories.dart';
import 'package:recipe_finder/i10n/locale/en/form_validation.dart';
import 'package:recipe_finder/i10n/locale/en/ingredients.dart';

Map<String, String> enBase = {
  'login': 'Login',
  'sign_up': 'Sign up',
  'logout': 'Log Out',
  'not_user_yet': 'Not a user yet?',
  'name': 'Name',
  'email': 'Email',
  'email_address': 'Email Address',
  'password': 'Password',
  'confirm_password': 'Confirm Password',
  'birthday': 'Birthday',
  'forget_password': 'Forget Password?',
  // HOME
  'title_home': '¡Welcome to RecipeFinder!',
  'your_recipes': 'Your Recipes',
  'its_empty': 'Oops! It’s Empty',
  'list_empty_home': 'Looks like you don’t have anything in your list',
  'add_new_recipe': 'Add new',
  'find_by_category': 'Find by category',
  // NOT FOUND
  'not_found_title': 'Not found',
  'not_found_info': 'We could not find what you were looking for',
  // DRAWER
  'profile': 'Profile',
  'settings': 'Settings',
  'my_recipes': 'My Recipes',
  'create_recipe': 'Create Recipe',
  // PROFILE PAGE
  'edit_profile': 'Edit Profile',
  'num_recipes': 'N° Recipes',
  'favorite_recipes': 'Favorite Recipes',
  'show_all': 'Show all',
  // SETTING PAGE
  'report_bug': 'Report a bug',
  'send_feedback': 'Send a feedback',
  'account': 'Account',
  'delete_account': 'Delete account',
  'feedback': 'Feedback',
  'theme': 'Theme',
  'dark_theme': 'Dark Theme',
  'general': 'General',
  // RECIPES PAGE
  'filters': 'Filters',
  'rating': 'Rating',
  'category': 'Category',
  'cooking_time': 'Preparation time',
  'minute': 'Minute',
  'search': 'Search',
  'enter_keyword': 'Enter keyword here',
  'tap_search': 'Tap to search',
  'apply_filter': 'Apply Filter',
  // CREATE RECIPE
  'name_recipe': 'Name Recipe',
  'description_recipe': 'Description Recipe',
  'tip_photo_recipe': 'Tip: photo of the finished recipe!',
  'tap_search_categories': 'Tap to search a category',
  'enter_keyword_categories': 'Enter keyword here to find a category',
  'step': 'Step',
  'steps': 'Steps',
  'add_step': 'Add Step',
  'step_name': 'Step name',
  'step_action': 'Step action',
  'add_action': 'Add action',
  'action': 'Action',
  'find_ingredient': 'Find ingredient',
  'recipe_created': 'Recipe created successfully',
  // GENERAL
  'error': 'Error!',
  'loading': 'Loading...',
  'not_found_item': 'No items found!',
  'save': 'Save',
  'update': 'Update',
  'delete': 'Delete',
  'close': 'Close',
  'open': 'Open',
  'register_success': 'Register Successfully',
  'register_error': 'An error occurred during registration!',
  'not_user': 'Not User',
  'connection_time_out':
      'The connection request took a long time and was aborted.',
  'send_time_out': 'The connection request took a long time and was aborted.',
  'receive_time_out': 'The connection has timed out, please try again.',
  'bad_response':
      'Response with a non-standard status code, possibly due to server software. ',
  'connection_error': 'The connection errored.',
  'bad_certificate': 'Bad certificate',
  'unknown': 'An unknown error occurred processing the request.',
  'cancel': 'The request was manually cancelled by the user.',
  'not_internet': 'No internet connection detected, please try again.',
  'image_not_found': 'Image not found.',
  'error_get_image': 'Error getting image.'
};

Map<String, String> en = {
  ...enBase,
  ...formValidations,
  ...categoriesTranslate,
  ...ingredientsTranslate
};
