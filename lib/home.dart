import 'package:flutter/material.dart';
import 'menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String totalPrice = menuItems.first.getTotalPrice();
  MenuItem selectedItem = menuItems.first;
  String selectedSize = 'Medium';  // Track the selected size

  void updateItem(MenuItem item) {
    setState(() {
      selectedItem = item;
      totalPrice = item.getTotalPrice();
    });
  }

  void updateSize(String size) {
    setState(() {
      selectedSize = size;
      selectedItem.size = size;
      totalPrice = selectedItem.getTotalPrice();
    });
  }

  void updateExtras(List<String> extras) {
    setState(() {
      selectedItem.extras = extras;
      totalPrice = selectedItem.getTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Menu',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const Text('Select Your Item', style: TextStyle(fontSize: 25.0 ,color: Colors.deepPurple)),
            const SizedBox(height: 10.0),
            MenuWidget(
              updateItem: updateItem,
              selectedItem: selectedItem,  // Pass the selected item
            ),
            const SizedBox(height: 10.0),
            SizeSelectorWidget(
              selectedSize: selectedSize,  // Pass the selected size
              updateSize: updateSize,
            ),
            const SizedBox(height: 10.0),
            ExtraSelectorWidget(updateExtras: updateExtras),
            const SizedBox(height: 10.0),
            Text(
              'Total Price: \$${totalPrice}',
              style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold ,color: Colors.green),
            ),
            const SizedBox(height: 20.0),
            // Add a static image here
        Image.network(
            'https://c8.alamy.com/comp/2R6JPGB/pizza-burger-and-other-fast-food-on-black-table-flat-lay-2R6JPGB.jpg')
          ],
        ),
      ),
    );
  }
}
