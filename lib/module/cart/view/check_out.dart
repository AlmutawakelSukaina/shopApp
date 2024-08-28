import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../libs.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  CheckOutPageState createState() => CheckOutPageState();
}

class CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _paymentMethod;
  final _proofOfPaymentImage = ValueNotifier<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _proofOfPaymentImage.value = File(pickedFile.path);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _proofOfPaymentImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: customAppBar(title: "Check out"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              CustomTextField(
                textEditingController: _fullNameController,
                hint: "Full Name",
                textInputType: TextInputType.text,
                validator: (value) {
                  return checkEmpty(value);
                },
              ),
              16.ph,
              CustomTextField(
                textEditingController: _phoneNumberController,
                textInputType: TextInputType.phone,
                hint: "Phone Number",
                validator: (value) {
                  return checkEmpty(value);
                },
              ),
              16.ph,
              CustomTextField(
                textEditingController: _addressController,
                hint: "Address",
                validator: (value) {
                  return checkEmpty(value);
                },
              ),
              16.ph,
              StatefulBuilder(
                builder: (context, setState) {
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Payment Method (Optional)',
                        labelStyle: TextStyle(
                          fontFamily: appFont,
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        )),
                    value: _paymentMethod,
                    items: ['Credit Card', 'PayPal', 'Bank Transfer']
                        .map((method) => DropdownMenuItem(
                              value: method,
                              child: CustomTextApp(text: method),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                  ).roundedWidget();
                },
              ),
              16.ph,
              ValueListenableBuilder(
                valueListenable: _proofOfPaymentImage,
                builder: (context, value, child) {
                  return _proofOfPaymentImage.value == null
                      ? TextButton.icon(

                          onPressed: _pickImage,
                          icon:   Icon(Icons.camera_alt,color:
                            AppColors.orange,),
                          label: const CustomTextApp(
                              text: 'Upload Proof of Payment (Optional)'),
                        )
                      : Image.file(_proofOfPaymentImage.value!, height: 200);
                },
              ),
              16.ph,
              CustomButton(
                onPressed: () {
                  if(_formKey.currentState!.validate())
                    {
                      sl<OrderProvider>().postOrder(sl<CartProvider>().allProduct);

                    }

                },
                text: "Send Orders",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
