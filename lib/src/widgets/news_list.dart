import 'package:flutter/material.dart';
import 'package:newsapp/src/models/models.dart';
import 'package:newsapp/src/theme/my_theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return _News(news: news[index], index: index);
        },
        itemCount: news.length);
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;
  const _News({super.key, required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(
          news: news,
          index: index,
        ),
        _TitleCard(
          news: news,
          index: index,
        ),
        _ImageCard(
          news: news,
        ),
        _BodyCard(
          news: news,
        ),
        const _ButtonCard(),
        const SizedBox(
          height: 10,
        ),
        Divider()
      ],
    );
  }
}

class _ButtonCard extends StatelessWidget {
  const _ButtonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.star_border),
          ),
          const SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article news;
  const _BodyCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(news.description));
  }
}

class _ImageCard extends StatelessWidget {
  final Article news;
  const _ImageCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
            child: news.urlToImage != null
                ? FadeInImage(
                    placeholder: const AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(news.urlToImage ?? ''))
                : const Image(image: AssetImage('assets/img/no-image.png'))),
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article news;
  final int index;
  const _TitleCard({
    super.key,
    required this.news,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        news.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article news;
  final int index;
  const _TopBarCard({
    super.key,
    required this.news,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}', style: TextStyle(color: myTheme.primaryColor)),
          const SizedBox(width: 5),
          Text(news.source.name)
        ],
      ),
    );
  }
}
