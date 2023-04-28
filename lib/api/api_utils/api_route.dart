class apiRoute {
  //local endpoint
  static const local = "http://localhost:8000";
  static const heroku = "https://pocketpay.herokuapp.com";

  static const base = "$heroku/customer";
  static const merchantBase = "$heroku/merchant";

  //customer
  static const signUp = "$base/register-customer";
  static const login = "$base/login-customer";
  static const fetchCustomerProfile = "$base/fetch-customer-profile";
  static const saveCustomerPin = "$base/save-customer-pin";
  static const addContactDetails = "$base/add-contact-details";

  static const validateCustomerPin = "$base/validate-customer-pin";
  static const completeCustomerProfile = "$base/save-customer-profile";
  static const generateQRCode = "$base/customer-generate-QR-code";
  static const fetchQrCodeData = "$base/fetch-Qr-code-data";
  static const scanMerchantQrCode = "$base/customer-scan-QR-code";
  static const fetchQRCodeTransaction = "$base/fetch-QRCode-Transaction";
  static const fetchFlwTransactions = "$base/fetch-flw-Transaction";
  static const fundWalletBankTransfer = "$base/initiate-funding-bank-transfer";

  // merchant
  static const merchantSignUp = "$merchantBase/register-merchant";
  static const merchantLogin = "$merchantBase/login-merchant";
  static const merchantCreateBusinessProfile =
      "$merchantBase/create-business-profile";
  static const fetchMerchantBusiness = "$merchantBase/fetch-merchant-business";
  static const fetchMerchantProfile = "$merchantBase/fetch-merchant-profile";
  static const fetchMerchantQrCodeTransaction =
      "$merchantBase/fetch-merchant-QRCode-transaction";
  static const merchantGenerateQrCode =
      "$merchantBase/merchant-generate-qr-code";

  static const fetchBusinessQrCodeTransaction =
      "$merchantBase/fetch-business-QRCode-transaction";

  static const merchantFetchQrCodeData = "$merchantBase/fetch-data-from-QRCode";

  static const merchantScanQrCode = "$merchantBase/merchant-scan-qr-code";

  static const createMerchantPin = "$merchantBase/create-merchant-pin";

  static const setMerchantSetNin = "$merchantBase/set-merchant-nin";

  static const setMerchantContactInformation =
      "$merchantBase/set-contact-information";

  static const merchantVerifyBank = "$merchantBase/verify-bank";

  static const fetchAllBank = "$merchantBase/fetch-banks";

  static const merchantAddBank = "$merchantBase/add-bank";

  static const merchantWithdraw = "$merchantBase/merchant-withdrawal";

  static const merchantFlwTransactions = "$merchantBase/fetch-flw-transactions";

  static const validateMerchantPin = "$merchantBase/validate-merchant-pin";

  static const fetchMerchantBank = "$merchantBase/fetch-merchant-bank";

  static const sendOTP = "$merchantBase/sendOtp";
  static const validateOTP = "$merchantBase/verifyOtp";

  //staffs
  static const fetchMerchantStaffs = "$merchantBase/fetch-business-staffs";

  static const registerStaff = "$merchantBase/register-staff";
  static const staffLogin = "$merchantBase/login-staff";
  static const fetchStaffProfile = "$merchantBase/fetch-staff-profile";

  static const staffGenerateQrCode = "$merchantBase/staff-generate-qr-code";
  static const staffScanQrCode = "$merchantBase/staff-scan-qr-code";

  static const fetchStaffQrCodeHistory =
      "$merchantBase/fetch-staff-QRCode-transaction";
}
// Akinsola9c258