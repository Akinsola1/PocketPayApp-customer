class apiRoute {
  //local endpoint
  static const base = "http://localhost:8000/customer";

  static const signUp = "$base/register-customer";
  static const login = "$base/login-customer";
  static const fetchCustomerProfile = "$base/fetch-customer-profile";
  static const saveCustomerPin = "$base/save-customer-pin";
  static const completeCustomerProfile = "$base/save-customer-profile";
  static const generateQRCode = "$base/generate-QR-code";
  static const fetchQRCodeTransaction = "$base/fetch-QRCode-Transaction";
}
