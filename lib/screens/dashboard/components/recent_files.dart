import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/models/RecentFile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/provides/user_provide.dart';

import '../../../constants.dart';

class RecentFiles extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Consumer(builder: (context, watch, _) {
        final users = ref.watch(usersProvider);
        return users.when(
          data: (value) {
            return SizedBox( // Wrap with SizedBox
              height: 400, // Define a height or use appropriate height
              child: ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  UserModel user = value[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "View Users",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columnSpacing: defaultPadding,
                          columns: [
                            DataColumn(
                              label: Text("User Name"),
                            ),
                            DataColumn(
                              label: Text("ID"),
                            ),
                            DataColumn(
                              label: Text("Role"),
                            ),
                          ],
                          rows: List.generate(
                            demoRecentFiles.length,
                            (index) {
                              UserModel user = value[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/xd_file.svg",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                          child: Text(user.firstName),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(user.lastName)),
                                  DataCell(Text(user.mobile)),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
        );
      }),
    );
  }
}
