import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab5ah/features/body_balance/data/balance_user_details.dart';
import '../views/body_details_view.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/drop_down_field.dart';
import '../widgets/primary_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _gender;

  bool get _areAllFieldsFilled {
    return _gender != null &&
        _gender!.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _ageController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Enter your details",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                "Gender",
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              CustomDropDownField(
                label: "Choose your gender",
                items: const ["Male", "Female"],
                onChanged: (val) => setState(() => _gender = val),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Weight",
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _weightController,
                suffixText: "KG",
                hintText: "Enter your weight",
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Height",
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _heightController,
                suffixText: "CM",
                hintText: "Enter your height",
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Age",
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _ageController,
                hintText: "Enter your age",
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(
                height: 45,
              ),
              PrimaryButton(
                title: "Next",
                color:
                    _areAllFieldsFilled ? const Color(0xffF25700) : Colors.grey,
                onTap: _areAllFieldsFilled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BodyDetailsView(
                                userDetails: UserDetails(
                                  gender: _gender!,
                                  weight: double.parse(
                                      _weightController.text.trim()),
                                  height: double.parse(
                                      _heightController.text.trim()),
                                  age: double.parse(_ageController.text.trim()),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
