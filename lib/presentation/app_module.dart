class AppModule {
  static bool _provided = false;

  void provideDependencies() {
    if (_provided) return;
    _provided = true;
  }
}
