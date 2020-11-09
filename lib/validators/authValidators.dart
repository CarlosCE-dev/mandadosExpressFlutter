// View
import 'package:mandado_express_dev/models/views/validateResponse.dart';

/// Validate login form
ValidateResponse validateLogin( String email, String password ){
  final validate = ValidateResponse( state: false, msg: '' );
  if ( !requireField(email) ) {
   validate.msg = "El correo es requerido";
   return validate;
  }
  if ( !validateEmail(email) ) {
    validate.msg = "El email no es valido";
    return validate;
  }
  if ( !requireField(password) ) {
    validate.msg = "La contraseña es requerida";
    return validate;
  }
  if ( password.trim().length < 8 ) {
    validate.msg = "La contraseña es muy corta. Debe ser 8 caracters o superior.";
    return validate;
  }

  validate.state = true;
  return validate;
}

//Validate register form
ValidateResponse validateRegister( String firstName, String lastName, String email, String password, String confirmPassword ){
  final validate = ValidateResponse( state: false, msg: '' );
  if ( !requireField(firstName) ) {
   validate.msg = "El nombre es requerido";
   return validate;
  }
  if ( firstName.trim().length < 2 ) {
    validate.msg = "El nombre es muy corto";
    return validate;
  }

  if ( !requireField(lastName) ) {
   validate.msg = "El nombre es requerido";
   return validate;
  }
  if ( lastName.trim().length < 2 ) {
    validate.msg = "El apellido es muy corto";
    return validate;
  }

  if ( !requireField(email) ) {
   validate.msg = "El correo es requerido";
   return validate;
  }
  if ( !validateEmail(email) ) {
    validate.msg = "El email no es valido";
    return validate;
  }
  if ( !requireField(password) ) {
    validate.msg = "La contraseña es requerida";
    return validate;
  }
  if ( password.trim().length < 8 ) {
    validate.msg = "La contraseña es muy corta. Debe ser 8 caracters o superior.";
    return validate;
  }
  if ( password.trim() != confirmPassword.trim() ) {
    validate.msg = "Las contraseñas no son iguales.";
    return validate;
  }

  validate.state = true;
  return validate;
}

// Validate field
bool requireField( String value ){
  if ( value.trim().isEmpty ) {
    return false;
  }
  return true;
}

// Check email
bool validateEmail(String value) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(value);
}