import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tryapp/controllers/location_controller.dart';
import 'package:tryapp/controllers/user_controller.dart';
import 'package:tryapp/ui/pages/registration/owner/owner_home_page.dart';
import 'package:tryapp/ui/pages/registration/user/search_bus.dart';
import 'package:tryapp/ui/pages/registration/user/user_booking_details_page.dart';
import 'package:tryapp/ui/pages/registration/user/user_profile.dart';
import 'package:tryapp/ui/pages/wallet/wallet_page.dart';
import 'package:tryapp/ui/widgets/global/nav_bar.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int currentPage = 0;
  UserController userController = Get.put(UserController());
  final LocationController locationController = Get.put(LocationController());

  List<Widget> pageList = const [Scaffold()];

  initializeUI() async {
    if (await userController.isPassenger()) {
      pageList = [
        SearchBusPage(
          locationController: locationController,
        ),
        const WalletPage(),
        const UserBookingDetailsPage(),
        UserProfile(
          userController: userController,
        ),
      ];
    } else {
      pageList = [
        OwnerHomePage(
          locationController: locationController,
        ),
        const WalletPage(),
        const UserBookingDetailsPage(),
        UserProfile(
          userController: userController,
        ),
      ];
    }
    setState(() {});
  }

  @override
  void initState() {
    initializeUI();
    userController.getUserDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Iconsax.scan),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 20,
        shadowColor: Theme.of(context).primaryColor,
        height: 70,
        child: NavBar(
          selectedIndex: currentPage,
          onIndexChange: (int index) {
            setState(() {
              currentPage = index;
            });
          },
        ),
      ),
      body: IndexedStack(index: currentPage, children: pageList),
    );
  }
}
