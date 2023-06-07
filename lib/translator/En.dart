// import './translation_keys.dart' as translation;

// const title = 'title';
// const subtitle = 'subtitle';
// const withParam = 'withParam';

import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // fr part
        'fr': {
          //login page
          'login_hello': 'REBONJOUR !',
          'login_slog': 'Bienvenue à nouveau, vous nous avez manqué !',
          'email_requied': 'L\'e-mail est requis',
          'email_invalid_format': 'Format d\'email invalide',
          'password_required': 'Mot de passe requis',
          'forget_passsword_question': 'Mot de passe oublié ?',
          'or_continue_message': 'Ou continuer avec',
          // welcome page
          'greeting': 'BIENVENUE CHEZ FOODSAVER',
          'greeting_message': 'On vous emmène avec nous !',
          'position': 'Ton position',
          'location': 'Emplacement',
          'profile': 'Profil',
          'statistics': 'Statistiques',
          'SETTINGS': 'PARAMÈTRES',
          'login': 'Connexion',
          'logout': 'Déconnecter',
          'register_user': 'Inscrire utilisateur',
          'register_partner': 'Inscrire partenaire',
          'pending': 'en attente',
          'accepted': 'accepté',
          'cancel': 'ANNULÉE',
          'refused': 'refusé',
          'finished': 'fini',
          'expired': 'expiré',
          'orders': 'Ordres',
          'success': ' RÉUSSIE',
          'error': 'Erreur',
          'No_orders': 'Aucune Commande',
          'Add some boxes': 'Ajouter des boxes',
          //nav bar
          'home': 'accueil',
          'ADD BOX': 'AJOUTER BOX',
          'Your_Boxes': 'VOS BOXES',
          'Me': 'Moi',
          // profile
          'Account_Details': 'Détails de mon compte',
          'Name': 'Nom',
          'Phone': 'Téléphone',
          'Category': 'Catégorie',
          'Opening_Time': 'Horaire d\'ouverture',
          'Closing_Time': 'Heure de fermeture',
          'Edit_Profile': 'Modifier votre profil',
          //register page
          'register_slog': 'Créez votre profil pour sauver votre affaire',
          'Password': 'Mot de passe',
          'Select_Image': 'Sélectionner une image',
          'No_image': 'Aucune image sélectionnée',
          'Pick_Closing_Time': 'Choisissez l\'heure de fermeture',
          'Pick_Opening_Time': 'Choisissez l\'heure d\'ouverture',
          'Get_Position': 'Obtenir position',
          'Send_Request': 'Envoyer une demande',
          'account_question': 'Vous avez déjà un compte ? Connecte !!',
          // food details
          'Title': 'Titre',
          'Initial_quantity': 'Quantité initiale',
          'Remaining_quantity': 'Quantité restante',
          'Available_from': 'Disponible depuis',
          'To': 'À',
          'Edit': 'Modifier',
          //edit Profile
          'Save': 'ENREGISTRER',
          'modifie_Password': 'Modifier mot de passe',
          'New_password': 'Nouveau mot de passe',
          // Box form
          'Old_Price': 'Ancien prix',
          'New_Price': 'Nouveau prix',
          'Start_Date': 'Date de début',
          'End_Date': 'Date de fin',
          'Quantity': 'Quantité',
          'Create_Box': 'Créer une boîte',
        },

        // en part
        'en_US': {
          //login page
          'login_hello': 'HELLO AGAIN !',
          'login_slog': 'Welcome back , you\'ve been missed !',
          'email_requied': 'Email is required',
          'email_invalid_format': 'Invalid email format',
          'password_required': 'Password is required',
          'forget_passsword_question': 'Forget Password ?',
          'or_continue_message': 'Or continue with',
          // welcome page
          'greeting': 'WELCOME TO FOODSAVER',
          'greeting_message': 'Let\'s take you with us !',
          'position': 'your position',
          'location': 'Location',
          'profile': 'Profile',
          'statistics': 'Statistics',
          'login': 'Login',
          'logout': 'Logout',
          'register_user': 'Register As User',
          'register_partner': 'Register As Partner',
          'pending': 'pending',
          'accepted': 'accepted',
          'cancel': 'cancel',
          'refused': 'refused',
          'success': 'success',
          'finished': 'finished',
          'expired': 'expired',
          'ORDERS': 'ORDERS',
          'error': 'Error',
          'No_orders': 'No orders found',
          //nav bar
          'home': 'Home',
          'add_box': 'add box',
          'Your_Boxes': 'Your Boxes',
          'Me': 'Me',
          // profile
          'Account_Details': 'My Account Details',
          'Name': 'Name',
          'Phone': 'Phone',
          'Category': 'Category',
          'Opening_Time': 'Opening Time',
          'Closing_Time': 'Closing Time',
          'Edit_Profile': 'Edit Your Profile',
          //register page
          'register_slog': 'Create your profile to save your business',
          'Password': 'Password',
          'Select_Image': 'Select Image',
          'No_image': 'No image selected',
          'Pick_Opening_Time': 'Pick Opening Time',
          'Pick_Closing_Time': 'Pick Closing Time',
          'Get_Position': 'Get Position',
          'Send_Request': 'Send Request',
          'account_question': 'Already have an account ? Login',
          // food details
          'Title': 'Title',
          'Initial_quantity': 'Initial quantity',
          'Remaining_quantity': 'Remaining quantity',
          'Available_from': 'Available from',
          'To': 'To',
          'Edit': 'Edit',

          //edit Profile
          'Save': 'Save',
          'modifie_Password': 'modifie Password',
          'New_password': 'New password',
          // Box form
          'Old_Price': 'Old Price',
          'New_Price': 'New Price',
          'Start_Date': 'Start Date',
          'End_Date': 'End Date',
          'Quantity': 'Quantity',
          'Create_Box': 'Create Box',
        },
      };
}
