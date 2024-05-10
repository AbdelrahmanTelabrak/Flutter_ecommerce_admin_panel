import 'package:ecommerce_admin_panel/viewmodel/products_viewmodel.dart';
import 'package:ecommerce_admin_panel/widgets/buttons.dart';
import 'package:ecommerce_admin_panel/widgets/texts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'model/product_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewModel = ProductsViewModel();
  late Future<List<ProductModel>?> products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(color: Colors.blue.shade800));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade100,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                products = viewModel.getProducts();
                setState(() {});
              },
              backgroundColor: Colors.blue.shade800,
              child: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            body: (snapshot.data != null)
                ? SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 25),
                    child: Column(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 50,
                                        child: Image.network(snapshot.data![index].imagePath!),
                                      ),
                                      semiBoldText(snapshot.data![index].name!, size: 14, color: Colors.black),
                                      semiBoldText('${snapshot.data![index].price!} \$', size: 14, color: Colors.black),
                                    ],
                                  ),
                                ),
                                mainButton(
                                  'Delete',
                                  onPressed: () async {
                                    await viewModel.deleteProduct(snapshot.data![index].id!);
                                    products = viewModel.getProducts();
                                    setState(() {});
                                  },
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  )
                : Center(
                    child: semiBoldText('No available products',
                        size: 14, color: Colors.grey),
                  ),
          );
        }
      },
    );
  }

  Future<void> initProducts() async {
    products = viewModel.getProducts();
    await products;
  }
}
