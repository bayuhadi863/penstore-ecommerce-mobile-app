import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/profile/user_controller.dart';
import 'package:penstore/controller/auth/logout_controller.dart';
import 'package:penstore/widgets/profile/add_product_widget.dart';
import 'package:penstore/widgets/profile/buy_list_widget.dart';
import 'package:penstore/widgets/profile/profile_image_widget.dart';
import 'package:penstore/widgets/profile/sell_list_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userController = Get.put(UserController());
  //final _formKey = GlobalKey<FormState>();
  final FocusNode _searchFocusNode = FocusNode();

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
          Container(
            child: const Column(
              children: [
                Text(
                  "Senjani Thania",
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Email"), Text("Email")],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => BuyListProfile(),
                  child: Text("Beli"),
                ),
                GestureDetector(
                  onTap: () => SellListProfile(),
                  child: Text("Jual"),
                ),
                GestureDetector(
                  child: Text("Dibeli"),
                )
              ],
            ),
          ),
          const AddProductForm(),
        ],
      ),
    );
  }
}
