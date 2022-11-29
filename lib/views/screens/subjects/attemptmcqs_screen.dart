import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/models/test_mcqs_model.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import '../../../services/mcqs_service.dart';

class AttemptmcqsScreen extends StatefulWidget {
  static const String id = "attempt_mcqs_screen";
  final String subject;
  final String isUrdu;
  final String chapter;
  const AttemptmcqsScreen(
      {Key? key,
      required this.isUrdu,
      required this.subject,
      required this.chapter})
      : super(key: key);

  @override
  State<AttemptmcqsScreen> createState() => _AttemptmcqsScreenState();
}

class _AttemptmcqsScreenState extends State<AttemptmcqsScreen> {
  McqsService mcqsService = McqsService();
  bool isLoading = false;
  final List<TestViewMcqs> testmcqs = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getMcqsData();
    });
  }

  Future<void> getMcqsData() async {
    try {
      setState(() {
        isLoading = true;
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      log('Error in Mcqs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.blacklight,
        title: const Text(
          'MCQs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 1.2,
                  child: Column(
                    children: [
                      Text(
                        "Timer ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: AppColors.black,
                            fontSize: AppDimensions.overlarge),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        "Class : ${(AppConstants.myClass)}" " || Subject : ${(widget.subject)}" 
                            " || chapter : ${(widget.chapter)}",
                        style: TextStyle(
                            // fontStyle: FontStyle.italic,
                            color: AppColors.black,
                            fontSize: AppDimensions.extralarge),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}
