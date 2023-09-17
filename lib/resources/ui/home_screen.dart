import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_db/resources/blocs/movie_bloc/bloc/movie_bloc.dart';
import 'package:movie_db/resources/blocs/movie_bloc/bloc/movie_event.dart';
import 'package:movie_db/resources/blocs/movie_bloc/bloc/movie_state.dart';
import 'package:movie_db/resources/ui/widgets/home_page_error.dart';
import 'package:movie_db/resources/ui/widgets/home_page_loaded.dart';
import 'package:movie_db/resources/ui/widgets/home_page_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieBloc _movieBloc = MovieBloc();
  final ScrollController _scrollController = ScrollController();
  int initialpage = 1;
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _movieBloc.add(GetMovieList(initialpage));
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _movieBloc.add(GetMovieList(initialpage + 1));
      initialpage = initialpage + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: _CustomClipper(),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF000B49),
              child: Center(
                child: Text(
                  'Explore',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: _buildmovieList());
  }

  Widget _buildmovieList() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _movieBloc,
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              
              if (state is MovieInitial) {
                return movieLoadingScreen(context);
              } else if (state is MovieLoading) {
                return movieLoadingScreen(context);
              } else if (state is MovieLoaded) {
                return movieLoadedScreen(
                    context, state.movieModel, _scrollController);
              } else if (state is MovieError) {
                return movieErrorScreen(context);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
