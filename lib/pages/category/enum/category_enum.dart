enum CategoryEnum {
  all("全部", "全部"),
  city("都市", "都市"),
  fantasy("玄幻", "玄幻"),
  history("历史", "历史"),
  scienceFiction("科幻", "科幻"),
  military("军事", "军事"),
  game("游戏(网游)", "游戏"),
  fantasy1("奇幻(修真,武侠)", "奇幻");

  final String name;
  final String value;
  const CategoryEnum(this.name, this.value);
}
