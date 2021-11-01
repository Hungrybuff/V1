import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret_key =
      'sk_test_51HYGocIWUKRSbB8mD1Ys1JeJDdVbsdfxanzaiZOm3yJlc4rkUCy42ju8T0t7L922brFLX5jVawO2BKG2IgLOyxxw00VQXP2BWn';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret_key}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51HYGocIWUKRSbB8mstCev6sQn7esnukXh29KUqJbqsQcwtQ9MwGUEyS9N2PlqB2KWAsLnqOeLBlapFtFWeesFPBQ00FkFWyW1t",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      //StripePayment.ApiKey = "sk_test_51HYGocIWUKRSbB8mD1Ys1JeJDdVbsdfxanzaiZOm3yJlc4rkUCy42ju8T0t7L922brFLX5jVawO2BKG2IgLOyxxw00VQXP2BWn";

      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);

      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return new  StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      print(err.toString());
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);
      print("try in create payemnt intent");
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }

  static Future<StripeTransactionResponse> payUsingGooglePay(
      {String amount, String currency}) async {
    try {
      print("pay using google pay try");

      var paymentMethod = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          totalPrice: amount,
          currencyCode: currency,
        ),
        applePayOptions: null,
      );

      // var inner=StripePayment.createTokenWithBankAccount(paymentMethod.bankAccount);

      print("pay using google pay try");
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      print("pay using google pay try" + paymentMethod.tokenId);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.tokenId));
      print("pay using google pay try" + response.status.toString());
      if (response.status == 'succeeded') {
        print("transcation ID is " + response.paymentIntentId.toString());
        StripePayment.completeNativePayRequest();
        return new StripeTransactionResponse(
            message: 'Transaction successful', success: true);
      } else {
        print("false");
        StripePayment.cancelNativePayRequest();
        return new StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      print(err.toString());
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }
}
