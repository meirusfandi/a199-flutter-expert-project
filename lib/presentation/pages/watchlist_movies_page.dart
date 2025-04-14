import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });

    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTv();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
          controller: tabController,
          padding: EdgeInsets.all(0),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(fontSize: 16),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          onTap: (value) {
            setState(() {});
          },
          tabs: [
            Tab(text: 'Movies', icon: Icon(Icons.movie)),
            Tab(text: 'TV Series', icon: Icon(Icons.tv)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (tabController.index == 0)
            ? sectionMovies(context)
            : sectionTvs(context),
      ),
    );
  }

  Widget sectionMovies(BuildContext context) {
    return Consumer<WatchlistMovieNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistState == RequestState.Loaded) {
          return (data.watchlistMovies.isNotEmpty)
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = data.watchlistMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: data.watchlistMovies.length,
                )
              : Center(
                  key: Key('error_message'),
                  child: Text("No Movies in Watchlist"),
                );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  Widget sectionTvs(BuildContext context) {
    return Consumer<WatchlistTvNotifier>(
      builder: (context, dataTv, child) {
        if (dataTv.watchlistState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (dataTv.watchlistState == RequestState.Loaded) {
          return (dataTv.watchlistTvs.isNotEmpty)
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = dataTv.watchlistTvs[index];
                    return TvCard(tv);
                  },
                  itemCount: dataTv.watchlistTvs.length,
                )
              : Center(
                  key: Key('error_message'),
                  child: Text("No Tv Series in Watchlist"),
                );
        } else {
          return Center(
            key: Key('error_message'),
            child: Text(dataTv.message),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    tabController.dispose();
    super.dispose();
  }
}
