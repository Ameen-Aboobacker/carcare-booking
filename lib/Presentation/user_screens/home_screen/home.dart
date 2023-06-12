

import 'package:carcareuser/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/bottom_nav_provider.dart';
import '../../../utils/global_values.dart';
import '../../widgets/main_title_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

 final List<String> postersList = [
    'https://t3.ftcdn.net/jpg/03/97/46/30/240_F_397463002_6EYeghuJQzUwbxITLg7s3DtL8uKhovZk.jpg',
    'https://t3.ftcdn.net/jpg/02/00/40/58/240_F_200405847_pi6eDOs934Eb8uObtkGUJnzC6DkLcbXI.jpg',
    'https://img.freepik.com/free-vector/gradient-car-service-logo-design_23-2149700427.jpg'
  ];
   final List<String> packagesList = [
    'https://quickfitautos.com/wp-content/uploads/2021/02/quickfitautos-car-repair-offers-oil-change.jpg',
    'https://img.pikbest.com/origin/06/43/58/11npIkbEsTvgj.jpg!f305cw',
      'https://t3.ftcdn.net/jpg/02/00/40/58/240_F_200405847_pi6eDOs934Eb8uObtkGUJnzC6DkLcbXI.jpg',
    'https://img.freepik.com/free-vector/gradient-car-service-logo-design_23-2149700427.jpg'
  ];
class _HomeScreenState extends State<HomeScreen> {
  final AuthService auth = AuthService();
  bool a = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: ListView(
          children:   [
            AppSizes.kHeight20,
            const Text(
              'Welcome,AMEEN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            AppSizes.kHeight20,
          const Location(),
            AppSizes.kHeight20,
            MainTitleCard(title: 'Top Service centers',postersList: postersList),
            MainTitleCard(title: 'Top Packages',postersList: packagesList,)
          ],
        ),
        );
  }
}

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.yellow,
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.only(
          left: 15,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 50,
              color: Colors.purple,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Calicut',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Kerala,India',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                   Provider.of<NavbarProvider>(context,listen:false).selectedIndex=3;
                  
                  }, child: const Text('Book your Slot')),
            )
          ],
        ));
  }
  
}
