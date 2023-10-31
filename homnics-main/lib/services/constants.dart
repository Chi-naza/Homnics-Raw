const loginUrl = "user-api/authentication/token";

const baseUrl = "https://api.homnics.com/";

const registerUrl = "user-api/account";

const refreshTokenUrl = "user-api/authentication/refresh";

const confirmEmail = "user-api/account/{userId}/confirm-email";

const getPaystackAuthUrl = 'https://api.paystack.co/transaction/initialize';

const getPaymentReferenceUrl =
    'user-api/payment/generate-plan-payment-reference';

verifyTransactionUrl(String ref) =>
    'https://api.paystack.co/transaction/verify/$ref';

const getProfessionalsUrl = "user-api/professional/all";

const getProfessionalTypeUrl = "user-api/professional/type/all";

getProfessionalTypeById(String typeId) => "user-api/professional/type/$typeId";

getUserByIdUrl(String userId) => 'user-api/account/$userId';

getCurrentUserUrl() => 'user-api/account/current-user';

getAvatarUrl(String userId) => 'user-api/account/$userId/avatar';

updateProfileUrl(String userId) => 'user-api/account/$userId/profile';

const postUserPlanUrl = 'user-api/plan/user-plan';

userPlanBeneficiaryUrl(String planId) =>
    'user-api/plan/user-plan/beneficiaries/$planId';

getUserPlansUrl(String userId) => 'user-api/plan/user-plan/user/' + userId;

updateUserByIdUrl(String userId) => 'user-api/account/$userId/profile';

getPrescriptionsById(String beneficiaryId) =>
    'user-api/prescription/by-beneficiaryId/$beneficiaryId';

getActivePlanUrl(String userId) => 'user-api/plan/user-plan/active/' + userId;
const String postAppointmentURL = "user-api/appointment";

getAppointmentsByStatus(String professionalId) =>
    "user-api/appointment/by-status/" + professionalId + '?status=2';
const String fixMeetingUrl = "user-api/meeting/jitsi";

getAppointmentByBeneficiaryStatus(
        String beneficiaryId, int status) => //String pgExtra,
    "/user-api/appointment/by-status/beneficiary/$beneficiaryId?status=$status&pageNumber=1&pageSize=10";

String getAllAppointmentUrl(String beneficiaryId) =>
    "user-api/appointment/all-user/${beneficiaryId}";

String getAvailableProfessionals = "user-api/professional/available?";

deleteUserPlanBeneficiaryByIdUrl(String planId) =>
    'user-api/plan/user-plan/$planId';
getNotifications(String userId) => 'user-api/notification/$userId';
const updateNotifications = 'user-api/notification';
