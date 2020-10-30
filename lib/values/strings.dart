
class Strings {

  //Api Urls
  static String mainUrl = "http://acd9a2481799.ngrok.io";
  String loginUrl = "$mainUrl/api/login";
  String logoutUrl = "$mainUrl/api/logout";
  String meUrl = "$mainUrl/api/me";
  String createUserUrl = "$mainUrl/api/users";
  String updateUserUrl = "$mainUrl/api/users/";
  String deleteUserUrl = "$mainUrl/api/users/";

  //Commom
  String email = "E-mail";
  String password = "Senha";

  //TextField Errors
  String required = "Este campo é obrigatório.";
  String validEmail = "Este campo requer um e-mail válido.";
  String minLength = "Mín. de dígitos deve ser maior ou igual a ";
  String maxLength = "Máximo de dígitos deve ser menor ou igual a ";
  String requiredTrue = "Você deve aceitar os termos e condições para continuar.";
  String numeric = "Apenas números";
}