import 'package:flutter/material.dart';
import 'package:my_first_app/pages/details.dart';
import 'package:my_first_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello Dushan,", style: AppWidget.boldTextFieldStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Text(
                "Pick Your Choice,",
                style: AppWidget.HeadlineTextFieldStyle(),
              ),
              Text(
                "Quality and Fast Delivery,",
                style: AppWidget.LightTextFieldStyle(),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: showItem(),
              ),
              SizedBox(height: 30.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Details()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "images/salad2.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Veggie Taco Hash",
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Fresh & Healthy",
                                  style: AppWidget.LightTextFieldStyle(),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "\$25",
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/salad4.png",
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Mix Veg Salad",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "Spicy with Onion",
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "\$28",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/salad2.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Mediterrinean Chickpea Salad",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Honey groot Cheese",
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "\$27",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            pizza = true;
            icecream = false;

            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.redAccent : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "images/pizza.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            pizza = false;
            icecream = true;
            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Colors.redAccent : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "images/ice-cream.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            pizza = false;
            icecream = false;
            burger = true;
            salad = false;

            setState(() {});
          },

          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.redAccent : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "images/burger.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            pizza = false;
            icecream = false;
            burger = false;
            salad = true;
            setState(() {});
          },

          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: salad ? Colors.redAccent : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "images/salad.png",
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
