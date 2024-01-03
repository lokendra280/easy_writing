import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_path_app/provider/homepage_provider.dart';
import 'package:learning_path_app/widgets/text_with_divider.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedCard = -1;
  List<Package> _offerings = [];

  @override
  void initState() {
    super.initState();
    fetchOfferings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Icon(
                  Icons.star,
                  size: 50,
                  color: Color(
                    0xFF4CAF50,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Subscription',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Benefits Included: General Writing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(
                    0xFF4CAF50,
                  ),
                ),
              ),
              const TextWithDividers(
                text: "Task 1) Formal Letters (60) Model Answers",
              ),
              const TextWithDividers(
                text: "Task 1) Semi-Formal Letters (60) Model Answers",
              ),
              const TextWithDividers(
                text: "Task 1) Informal Letters (60) Model Answers",
              ),
              const TextWithDividers(
                text: "Task 2) Essay Writing (60) Model Answers",
              ),
              const TextWithDividers(
                text:
                    "Tips for succeeding in IELTS General Writing or achieving a high score",
              ),
              const TextWithDividers(
                text:
                    "Study without distractions or advertisements, anytime and anywhere, even offline",
                moreContext: true,
              ),
              const Divider(
                thickness: 1.5,
              ),
              const SizedBox(
                height: 20,
              ),
              ..._offerings.map((package) => _buildCard(package)).toList(),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ), // Button size
                ),
                onPressed: () async {
                  if (selectedCard != -1) {
                    try {
                      final packageToPurchase = _offerings[selectedCard];
                      CustomerInfo purchaserInfo =
                          await Purchases.purchasePackage(packageToPurchase);
                      if (purchaserInfo.entitlements.active.isNotEmpty) {
                        Provider.of<HomepageProvider>(context, listen: false)
                            .updateSubscriptionStatus(false);
                        // Optionally, navigate to another screen or trigger UI refresh
                      }
                    } on PlatformException catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: Text("Error: ${e.message}"),
                            actions: [
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'No package selected',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Subscribe',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Package package) {
    bool isSelected = _offerings.indexOf(package) == selectedCard;
    final priceString = package.storeProduct.priceString;
    final title = package.storeProduct.title;
    final description = package.storeProduct.description;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCard = _offerings.indexOf(package);
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        color: isSelected ? Colors.green.shade100 : Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(description, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
                Text(
                  priceString,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current?.availablePackages != null) {
        setState(() {
          _offerings = offerings.current!.availablePackages;
        });
      } else {
        showSnackbar('No offerings available at the moment.');
      }
    } on Exception catch (e) {
      showSnackbar('Error fetching offerings: ${e.toString()}');
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
