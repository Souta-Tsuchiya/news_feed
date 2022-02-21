class NewsCategory {
  final int categoryId;
  final String jpName;
  final String enName;

  NewsCategory({
    required this.categoryId,
    required this.jpName,
    required this.enName,
  });
}

final List<NewsCategory> newsCategories = [
  NewsCategory(categoryId: 0, jpName: "総合", enName: "general"),
  NewsCategory(categoryId: 1, jpName: "経済", enName: "business"),
  NewsCategory(categoryId: 2, jpName: "テクノロジー", enName: "technology"),
  NewsCategory(categoryId: 3, jpName: "健康", enName: "health"),
  NewsCategory(categoryId: 4, jpName: "科学", enName: "science"),
  NewsCategory(categoryId: 5, jpName: "エンタメ", enName: "entertainment"),
  NewsCategory(categoryId: 6, jpName: "スポーツ", enName: "sports"),
];
