import 'package:flutter/material.dart';
import 'package:newsapp/src/models/models.dart';
import 'package:http/http.dart' as http;

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;
  List<Category> categories = [
    Category(Icons.build, 'business'),
    Category(Icons.tv, 'entertainment'),
    Category(Icons.home, 'general'),
    Category(Icons.health_and_safety, 'health'),
    Category(Icons.science, 'science'),
    Category(Icons.sports, 'sports'),
    Category(Icons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  final String _baseUrl = 'newsapi.org';
  final String _apiKey = 'e3461302bbce47af8ef74769dd7f90c6';

  NewsService() {
    getTopHeadlines();
    for (var element in categories) {
      categoryArticles[element.name] = [];
    }
    getArticlesByCategory(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    _isLoading = false;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article>? get getArticlesCategorySelected =>
      categoryArticles[selectedCategory];

  Future<List<Article>> getTopHeadlines() async {
    final url = Uri.https(
        _baseUrl, '/v2/top-headlines', {'country': 'us', 'apiKey': _apiKey});
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
    return headlines;
  }

  Future getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = true;
      notifyListeners();
      return categoryArticles[category];
    }
    final url = Uri.https(_baseUrl, '/v2/top-headlines',
        {'country': 'us', 'apiKey': _apiKey, 'category': category});
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles);
    _isLoading = true;
    notifyListeners();
  }
}
