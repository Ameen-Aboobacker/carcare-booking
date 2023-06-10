import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../services/bottom_nav_provider.dart';
import '../../user_registration/view_model/firebase_auth_view_model.dart';
import '../../user_registration/view_model/sign_up_view_model.dart';
import '../../user_registration/view_model/user_login_view_model.dart';

class ProviderClass {
  static List<SingleChildWidget> provider = [
    ChangeNotifierProvider(
      create: (context) => NavbarProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserLoginViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => FirebaseAuthViewModel(),
    ),
  ];
}
