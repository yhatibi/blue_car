// TODO to change current user use the required data and hot restart

// Christine
// String myId = '5oRHGIPx1Z0wJa3z3Y9S';
// String myUsername = 'Christine Wallace';
// String myUrlAvatar = 'https://i.imgur.com/GXoYikT.png';

// Napoleon
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;


String myId = auth.currentUser.uid;
String myUsername = auth.currentUser.displayName;
String myUrlAvatar = auth.currentUser.photoURL;