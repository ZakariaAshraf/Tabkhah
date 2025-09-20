import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab5ah/features/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:tab5ah/features/shopping_list/widgets/shopping_list_widget.dart';

import '../../../components/default_message_card.dart';
import '../../../config/utils/app_colors.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {


  @override
  void initState() {
    super.initState();
    final cubit = context.read<ShoppingListCubit>();

    if (cubit.shoppingList.isEmpty) {
      cubit.loadShoppingList();
    } else {
      cubit.emit(ShoppingListUpdated(List.from(cubit.shoppingList)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context).textTheme;

  return Scaffold(
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final nameController = TextEditingController();
                final measureController = TextEditingController();

                return AlertDialog(
                  backgroundColor:AppColors.primary ,

                  title: const Text("Add New Item"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        style: theme.titleMedium ,
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Item Name",
                        ),
                      ),
                      TextField(
                        style: theme.titleMedium,
                        controller: measureController,
                        decoration: const InputDecoration(
                          labelText: "Measure (optional)",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child:  Text("Cancel",style: theme.titleMedium,),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff7B4019),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        final name = nameController.text.trim();
                        final measure = measureController.text.trim();

                        if (name.isNotEmpty) {
                          context.read<ShoppingListCubit>().addItem(
                            name,
                            measure.isEmpty ? "-" : measure,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child:  Text("Add",style:theme.titleMedium!.copyWith(color: AppColors.primary),),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.add, size: 12),
          label: const Text(
            'Add new item',
            style: TextStyle(fontSize: 10),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff7B4019),
            foregroundColor: Colors.white,
          ),
        ),

        const SizedBox(height: 20,),
        ElevatedButton.icon(
          onPressed: () {
            // future external share ISA
          },
          icon: const Icon(Icons.share,size: 12,),
          label: const Text('Share to maid',style: TextStyle(fontSize: 10),),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff7B4019),
            foregroundColor: Colors.white,
          ),
        ),
      ],
    ),
      appBar: AppBar(
        title: Text("Shopping list",style: theme.titleMedium,),
        centerTitle: true,
      ),
      body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
        builder: (context, state) {
          if (state is ShoppingListInitial) {
            return const DefaultMessageCard(
              sign: '0_0',
              title: "Your shopping list is empty ",
              subTitle: "favorite",
            );
          }
          else if (state is ShoppingListLoading) {
            return const CircularProgressIndicator();
          } else if (state is ShoppingListUpdated) {
            if (state.items.isEmpty) {
              return const DefaultMessageCard(
                sign: '0_0',
                title: "Your shopping list is empty",
                subTitle: "favorite",
              );
            }
            return ShoppingListWidget(items: state.items);
          }else {
            return const Text("no data");
          }
        },
      ),
    );
  }
}
