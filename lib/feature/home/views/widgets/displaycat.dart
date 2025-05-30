import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/cubits/cubit/cubit_category.dart';
import 'package:task_list/cubits/cubit/data_cubit.dart';
import 'package:task_list/feature/displayCategories/views/display_catePage.dart';
import 'package:task_list/generated/l10n.dart';

class DisplayCAt extends StatelessWidget {
  const DisplayCAt({super.key});

  // Helper function to get translated category name if available
  String getTranslatedCategory(BuildContext context, String key) {
    final s = S.of(context);

    final Map<String, String> translations = {
      'work': s.work,
      'personal': s.personal,
      'shopping': s.shopping,
      'health': s.health,
      'home': s.homee,
    };

    return translations[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    var listCat = context.read<CategoryCubit>().categories.toList();
    DataCubit cubit = context.read<DataCubit>();
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      width: screenWidth * 0.9,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listCat.length,
        itemBuilder: (BuildContext context, int index) {
          final category = listCat[index];
          return GestureDetector(
            onTap: () {
              cubit.category = getTranslatedCategory(context, category);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DisplayCatepage(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 150,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 50.0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          getTranslatedCategory(context, category),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
