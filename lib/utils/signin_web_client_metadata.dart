import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class SignInWithWebClientMetadata extends SignInWithWebUIOptions{

  /// Additional custom attributes to be sent to the service such as information
  /// about the client.
  ///
  final Map<String, String>? clientMetadata;

  const SignInWithWebClientMetadata(
      {

        this.clientMetadata});


  @override
  Map<String, dynamic> serializeAsMap() {
    final Map<String, dynamic> pendingRequest = {
      'clientMetadata': clientMetadata
    };
    pendingRequest.removeWhere((_, v) => v == null);
    return pendingRequest;
  }
}
