import 'package:flutter/material.dart';
import 'package:hirepro/providers/bids_provider.dart';
import 'package:hirepro/widgets/HireProAppBar.dart';
import 'package:provider/provider.dart';

class BidDetailsScreen extends StatelessWidget {
  const BidDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(args);
    return Scaffold(
      appBar: HireProAppBar(context, "Bids Details"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Time'),
            subtitle: Text(args['date']),
          ),
          ListTile(
            title: Text('Amount'),
            subtitle: Text('${args['estmax']}-${args['estmin']}'),
          ),
          ListTile(
            title: Text('Service ID'),
            subtitle: Text(args['location']),
          ),
          ListTile(
            title: Text('Location'),
            subtitle: Text(args['id']),
          ),
        ],
      ),
    );
  }
}
