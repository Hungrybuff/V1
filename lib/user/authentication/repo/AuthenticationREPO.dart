import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hungrybuff/model/splash_screen_data.dart';
import 'package:hungrybuff/model/user_details.dart';

class AuthenticationRepository {
  static AuthenticationRepository _instance;

  static AuthenticationRepository getInstance() {
    if (_instance == null) {
      _instance = new AuthenticationRepository();
    }
    return _instance;
  }

  Future<SplashScreenData> getCurrentUserDetails() {
    return AuthenticationAPISource.getSplashScreenData();
  }

  Future<bool> saveUserDetails(UserDetails userDetails) {
    return AuthenticationAPISource.insertUserDetails(userDetails);
  }
}

class AuthenticationAPISource {
  static Future<SplashScreenData> getSplashScreenData() async {
    print("get splash screen data");
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    SplashScreenData splashScreenData = new SplashScreenData();
    DocumentSnapshot snapshot = await Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .get();
    if (snapshot.exists) {
      splashScreenData.isUserValidUser = true;
      splashScreenData.didUserGiveAllTheDetials = true;
    } else {
      splashScreenData.isUserValidUser = false;
      splashScreenData.didUserGiveAllTheDetials = false;
    }
    return splashScreenData;
    /*AuthenticationBLOC authenticationBLOC = AuthenticationBLOC.getInstance();

    HttpsCallableResult apiResult = await CloudFunctions.instance
        .getHttpsCallable(functionName: "checkUser")
        .call();
    if (apiResult.data == null) {
      SplashScreenData dataToBeSent = new SplashScreenData();
      dataToBeSent.isError = true;
      dataToBeSent.error = "No Data from server";
      return dataToBeSent;
    }

    print("Data from api = " + apiResult.data.toString());

    SplashScreenData splashScreenData = SplashScreenData.fromJson(
        FirebaseFunctionsDataEncoder.extractData(
            apiResult.data["dataToBeSent"]));
    print(splashScreenData.toString());
    return splashScreenData;*/
  }

  /*var dataToBeReturned = {};
    var newData = {};

    if(context.auth === null || context.auth.uid === null){
        dataToBeReturned.isUserValidUser = false;
        dataToBeReturned.didUserGiveAllTheDetials = false;
        newData.dataToBeSent = dataToBeReturned;
        return newData;
    }
    if(context.auth !== null){

        let dbRef = admin.firestore().collection('users').doc(context.auth.uid).get();
        return dbRef.then(snapshot =>{
            if(!snapshot.exists){
                dataToBeReturned.isUserValidUser = true;
                dataToBeReturned.didUserGiveAllTheDetials = false;
                newData.dataToBeSent = dataToBeReturned;
                return newData;
            }
            console.log("snapshotdata",snapshot.data());
            let temp = snapshot.data();
            console.log("tempdata",temp.phoneNumber);
            if(temp.phoneNumber === null || temp.phoneNumber === ""){
                dataToBeReturned.isUserValidUser = true;
                dataToBeReturned.didUserGiveAllTheDetials = false;
                newData.dataToBeSent = dataToBeReturned;
            }
            else{
                dataToBeReturned.isUserValidUser = true;
                dataToBeReturned.didUserGiveAllTheDetials = true;
                newData.dataToBeSent = dataToBeReturned;
                console.log("else newData",newData);
                return newData;
            }
            console.log("newData",newData);
            return newData;
            }).catch(err =>{
                console.log("error",err);
            });
        }
*/

  static Future<bool> insertUserDetails(UserDetails userDetails) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try {
      await Firestore.instance
          .collection("users")
          .document(user.uid)
          .setData(userDetails.toJson());
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }

    /*HttpsCallableResult apiResult = await CloudFunctions.instance
        .getHttpsCallable(functionName: "setUserDetails")
        .call(userDetails.toJson());
    print("API result for insert user details = " + apiResult.data.toString());
    if (apiResult.data.toString() == "success") {
      return true;
    }
    return false;
  }*/
  }
}
