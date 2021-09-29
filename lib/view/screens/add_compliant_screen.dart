import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grumbler/bloc/geocoding_bloc.dart';
import 'package:grumbler/models/address_item.dart';
import 'package:velocity_x/velocity_x.dart';

class AddComplaintScreen extends StatelessWidget {
  final LatLng latLng;

  AddComplaintScreen({Key? key, required this.latLng}) : super(key: key);

  final TextEditingController provinceTextEditingController =
      TextEditingController();

  final TextEditingController districtTextEditingController =
      TextEditingController();

  final TextEditingController streetTextEditingController =
      TextEditingController();

  final TextEditingController townTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: "Şikayet Ekleyin".text.make(),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPhotoSection(context),
                _buildAddressSectionBlocBuilder(),
                _buildSocialMediaSection(),
                20.heightBox,
                Material(
                  color: context.theme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        "Gönder",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ).centered(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CupertinoFormSection _buildSocialMediaSection() {
    return CupertinoFormSection(
        header: "Sosyal Medya".text.bold.make(),
        children: [
          CupertinoFormRow(
            child: CupertinoSwitch(
              value: false,
              onChanged: (value) {},
            ),
            prefix: "İsmim yayınlansın".text.make(),
          ),
          CupertinoFormRow(
            child: CupertinoSwitch(
              value: true,
              onChanged: (value) {},
            ),
            prefix: "Twitter'da paylaş".text.make(),
          ),
          CupertinoFormRow(
            child: CupertinoSwitch(
              value: true,
              onChanged: (value) {},
            ),
            prefix: "Facebook'ta paylaş".text.make(),
          ),
        ]);
  }

  CupertinoFormSection _buildPhotoSection(BuildContext context) {
    return CupertinoFormSection(
        header: "Fotograf Yükleyin".text.bold.make(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
                child: Row(
              children: [
                Container(
                  child: const Center(
                    child: Icon(Icons.add),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  width: 80,
                  height: 80,
                ),

              ],
            )),
          ),
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
                placeholder: "Notlarınız",
            ),

          ),
        ]);
  }

  Widget _buildAddressSectionBlocBuilder() {
    return BlocBuilder<GeocodingBloc, GeocodingState>(
        builder: (context, state) {
      if (state is GeocodingLoadedState) {
        AddressItem? addressItem = state.addressItem;
        provinceTextEditingController.text = addressItem!.province;
        districtTextEditingController.text = addressItem.district;
        streetTextEditingController.text = addressItem.street!;
        townTextEditingController.text = addressItem.town!;
        return _buildAddressCard(addressItem);
      } else {
        return CupertinoFormSection(
            header: "Konum bilgileri yükleniyor".text.make(),
            children: const [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 30,
                    width: 30,
                  ),
                ),
              )
            ]);
      }
    });
  }

  /// Adres bilgisi sadece geocoding blocdan gelmeyebilir. Varolan bir kayıt gösterilecekse ?
  CupertinoFormSection _buildAddressCard(AddressItem? addressItem) {
    return CupertinoFormSection(
        header: "Konum bilgileri".text.bold.make(),
        children: [
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
              controller: provinceTextEditingController,
              placeholder: "İl giriniz",
            ),
            prefix: "İl".text.bold.make(),
          ),
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
              controller: districtTextEditingController,
              placeholder: "İlçe giriniz",
            ),
            prefix: "İlçe".text.bold.make(),
          ),
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
              controller: townTextEditingController,
              placeholder: "Semt giriniz",
            ),
            prefix: "Semt / Mahalle".text.bold.make(),
          ),
          CupertinoFormRow(
            child: CupertinoTextFormFieldRow(
              controller: streetTextEditingController,
              placeholder: "Yol / Sokak adı",
            ),
            prefix: "Yol / Sokak".text.bold.make(),
          )
        ]);
  }
}
