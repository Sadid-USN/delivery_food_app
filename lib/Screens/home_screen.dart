import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/Screens/cart_screen.dart';
import 'package:flutter_food_delivery_ui/Screens/restaurant_screen.dart';
import 'package:flutter_food_delivery_ui/data/data.dart';
import 'package:flutter_food_delivery_ui/data/widget/raiting_stars.dart';
import 'package:flutter_food_delivery_ui/data/widget/recent_orders.dart';
import 'package:flutter_food_delivery_ui/models/restaurant.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildRestaurants() {
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(
        GestureDetector(
          onTap: () {
            return Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => RestaurantScreen(restaurant: restaurant)));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(width: 0.7, color: Colors.grey[300])),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Hero(
                          tag: restaurant.imageUrl,
                          child: Image(
                            height: 150.0,
                            width: 150.0,
                            image: AssetImage(restaurant.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              RatinhStars(restaurant.rating),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                restaurant.address,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                '0.2 milse away',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return Column(
      children: restaurantList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          iconSize: 30.0,
          onPressed: () {},
          icon: Icon(
            Icons.account_circle,
          ),
        ),
        title: const Text('Food Delivery'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CartSreen();
                }));
              },
              child: Text(
                'Cart (${currentUser.cart.length})',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ))
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 90,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextFormField(
              textAlign: TextAlign.start,
              // cursorHeight: 30,

              cursorRadius: Radius.circular(10),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  // contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        BorderSide(width: 0.8, color: Colors.deepOrangeAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        width: 0.8, color: Theme.of(context).primaryColor),
                  ),
                  hintText: 'Search Food or Restaurants',
                  suffix: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.clear,
                        )),
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 25.0,
                      ),
                    ),
                  )),
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Nearby Restaurants',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              _buildRestaurants(),
            ],
          )
        ],
      ),
    );
  }
}
