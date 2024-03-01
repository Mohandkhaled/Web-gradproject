import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/services/user_services.dart';

final usersStreamProvider = StreamProvider<List<UserModel>>((ref) {
  UserService userService = UserService();
  return userService.getUsersStream();
});

class RecentFiles extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersStreamProvider);

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: users.when(
        data: (value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Users (${value.length})", // Show the total number of users
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Email"),
                    ),
                    DataColumn(
                      label: Text("Mobile"),
                    ),
                    DataColumn(
                      label: Text("Address"), // Added column for Address
                    ),
                  ],
                  rows: List.generate(
                    value.length, // Use the length of the user list
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
                                  child: Text("${user.firstname} ${user.lastname}"),
                                ),
                              ],
                            ),
                          ),
                          DataCell(Text(user.email)),
                          DataCell(Text(user.mobile)),
                          DataCell(Text(user.address)),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Text(error.toString()),
      ),
    );
  }
}
