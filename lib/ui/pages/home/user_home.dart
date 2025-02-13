import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tryapp/controllers/fare_controller.dart';
import 'package:tryapp/controllers/location_controller.dart';
import 'package:tryapp/controllers/user_controller.dart';
import 'package:tryapp/ui/pages/booking/owner_booking_details_page.dart';
import 'package:tryapp/ui/pages/home/owner_home_page.dart';
import 'package:tryapp/ui/pages/bus/search_bus.dart';
import 'package:tryapp/ui/pages/booking/user_booking_details_page.dart';
import 'package:tryapp/ui/pages/home/user/user_profile.dart';
import 'package:tryapp/ui/pages/qrcode/scan_qr_code_page.dart';
import 'package:tryapp/ui/pages/wallet/wallet_page.dart';
import 'package:tryapp/ui/widgets/global/nav_bar.dart';

class UserHome extends StatefulWidget {
  final int currentPage;
  const UserHome({super.key, this.currentPage = 0});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int currentPage = 0;
  FareController fareController = FareController();

  UserController userController = (UserController());
  final LocationController locationController = (LocationController());

  List<Widget> pageList = const [Scaffold()];

  initializeUI() async {
    await userController.isPassenger();
    if (userController.isPassengerCheck.value) {
      pageList = [
        SearchBusPage(
          locationController: locationController,
          userController: userController,
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
          userController: userController,
        ),
        const WalletPage(),
        const OwnerBookingDetailsPage(),
        UserProfile(
          userController: userController,
        ),
      ];
    }
    currentPage = widget.currentPage;
    setState(() {});
  }

  @override
  void initState() {
    initializeUI();
    userController.getUserDetail();

    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Obx(
        () => fareController.isLoading.value
            ? const CircularProgressIndicator()
            : FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Iconsax.scan),
                onPressed: () async {
                  Get.to(() => QRCodeScannerApp(
                        onFound: (data) async {
                          await fareController.completeFare(data);
                        },
                      ));
                },
              ),
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
