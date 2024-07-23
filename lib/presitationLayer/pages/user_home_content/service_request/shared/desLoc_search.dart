import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../../dataLayer/constants/enum.dart';
import '../../../../../dataLayer/constants/variables.dart';
import '../../../../../dataLayer/bloc/serviceRequest/bloc/service_request_bloc.dart';
import '../../../../../dataLayer/models/currentUser.dart';

class DesLocSearch extends StatefulWidget {
  DesLocSearch({
    super.key,
  });

  @override
  State<DesLocSearch> createState() => _DesLocSearchState();
}

class _DesLocSearchState extends State<DesLocSearch> {
  FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ServiceRequestBloc>(context);

    return Autocomplete<Prediction>(
      displayStringForOption: (x) => x.description ?? '',
      fieldViewBuilder: (BuildContext context,
          TextEditingController destinationCtrl,
          searchFocusNode,
          VoidCallback onFieldSubmitted) {
        destinationCtrl.text = cubit.request.destinationAddress ?? '';
        return TextField(
          onTap: () {
            // cubit.request.changePicker();
            cubit.request.fieldPin = MapPickerStatus.destination;
            destinationCtrl.selection = TextSelection(
              baseOffset: 0,
              extentOffset: destinationCtrl.text.length,
            );
          },
          controller: destinationCtrl,
          focusNode: searchFocusNode,
          decoration: appInput.copyWith(
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                  right: CurrentUser.isArabic ? 0 : 10,
                  left: CurrentUser.isArabic ? 10 : 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffc8ddd0),
                  borderRadius: CurrentUser.isArabic
                      ? BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                        ),
                ),
                width: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "towing destination".tr,
                        style: GoogleFonts.tajawal(
                          textStyle: const TextStyle(
                            color: appBlack,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            hintMaxLines: 3,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(600.0),
            ),
            errorBorder: InputBorder.none,
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<Prediction> onSelected,
          Iterable<Prediction> options) {
        return SizedBox(
          width: Get.width,
          height: Get.height * .4,
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              child: Container(
                color: appWhite,
                height: Get.height * .4,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(30.0),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final Prediction option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () async {
                              searchFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(searchFocusNode);
                              onSelected(option);
                              String distenationString =
                                  '${option.structuredFormatting!.mainText}+${option.structuredFormatting!.secondaryText}';
                              cubit.request.destinationAddress =
                                  distenationString;
                              LatLng x =
                                  await cubit.getLatLang(distenationString);
                              cubit.request.towingDestination = x;
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Column(children: [
                                        const Icon(
                                          MdiIcons.mapMarker,
                                          color: mainColor,
                                        ),
                                        Text(
                                          option.distanceMeters != null
                                              ? (option.distanceMeters! / 1000)
                                                  .toStringAsFixed(1)
                                              : "",
                                          style: GoogleFonts.tajawal(
                                            textStyle: const TextStyle(
                                              color: appBlack,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          option.structuredFormatting!.mainText
                                              .toString(),
                                          style: GoogleFonts.tajawal(
                                            textStyle: const TextStyle(
                                              color: appBlack,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ),
                                        option.structuredFormatting!
                                                    .secondaryText !=
                                                null
                                            ? SizedBox(
                                                child: Text(
                                                  option.structuredFormatting!
                                                      .secondaryText
                                                      .toString(),
                                                  style: GoogleFonts.tajawal(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ))
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (textEditingValue) async {
        if (textEditingValue.text == '') {
          return [];
        }
        if (textEditingValue.text.length > 2 &&
            textEditingValue.text.length < 20) {
          var res = await cubit.searchPlace(textEditingValue.text);
          return res.predictions;
        }
        return [];
      },
    );
  }
}