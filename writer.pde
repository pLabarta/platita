class Writer {
  String name;
  // an array of fragments of text
  ArrayList<String> fragments;

  String currentFragment;

    Writer() {
        this.name = "new";
        this.fragments = new ArrayList<String>();
    }

    void addFragment(String fragment) {
        this.fragments.add(fragment);
    }

    void setName(String name) {
        this.name = name;
    }

    void setCurrentFragment(String fragment) {
        this.currentFragment = fragment;
    }
};


void showWriter(Writer w) {
    println(w.name);
    for (String fragment : w.fragments) {
        println(fragment);
    }
}
