import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_issues_app/feature/auth/auth_cubit.dart';
import 'package:github_issues_app/domain/auth/auth_state.dart';
import 'package:github_issues_app/feature/repo/repositories_list.dart';
import 'package:github_issues_app/feature/user/user_info.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _tokenController = TextEditingController();
  bool _isValid = false;

  void _validateInput(String value) {
    setState(() {
      _isValid = value.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid token'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is Authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome ${state.user.name}'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return CircularProgressIndicator();
          } else if (state is Authenticated) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UserInfo(user: state.user),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthCubit>().signOut();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 50)),
                          child: Text(
                              style: const TextStyle(fontSize: 15), 'Sign out'),
                        ),
                      ],
                    ),
                  ),
                  RepositoriesList(repos: state.repos),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your GitHub auth token:',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: 420,
                  child: TextField(
                    controller: _tokenController,
                    onChanged: _validateInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'Auth token',
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isValid
                      ? () {
                          context
                              .read<AuthCubit>()
                              .signIn(_tokenController.text);
                        }
                      : null,
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
                  child: Text(
                      style: const TextStyle(fontSize: 15),
                      state is Unauthenticated ? 'Save token' : 'Edit token'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
