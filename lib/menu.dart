import 'package:flutter/material.dart';

class MenuItem {
  String name;
  int price;
  String size = 'Medium';
  List<String> extras = [];

  MenuItem(this.name, this.price);

  @override
  String toString() {
    return '$name - \$$price';
  }

  String getTotalPrice() {
    int extraCost = extras.length * 2;  // Each extra costs $2
    int sizeCost = size == 'Large' ? 3 : (size == 'Small' ? -2 : 0); // Small (-$2), Medium (base price), Large (+$3)
    return (price + extraCost + sizeCost).toStringAsFixed(0);
  }
}

List<MenuItem> menuItems = [
  MenuItem('Pasta', 12),
  MenuItem('Burger', 8),
  MenuItem('Salad', 5),
  MenuItem('Pizza', 15),
];

class MenuWidget extends StatelessWidget {
  final Function(MenuItem) updateItem;
  final MenuItem selectedItem;

  const MenuWidget({required this.updateItem, required this.selectedItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MenuItem>(
      value: selectedItem,
      items: menuItems.map<DropdownMenuItem<MenuItem>>((MenuItem item) {
        return DropdownMenuItem<MenuItem>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: (MenuItem? item) {
        if (item != null) {
          updateItem(item);
        }
      },
    );
  }
}

class SizeSelectorWidget extends StatelessWidget {
  final String selectedSize;
  final Function(String) updateSize;

  const SizeSelectorWidget({required this.selectedSize, required this.updateSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Select Size: ', style: TextStyle(fontSize: 18.0)),
        DropdownButton<String>(
          value: selectedSize,
          items: ['Small', 'Medium', 'Large'].map<DropdownMenuItem<String>>((String size) {
            return DropdownMenuItem<String>(
              value: size,
              child: Text(size),
            );
          }).toList(),
          onChanged: (size) {
            if (size != null) {
              updateSize(size);
            }
          },
        ),
      ],
    );
  }
}

class ExtraSelectorWidget extends StatefulWidget {
  final Function(List<String>) updateExtras;

  const ExtraSelectorWidget({required this.updateExtras, Key? key}) : super(key: key);

  @override
  State<ExtraSelectorWidget> createState() => _ExtraSelectorWidgetState();
}

class _ExtraSelectorWidgetState extends State<ExtraSelectorWidget> {
  final List<String> _selectedExtras = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Select Extras: ', style: TextStyle(fontSize: 18.0)),
        CheckboxListTile(
          title: const Text('Cheese'),
          value: _selectedExtras.contains('Cheese'),
          onChanged: (bool? selected) {
            setState(() {
              if (selected == true) {
                _selectedExtras.add('Cheese');
              } else {
                _selectedExtras.remove('Cheese');
              }
              widget.updateExtras(_selectedExtras);
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Avocado'),
          value: _selectedExtras.contains('Avocado'),
          onChanged: (bool? selected) {
            setState(() {
              if (selected == true) {
                _selectedExtras.add('Avocado');
              } else {
                _selectedExtras.remove('Avocado');
              }
              widget.updateExtras(_selectedExtras);
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Bacon'),
          value: _selectedExtras.contains('Bacon'),
          onChanged: (bool? selected) {
            setState(() {
              if (selected == true) {
                _selectedExtras.add('Bacon');
              } else {
                _selectedExtras.remove('Bacon');
              }
              widget.updateExtras(_selectedExtras);
            });
          },
        ),
      ],
    );
  }
}
