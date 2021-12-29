// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:textformfield099/models/food.dart';
import 'package:textformfield099/models/subject.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key, required this.Title }) : super(key: key);

  final String Title ;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String? foodValue;


  late List<Food> foods;
  late List<Subject> subjects;

  List<ListItem> dropdownItems = ListItem.getListItem();
  late List<DropdownMenuItem<ListItem>> dropdownMenuItems;
  late ListItem _selectedItem;

  List selectedSubject = [];

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    subjects = Subject.getSubject();
    dropdownMenuItems = createDropdownMenu(dropdownItems);
    _selectedItem = dropdownMenuItems[0].value!;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.Title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
              children: [
                user(),
              const SizedBox(height: 14),
                password(),
              const SizedBox(height: 14),
              Column(
                children: createFoodRadio(),
              ),
              Text('Item Selected $foodValue'),
              const SizedBox(height: 14),
              Column(
                children: createSubjectCheckbox(),
              ),
              const SizedBox(height: 14),
              DropdownButton(
                value: _selectedItem,
                items: dropdownMenuItems, 
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value! as ListItem;
                  });
                }
                ),
                Text('Item selected :' + _selectedItem.name!),
                button()
              ],
                )
              ),
            ),
        ],
      ),
            
            );

  }

  ElevatedButton button() {
    return ElevatedButton(
                onPressed: () {
                if(_formKey.currentState!.validate()){
                  print(_usernamecontroller.text);
                }
                },
                child: Text('Submit')
                 );
  }

  TextFormField password() {
    return TextFormField(
              controller: _passwordcontroller,
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Password Please';
                  }
                  return null;
                } ,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                    focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.0,
                    )
                  )
                ),
                  );
  }

  TextFormField user() {
    return TextFormField(
                controller: _usernamecontroller,
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Enter Username Please';
                  }
                  return null;
                } ,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.0,
                    )
                  )
                ),
              );
  }

  List<Widget> createFoodRadio() {
    List<Widget> listRadioFood = [];

    for (var food in foods){
      listRadioFood.add(
        RadioListTile<dynamic>(
          title: Text(food.thName!),
          subtitle: Text(food.enName!),
          secondary: Text(food.price!.toString()),
          value: food.foodvalue,
          groupValue: foodValue,
          onChanged: (value) {
            setState(() {
              foodValue = value.toString();
                  });
                },
              ),
      );
    }

    return listRadioFood;
  }

  createSubjectCheckbox() {
    List<Widget> listCheckboxSubjcet = [];

    for (var subject in subjects){
      listCheckboxSubjcet.add(
        CheckboxListTile(
          title: Text(subject.subName!),
          subtitle: Text('credit: ${subject.credit}'),
          value: subject.checked,
          onChanged: (value) {
            setState(() {
              subject.checked = value!;
                  });
                //ให้เขียนดพิ่ม เอาไอเทมออกจาก ลิสต์
                if(value!){
                  selectedSubject.add(subject.subName!);
                } else {
                  selectedSubject.remove(subject.subName!);
                }
                print(selectedSubject);
                },
              ),
      );
    }

    return listCheckboxSubjcet;
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenu(List<ListItem> dropdownItems) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in dropdownItems){
      items.add(DropdownMenuItem(
        child: Text(item.name!),
        value : item,

      ));
    }

    return items;
  }

}
class ListItem {
  int? value;
  String? name;
  
  ListItem(this.value, this.name);

  static List<ListItem> getListItem() {
    return[
      ListItem(1, 'Item1'),
      ListItem(2, 'Item2'),
      ListItem(3, 'Item3'),
      ListItem(4, 'Item4'),
    ];

  }
}