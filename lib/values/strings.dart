
class Strings {

  //Api Urls
  static String mainUrl = "http://95a28e0b83a9.ngrok.io";
  String authUrl = "$mainUrl/api/auth";
  String logoutUrl = "$mainUrl/api/logout";
  String meUrl = "$mainUrl/api/me";
  String createUserUrl = "$mainUrl/api/users";
  String updateUserUrl = "$mainUrl/api/users";
  String deleteUserUrl = "$mainUrl/api/users";

  //Common
  String email = "E-mail";
  String password = "Senha";
  String confPassword = "Conf. Senha";
  String name = "Nome";
  String register = "Cadastrar";
  String enter = "Entrar";

  //Auth error
  String authError = "E-mail ou senha não conferem.";

  //Messages
  String updated = "Informações editadas!";
  String userCreated = "Usuário criado!";
  String registerBtn = "Não tem conta? Cadastre-se!";

  //TextField Errors
  String required = "Este campo é obrigatório.";
  String validEmail = "Este campo requer um e-mail válido.";
  String minLength = "Mín. de dígitos deve ser maior ou igual a ";
  String maxLength = "Máximo de dígitos deve ser menor ou igual a ";
  String requiredTrue = "Você deve aceitar os termos e condições para continuar.";
  String numeric = "Apenas números";
  String passwordMatch = "Senhas não conferem.";
}