import 'package:flutter/material.dart';
import 'package:tab5ah/config/utils/app_colors.dart';
import '../../../data/models/meal_model.dart'; // Update the import path as needed

class SelectIngredientsDialog extends StatefulWidget {
  final List<Ingredient> ingredients;

  const SelectIngredientsDialog({super.key, required this.ingredients});

  @override
  State<SelectIngredientsDialog> createState() =>
      _SelectIngredientsDialogState();
}

class _SelectIngredientsDialogState extends State<SelectIngredientsDialog> {
  late List<bool> _selected;

  @override
  void initState() {
    _selected = List.generate(widget.ingredients.length, (_) => true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var theme =Theme.of(context).textTheme;
    return AlertDialog(
      backgroundColor:AppColors.primary ,
      title: const Text('Select Ingredients'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.ingredients.length,
          itemBuilder: (context, index) {
            final ingredient = widget.ingredients[index];
            return CheckboxListTile(
             activeColor: AppColors.secondery,
              value: _selected[index],
              onChanged: (value) {
                setState(() {
                  _selected[index] = value ?? false;
                });
              },
              title: Text(ingredient.name,style: theme.titleMedium,),
              subtitle: Text(ingredient.measure,style: theme.titleMedium!.copyWith(color: Colors.black),),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child:  Text('Cancel',style: theme.titleMedium,),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff7B4019),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            final selectedIngredients = <Ingredient>[];
            for (int i = 0; i < widget.ingredients.length; i++) {
              if (_selected[i]) {
                selectedIngredients.add(widget.ingredients[i]);
              }
            }
            Navigator.of(context).pop(selectedIngredients);
          },
          child:  Text('Add',style:theme.titleMedium!.copyWith(color: AppColors.primary),),
        ),
      ],
    );
  }
}
