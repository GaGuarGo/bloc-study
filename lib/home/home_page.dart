import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buttonCard({required String title, required Function() onPressed}) =>
        SizedBox(
          height: MediaQuery.sizeOf(context).width * 0.45,
          width: MediaQuery.sizeOf(context).width * 0.45,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(title),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttonCard(
                      title: 'Example',
                      onPressed: () {
                        Navigator.pushNamed(context, '/bloc/example');
                      }),
                  buttonCard(
                      title: 'Example Freezed',
                      onPressed: () {
                        Navigator.pushNamed(context, '/bloc/example/freezed');
                      }),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttonCard(
                      title: 'Contact',
                      onPressed: () {
                        Navigator.pushNamed(context, '/contacts/list');
                      }),
                  buttonCard(
                      title: 'Contact Cubit',
                      onPressed: () {
                        Navigator.pushNamed(context, '/contacts/cubit/list');
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
