import 'package:chat/data/enum/state_handler.dart';
import 'package:chat/ui/widgets/provider/status_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogManager {
  final BuildContext context;

  DialogManager(this.context);

  Future show({required final Widget content}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
              padding: EdgeInsets.all(16),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                maxWidth: MediaQuery.of(context).size.width * 0.6,
                minHeight: MediaQuery.of(context).size.height * 0.2,
                minWidth: MediaQuery.of(context).size.width * 0.2,
              ),
              child: content),
        );
      },
    );
  }

  void showListOfStatuses() async {
    await show(content:
        Consumer<StatusProvider>(builder: (context, statusProvider, child) {
      if (statusProvider.state == StateHandler.loaded) {
        return Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          radius: Radius.circular(8),
          child: ListView.builder(
            itemCount: statusProvider.statuses.length,
            itemBuilder: (context, index) {
              final status = statusProvider.statuses.entries.elementAt(index);
              return ListTile(
                title: Text(status.value),
                onTap: () {},
              );
            },
          ),
        );
      } else if (statusProvider.state == StateHandler.loading) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Center(child: Text('Error loading statuses'));
      }
    }));
  }
}
