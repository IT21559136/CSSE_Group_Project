import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
class SPHomePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const SPHomePage({required this.userData,Key? key}):super(key: key);

  @override
  State<SPHomePage> createState() => _SPHomePageState();
}

class _SPHomePageState extends State<SPHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> items = [
    'Cement',
    'Sand',
    'Blocks',
    'Rocks',
    'Wires',
    'Pipes',
  ];

  List<bool> selectedItems = List.generate(6, (index) => false);
  List<String> filteredItems = []; 
  
  @override
  void initState() {
    super.initState();
    // Initialize the filtered items list with all items
    filteredItems = items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RenoveteryX",
          style: TextStyle(
            fontFamily: 'OpenSans',
            color: Color.fromARGB(255, 61, 62, 63),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 208, 0),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back), // Add a back button icon
              onPressed: () {
                // Navigate back to the previous screen when the button is pressed
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(199, 158, 158, 158),
                    Color.fromARGB(136, 96, 125, 139)
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20.0),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.68,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Image.asset(
                        "assets/welcome_img.png",
                        width: 180.0,
                        height: 120.0,
                        scale: 0.1,
                      ),
                    ],
                  ),
                  SearchBarAnimation(
                    enableButtonBorder: true,
                    buttonBorderColour: Color.fromARGB(255, 48, 116, 161),
                    textEditingController: _searchController,
                    isOriginalAnimation: false,
                    trailingWidget: const Icon(Icons.search),
                    secondaryButtonWidget: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 100, 147, 170),
                    ),
                    buttonWidget: const Icon(Icons.search),
                    searchBoxWidth: 340.0,
                    onFieldSubmitted: (String value) {
                      debugPrint('onFieldSubmitted value $value');
                    },
                    onChanged: (value) {
                      // Filter the items based on the search query
                      setState(() {
                        filteredItems = items
                            .where((item) =>
                                item.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              color: Colors.grey, // Gray background color
              child: Container(
                width: double.infinity, // Match the screen width
                padding: EdgeInsets.symmetric(
                    vertical: 16.0), // Adjust vertical padding as needed
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 20.0, right:0.0),
                  child: Text(
                    'My Shop', // Your heading text
                    style: TextStyle(
                      fontSize: 24, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Make the text bold if needed
                    ),
                  ),
                  // You can add more widgets or text here if needed
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    padding: const EdgeInsets.all(16.0),
                    height: 50.0, // Set the desired height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          10.0), // Increase the corner radius
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x5f000000), // Increase shadow opacity
                          offset: Offset(0.0, 4.0), // Increase shadow offset
                          blurRadius: 12.0, // Increase shadow blur radius
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(items[index],
                            style: const TextStyle(fontSize: 16.0)),
                            Spacer(),
                        Icon(Icons.edit),
                        const SizedBox(width: 10.0),
                        Icon(Icons.delete)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}