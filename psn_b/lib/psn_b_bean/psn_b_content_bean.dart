class PsnBContentBean {
  String content;
  int reward;
  bool win;
  PsnBContentBean({
    required this.content,
    required this.reward,
    required this.win,
});

  @override
  String toString() {
    return 'PsnAContentBean{content: $content, reward: $reward, win: $win}';
  }
}