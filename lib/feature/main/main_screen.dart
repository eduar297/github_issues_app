import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_issues_app/domain/auth/auth_state.dart';
import 'package:github_issues_app/feature/auth/auth_cubit.dart';
import 'package:github_issues_app/feature/auth/auth_screen.dart';

class MainScreen extends StatefulWidget {
  final String title;

  const MainScreen({Key? key, required this.title}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        Widget page;
        switch (selectedIndex) {
          case 0:
            page = AuthScreen();
            break;
          case 1:
            page = Placeholder();
            break;
          default:
            throw UnimplementedError('no widget for $selectedIndex');
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title),
                actions: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        return IconButton(
                          icon: CircleAvatar(
                            backgroundImage: NetworkImage(state.user.avatarUrl),
                          ),
                          onPressed: () {},
                        );
                      } else {
                        return Icon(Icons.account_circle);
                      }
                    },
                  ),
                ],
              ),
              body: Row(
                children: [
                  SafeArea(
                    child: NavigationRail(
                      extended: constraints.maxWidth >= 600,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.token),
                          label: Text('GitHub Auth'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.playlist_add_check_circle),
                          label: Text('GitHub Issues'),
                        ),
                      ],
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: page,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
