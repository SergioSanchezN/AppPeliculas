import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie,),
              _Overview(movie: movie,),
              CastingCardsScreen(movieId: movie.id)
            ])
          )
        ],
        
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle( fontSize: 16 ),
            textAlign: TextAlign.center,           
            ),
        ),

        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only( top: 20 ),
      padding: EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),

          SizedBox( width: 20 ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width-170 ),
                child: Text(movie.title, 
                  style: textTheme.headline6, 
                  overflow: TextOverflow.clip, 
                  maxLines: 3,    
                ),
              ),

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width-170),
                child: Text(movie.originalTitle, 
                style: textTheme.subtitle1, 
                overflow: TextOverflow.ellipsis,    
                ),
              ),

              Row(
                children: [
                  Icon( Icons.star_outline, size: 15, color: Colors.grey ),
                  SizedBox( width: 5),
                  Text(movie.voteAverage.toString(), style:  textTheme.caption,)
                ]
              )
            ],
          )
        ],
      ),

    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 30, vertical: 10 ),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,

        )
    );
  }
}