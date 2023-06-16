class SessionController{
  static final SessionController _session=SessionController._internal();

  String? id;
 factory  SessionController(){
   return _session;
  }

  SessionController._internal();
}