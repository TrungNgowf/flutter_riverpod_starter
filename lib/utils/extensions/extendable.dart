class Extendable<T> {
  T base;

  Extendable(this.base);
}

extension ExCompatible<T> on T {
  Extendable<T> get ext => Extendable(this);
}
