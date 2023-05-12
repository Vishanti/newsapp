import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/services.dart';
import 'package:newsapp/src/theme/my_theme.dart';
import 'package:newsapp/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _CategoryList(),
            if (newsService.isLoading)
              Expanded(
                  child:
                      NewsList(news: newsService.getArticlesCategorySelected!)),
            if (!newsService.isLoading)
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 90,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categories: categories[index]),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(categories[index].name[0].toUpperCase() +
                      categories[index].name.substring(1))
                ],
              ),
            ),
          );
        },
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categories;
  const _CategoryButton({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categories.name;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: 40,
        height: 40,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(categories.icon,
            color: newsService.selectedCategory == categories.name
                ? myTheme.primaryColor
                : Colors.black54),
      ),
    );
  }
}
