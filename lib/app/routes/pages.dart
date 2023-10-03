//routes navigation
import 'package:get/get.dart';
import 'package:money_keeper/app/features/auth/main_auth.dart';
import 'package:money_keeper/app/features/auth/signup/signup_screen.dart';
import 'package:money_keeper/app/features/auth/signup/verify_signup.dart';
import 'package:money_keeper/app/features/bottom_bar/bottom_bar.dart';
import 'package:money_keeper/app/features/my_wallet/add_wallet.dart';
import 'package:money_keeper/app/features/my_wallet/edit_wallet.dart';
import 'package:money_keeper/app/features/my_wallet/my_wallet_screen.dart';
import 'package:money_keeper/app/features/planning/budget/screens/add_budget.dart';
import 'package:money_keeper/app/features/planning/budget/screens/budget_transaction_screen.dart';
import 'package:money_keeper/app/features/report/expense_detail.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../features/account/setting_screen.dart';
import '../features/auth/forgot/forgot_pass_screen.dart';
import '../features/auth/forgot/reset_pass_screen.dart';
import '../features/auth/forgot/verify_forgot.dart';
import '../features/auth/login/login_screen.dart';
import '../features/category/manage_category.dart';
import '../features/invitation/manage_invitation_screen.dart';
import '../features/planning/budget/screens/budget_info_screen.dart';
import '../features/planning/budget/screens/budget_screen.dart';
import '../features/planning/event/add_edit_event.dart';
import '../features/planning/event/event_info_screen.dart';
import '../features/planning/event/event_screen.dart';
import '../features/planning/event/event_transaction_screen.dart';
import '../features/report/income_detail.dart';
import '../features/transaction/add_transaction.dart';

class AppPages {
  static final pages = [
    GetPage(name: mainAuthScreenRoute, page: () => const MainAuthScreen()),
    GetPage(
        name: loginScreenRoute,
        page: () => const LoginScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: signUpScreenRoute,
        page: () => const SignupScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: verifySignupRoute,
        page: () => const VerifySignupScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: forgotPassRoute,
        page: () => const ForgotPassScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: verifyForgotRoute,
        page: () => const VerifyForgotScreen(),
        transition: Transition.rightToLeft),
    GetPage(name: resetPassRoute, page: () => const ResetPassScreen(), transition: Transition.fade),
    GetPage(name: bottomBarRoute, page: () => const BottomBar(), transition: Transition.fade),
    GetPage(
        name: myWalletRoute,
        page: () => const MyWalletScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: addWalletRoute,
        page: () => const AddWalletScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: editWalletRoute,
        page: () => const EditWalletScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: addTransactionRoute,
        page: () => const AddTransactionScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: incomeDetailRoute, page: () => IncomeDetail(), transition: Transition.rightToLeft),
    GetPage(
        name: expenseDetailRoute, page: () => ExpenseDetail(), transition: Transition.rightToLeft),
    GetPage(name: settingRoute, page: () => SettingScreen(), transition: Transition.rightToLeft),
    GetPage(
        name: manageCategoryRoute,
        page: () => const ManageCategoryScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: eventScreenRoute,
        page: () => const EventScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: addEventScreenRoute,
        page: () => AddEditEventScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: eventInfoScreenRoute,
        page: () => const EventInfoScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: eventTransactionScreenRoute,
        page: () => const EventTransactionScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: budgetScreenRoute,
        page: () => const BudgetScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: budgetInfoScreen,
        page: () => const BudgetInfoScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: addBudgetScreenRoute,
        page: () => const AddBudget(),
        transition: Transition.rightToLeft),
    GetPage(
        name: budgetTransactionScreenRoute,
        page: () => const BudgetTransactionScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: manageInvitationRoute,
        page: () => ManageInvitationScreen(),
        transition: Transition.rightToLeft),
  ];
}
