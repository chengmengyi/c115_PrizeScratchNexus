class PsnAdUtils{
  static final PsnAdUtils _utils=PsnAdUtils();
  static PsnAdUtils get instance => _utils;

  showAdBBBBBB({
    required Function() closeCallback,
    bool isOpen=false,
  }){
    closeCallback.call();
  }
}