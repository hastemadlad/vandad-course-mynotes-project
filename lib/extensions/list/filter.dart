extension Filter<T> on Stream<List<T>> {
  Stream<List<T>> filter(bool Function(T) where) =>
      map((items) => items.where(where).toList());
}


//We have a list of tings which is the stream that has a list of thing called T
//now we Filter that
//we use function filter(bool Function(T) where) wher it uses the thing T and uses it 
//in a test to get a bool value and based on that value it mapsthe items 