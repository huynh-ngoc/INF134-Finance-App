import 'package:flutter/material.dart';
import '../utils/constant.dart';
import 'package:animations/animations.dart';
import './home/statistics.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildAppBar(),
          cards(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: activityCard("add",Icons.arrow_outward)),
                SizedBox(width: 4,),
                Expanded(child: activityCard("add",Icons.arrow_outward)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: debtsAndSavingsCard('Debts', '\$1,800')),
                SizedBox(
                  width: 4,
                ),
                Expanded(child: debtsAndSavingsCard('Savings', '\$1,800')),
              ],
            ),
          ),
          statisticsCard(),
          expensesContainer(),
        ],
      ),
    );
  }
  
  buildAppBar()
  {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Balance'),
              Text('\$990,990', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.notifications),
            mini: true,
            elevation: 0,
            shape: CircleBorder(),
            ),
      
          SizedBox(
            width: 12
            ),
      
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.more_horiz),
            mini: true,
            elevation: 0,
            shape: CircleBorder(),
            ),
        ],
      ),
    );
  }

  cards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'My cards',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 96,
                child: FloatingActionButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kWidgetBorder)),
                  child: Icon(
                    Icons.add,
                    size: 36,
                    color: Colors.black,
                  ),
                  elevation: 0,
                ),
              ),
              card(Colors.black, Colors.white, 'master.png', '24,800',
                  '**** 9523'),
              card(Colors.grey.shade200, Colors.black, 'visa.png',
                  '13,200', '**** 6729'),
            ],
          ),
        )
      ],
    );
  }

  card(Color bgColor, Color textColor, String icon, String amount,
      String cardNumber) {
    return SizedBox(
      width: 200,
      child: Card(
        color: bgColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kWidgetBorder)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/$icon',
                    height: 32,
                    width: 32,
                  ),
                  Spacer(),
                  Text(
                    cardNumber,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Spacer(),
              Text(
                '\$$amount',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  activityCard(String text, IconData icon)
  {
    return Card(
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kWidgetBorder)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
            Spacer(),
            CircleAvatar(
              child: Icon(icon, color: Colors.black,),
              backgroundColor: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }


   debtsAndSavingsCard(String text, String amount) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kWidgetBorder)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              amount,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      
    );
  }

  statisticsCard() {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 500),
      closedElevation: 0,
      closedColor: const Color(0xFF64FFDA),
      openColor: const Color(0xFF64FFDA),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kWidgetBorder),
      ),
      openBuilder: (context, _) => const StatisticsPage(),
      closedBuilder: (context, open) {
        // This is your “closed” look: the small stats card
        return InkWell(
          onTap: open,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text(
                  'Control your finances',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: open,
                  child: const Text('Statistics'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}

  expensesContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kWidgetBorder)),
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Expenses',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add))
                ],
              ),
              Row(
                children: [
                  expenses('\$250', Icons.food_bank),
                  expenses('\$250', Icons.shopping_cart),
                  expenses('\$250', Icons.school),
                  expenses('\$250', Icons.house),
                  expenses('\$250', Icons.medical_services),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  expenses(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          FloatingActionButton(
            backgroundColor: Colors.grey.shade400,
            onPressed: () {},
            child: Icon(
              icon,
              color: Colors.black,
            ),
            mini: true,
            elevation: 0,
            shape: CircleBorder(),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}


