import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product/products_cubit.dart';
import '../models/product.dart';
import '../routes.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductsCubit>().fetch();
    });
    controller.addListener(() {
      if ((controller.position.pixels == controller.position.maxScrollExtent) && context.read<ProductsCubit>().hasMoreData) {
        context.read<ProductsCubit>().fetch();
      }
    });
    super.initState();
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Screen')),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        builder: (context, state) => (state is ProductsInitial)
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => (index >= context.read<ProductsCubit>().products.length)
                        ? const Center(child: CircularProgressIndicator())
                        : Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: Builder(
                              builder: (context) {
                                Product currentProduct = context.read<ProductsCubit>().products[index];
                                num discountedPrice = currentProduct.price - ((currentProduct.discountPercentage / 100) * currentProduct.price);
                                return ListTile(
                                  onTap: () {
                                    OnGenerateRoute.navigationKey.currentState?.pushNamed(RouteNames.singleProduct, arguments: currentProduct);
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CircleAvatar(
                                      child: CachedNetworkImage(
                                        imageUrl: currentProduct.thumbnail,
                                        placeholder: (context, url) => const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                        fit: BoxFit.fill,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                  title: Text(currentProduct.title),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(currentProduct.description),
                                      const SizedBox(height: 16),
                                      Text('price \$${currentProduct.price}'),
                                      const SizedBox(height: 16),
                                      Text('discounted Price ${discountedPrice.toStringAsFixed(2)}'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                    itemCount: context.read<ProductsCubit>().hasMoreData
                        ? context.read<ProductsCubit>().products.length + 1
                        : context.read<ProductsCubit>().products.length,
                  ),
                ),
              ),
        listener: (context, state) {},
      ),
    );
  }
}
