import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/controller/auth/logout_controller.dart';
import 'package:penstore/widgets/profile/add_product_widget.dart';
import 'package:penstore/widgets/profile/buy_list_widget.dart';
import 'package:penstore/widgets/profile/profile_image_widget.dart';
import 'package:penstore/widgets/profile/profile_tab.dart';
import 'package:penstore/widgets/profile/sell_list_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final userController = Get.put(UserController());
  //final _formKey = GlobalKey<FormState>();
  final FocusNode _searchFocusNode = FocusNode();
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileImage(),
          const SizedBox(
            height: 100,
          ),
          Column(
            children: [
              Obx(
                () => Text(
                  userController.user.value.name,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("No Telepon"),
                    Text("no telepon"),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Email"),
                    Text(userController.user.value.email)
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          const AddProductForm(),
          new Container(
            child: new TabBar(
              controller: _controller,
              tabs: [
                Tab(
                  text: 'Beli',
                ),
                Tab(
                  text: 'Jual',
                ),
                Tab(
                  text: 'Dibeli',
                ),
              ],
            ),
          ),
          new Container(
            height: 250,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                Container(
                  child: Text("buy list"),
                ),
                Container(
                  child: Text("sell list"),
                ),
                Container(
                  child: Text("bought list"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
