import 'package:ateammt/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:provider/provider.dart';

class ProductListBase extends StatelessWidget {
  const ProductListBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text("Product List"),
      ),
      backgroundColor: Colors.red[400],
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => ProductState(),
          child: const ProductListView(key: Key("list")),
        ),
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  Widget _getBody(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    switch (Provider.of<ProductState>(context).pageView) {
      case PageViewType.waiting:
        return const Center(
          child: CircularProgressIndicator(),
        );
        break;
      case PageViewType.active:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                // childAspectRatio: MediaQuery.of(context).size.aspectRatio,
              ),
              itemCount: Provider.of<ProductState>(context).productList.length,
              itemBuilder: (context, index) {
                final item =
                    Provider.of<ProductState>(context).productList[index];

                return GestureDetector(
                  onTap: (() {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            height: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Category: ${item.category ?? ""}",
                                    maxLines: 1,
                                  ),
                                ),
                                if (item.rating?.rate != null)
                                  RatingBar.builder(
                                    itemSize: 14,
                                    initialRating: item.rating.rate,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    onRatingUpdate: (va) {},
                                    itemPadding: EdgeInsets.zero,
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        if (item.image != null)
                          Image.network(
                            item.image,
                            fit: BoxFit.contain,
                            height: 100,
                            width: double.infinity,
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                item.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    item.category ?? "",
                                    maxLines: 1,
                                  )),
                                  Text(
                                    "₹${item.price.toStringAsFixed(2)}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
        break;
      case PageViewType.error:
        return Center(
          child: GestureDetector(
            onTap: () async {
              await Provider.of<ProductState>(context).fetchProductsList();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Provider.of<ProductState>(context).errorText ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.refresh,
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
        break;
      default:
        return Container();
    }
  }
}
