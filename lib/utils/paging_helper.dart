class PagingHelper<T> {
  List<T> listItems = [];
  int pageNumber = 1; // depend on API results
  int pageSize = 6; // depend on API results
  bool isLoadingPage = false;
  bool endOfList = false;

  appendLastPage(List<T> items) {
    listItems.addAll(items);
    endOfList = true;
  }

  appendPage(List<T> items) {
    listItems.addAll(items);
    pageNumber++;
  }

  bool canLoadNextPage() {
    return !isLoadingPage && !endOfList;
  }

  initRefresh() {
    listItems = [];
    pageNumber = 1;
    isLoadingPage = false;
    endOfList = false;
  }

  setLastPage() {
    endOfList = true;
  }
}
