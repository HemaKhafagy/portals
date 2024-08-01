import 'package:Portals/layout/cubit/cubit.dart';
import 'package:Portals/layout/cubit/states.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Portals/shared/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:Portals/shared/constants.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeTapsCubit, HomeTapsCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeTapsCubit homeTapsCubitAccess = HomeTapsCubit.get(context);
        return Scaffold(
          body: Container(
            color: Color.fromRGBO(0, 0, 0, 1),
            height: screenHeight,
            padding: EdgeInsets.all(10),
            child: homeTapsCubitAccess.updateUserDataIsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(Icons.close),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildPageTextFormFiled(
                                  homeTapsCubitAccess
                                      .editProfileFirstNameController,
                                  "${homeTapsCubitAccess.userData!.firstName}",
                                  "First Name",
                                  false, (String? value) {
                                if (value!.isEmpty) {
                                  return 'Invalid name!';
                                }
                                return null;
                              }),
                              buildPageTextFormFiled(
                                  homeTapsCubitAccess
                                      .editProfileLastNameController,
                                  "${homeTapsCubitAccess.userData!.lastName}",
                                  "Last Name",
                                  false, (String? value) {
                                if (value!.isEmpty) {
                                  return 'Invalid name!';
                                }
                                return null;
                              }),
                              buildPageTextFormFiled(
                                  homeTapsCubitAccess
                                      .editProfileEmailController,
                                  "${homeTapsCubitAccess.userData!.email ?? ""}",
                                  "Email",
                                  false, (String? value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Invalid email!';
                                }
                                return null;
                              }),
                              Row(
                                children: [
                                  buildDropDownButton(
                                      context,
                                      screenWidth,
                                      homeTapsCubitAccess.editCountryController,
                                      homeTapsCubitAccess.userData!.country!),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: buildPageTextFormFiled(
                                        homeTapsCubitAccess.editCityController,
                                        "${homeTapsCubitAccess.userData!.city}",
                                        "City",
                                        false, (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Invalid City!';
                                      }
                                      return null;
                                    }),
                                  ),
                                ],
                              ),
                              buildPageTextFormFiled(
                                  homeTapsCubitAccess.editAboutYouController,
                                  "${homeTapsCubitAccess.userData!.about}",
                                  "About",
                                  true, (String? value) {
                                return null;
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            buildSharedButton(
                                buttonName: "Save Changes",
                                isEnabled: true,
                                action: () {
                                  homeTapsCubitAccess.updateUserData(context);
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget buildDropDownButton(BuildContext context, double screenWidth,
          TextEditingController controller, String hint) =>
      Container(
        width: screenWidth * 0.4,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TextField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w200),
                ),
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode:
                        false, // optional. Shows phone code before the country name.
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Colors.white,
                      textStyle:
                          TextStyle(fontSize: 16, color: Colors.blueGrey),
                      bottomSheetHeight:
                          500, // Optional. Country list modal height
                      //Optional. Sets the border radius for the bottomsheet.
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      //Optional. Styles the search field.
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    onSelect: (Country country) {
                      print('Select country: ${country.displayName}');
                      controller.text = country.name;
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Country",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );

  Widget buildCityFiled(BuildContext context, double screenWidth) => Container(
        padding: EdgeInsets.all(8),
        width: screenWidth * 0.4,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              "Country",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            )),
            Icon(FontAwesomeIcons.arrowDown)
          ],
        ),
      );

  Widget buildPageTextFormFiled(TextEditingController controller,
          String hintText, String labelText, bool multiLine, var validator) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: multiLine ? 80 : 40,
            child: TextFormField(
              controller: controller,
              keyboardType: multiLine ? TextInputType.multiline : null,
              minLines: multiLine ? 5 : null,
              maxLines: multiLine ? 5 : null,
              decoration: InputDecoration(
                contentPadding: // Text Field height
                    const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w200),
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: validator,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            labelText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
}
