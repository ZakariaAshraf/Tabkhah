import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab5ah/features/shopping_list/data/shopping_list_item_model.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../config/utils/app_colors.dart';
import '../cubit/shopping_list_cubit.dart' show ShoppingListCubit;

class ShoppingListWidget extends StatelessWidget {
  final List<ShoppingListItem> items;

  const ShoppingListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.read<ShoppingListCubit>().saveDataToFirestore();
              },
              icon: const Icon(Icons.save),
              label: const Text('Save to later'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff7B4019),
                foregroundColor: Colors.white,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                context.read<ShoppingListCubit>().clearShoppingList();
              },
              icon: const Icon(Icons.delete_forever),
              label: const Text('Clear All'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red.shade700,
                side: BorderSide(color: Colors.red.shade400),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF6E9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffFFBF78)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/listicon.png",
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// Ingredient name
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFFBF78),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Text(
                              item.name,
                              style: GoogleFonts.museoModerno(
                                fontSize: 14,
                                color: const Color(0xff7B4019),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),

                          /// Measure + Toggle
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Text(
                                  item.measure,
                                  style: GoogleFonts.museoModerno(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff7B4019),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              ToggleSwitch(
                                minWidth: 40.0,
                                minHeight: 40.0,
                                initialLabelIndex: item.isChecked ? 0 : 1,
                                cornerRadius: 20.0,
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.white,
                                totalSwitches: 2,
                                icons: const [
                                  Icons.add_shopping_cart,
                                  Icons.remove_shopping_cart
                                ],
                                iconSize: 30.0,
                                activeBgColors: const [
                                  [AppColors.secondery],
                                  [Colors.black45, Colors.black26],
                                ],
                                // animate: true,
                                // curve: Curves.bounceInOut,
                                onToggle: (index) {
                                  final shouldBeChecked = index == 0;
                                  if (item.isChecked != shouldBeChecked) {
                                    context
                                        .read<ShoppingListCubit>()
                                        .toggleItemCheck(item.name);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red.shade400,
                      onPressed: () {
                        context.read<ShoppingListCubit>().removeItem(item.name);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
