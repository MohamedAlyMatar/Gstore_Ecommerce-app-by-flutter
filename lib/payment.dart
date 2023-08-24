import 'package:flutter/material.dart';
import 'package:gstore/classes.dart';
import 'package:gstore/widgets.dart';
import 'package:provider/provider.dart';

class payment extends StatefulWidget {
  payment({Key? key}) : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  MyWidgets w = MyWidgets();

  @override
  Widget build(BuildContext context) {
    final bucket = Provider.of<Bucket>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: MyColors.LightAccentColor,
            leading: IconButton(
              icon: const Icon(IconData(0xe093,
                  fontFamily: 'MaterialIcons', matchTextDirection: true)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Payment",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/logos/cashless_payment.png",
                            height: 150, width: 150),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      w.entryField2(Theme.of(context).colorScheme, "Card Number", "16 digit", false,
                          const Icon(Icons.credit_card)),
                      w.entryField2(
                          Theme.of(context).colorScheme, "Card Name", "name", false, const Icon(Icons.person)),
                      w.entryField2(Theme.of(context).colorScheme, "Address", "your address", false,
                          const Icon(Icons.gps_fixed_rounded)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: w.entryField3(
                                "City",
                                "your city",
                                false,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: w.entryField3(
                                "State",
                                "your state",
                                false,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: w.entryField3(
                                "Zip Code",
                                "your zip code",
                                false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      w.inkButton("Pay \$ ${bucket.total}", Colors.orange,
                          const Icon(Icons.payment_rounded))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
