class PsnAContentBean {
  String content;
  int reward;
  bool win;
  PsnAContentBean({
    required this.content,
    required this.reward,
    required this.win,
});

  @override
  String toString() {
    return 'PsnAContentBean{content: $content, reward: $reward, win: $win}';
  }
}