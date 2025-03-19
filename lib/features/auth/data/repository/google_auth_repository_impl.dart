import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:growmind_tutuor/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:growmind_tutuor/features/auth/data/models/user_model.dart';
import 'package:growmind_tutuor/features/auth/domain/entities/auth_user.dart';
import 'package:growmind_tutuor/features/auth/domain/repositories/google_auth_repositories.dart';

class GoogleAuthRepositoryImpl implements GoogleAuthRepositories {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore;
  final AuthLocalDataSource authLocalDataSource;

  GoogleAuthRepositoryImpl({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestoreInstance,
    required this.authLocalDataSource, // Inject AuthLocalDataSource
  })  : firebaseAuth = auth ?? FirebaseAuth.instance,
        googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: [
                'email',
                'https://www.googleapis.com/auth/userinfo.profile',
              ],
            ),
        firestore = firestoreInstance ?? FirebaseFirestore.instance;

  @override
  Future<GoogleAuthUser?> signInWithGoogle() async {
    try {
      print("🔹 Starting Google Sign-In...");

      try {
        await googleSignIn.signOut();
      } catch (e) {
        print("⚠️ Google Sign-Out before Sign-In failed: $e");
      }

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print("⚠️ Google Sign-In cancelled by user.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
     
        // Store user data in Firestore
        final userDocRef = firestore.collection('tutors').doc(user.uid);
        final userDoc = await userDocRef.get();

        if (!userDoc.exists) {
          await userDocRef.set({
            'uid': user.uid,
            'displayName': user.displayName ?? '',
            'email': user.email ?? '',
            'imageUrl': user.photoURL ?? '',
            'createdAt': FieldValue.serverTimestamp(),
          });
       
        } else {
         
        }

        // Create a GoogleAuthUser model
        final GoogleAuthUser usersModel = GoogleAuthUser(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName,
          photoUrl: user.photoURL,
        );

        final userModel = UserModel(
          displayName: user.displayName??'',
          id: user.uid,
          email: user.email??'',
          phone: user.phoneNumber??''
        );
        // Cache user data locally
        await authLocalDataSource.cacheUser(userModel);
     
        return usersModel;
      } else {
      
        return null;
      }
    } catch (e) {
      print("🚨 Google Sign-In Error: $e");
      throw Exception("Google Sign-In Error: $e");
    }
  }

  @override
  Future<void> signOut() async {
    try {
   
      await Future.wait([
        googleSignIn.signOut(),
        firebaseAuth.signOut(),
      ]);
    
    } catch (e) {
     
    }
  }
}
