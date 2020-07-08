class A {
      i: Integer;
      s: String;
      f1(i: Integer, s: String): String {
           let a: Integer in 3
      };
      f3(i: Integer, s: String): String {
           let a: Integer, b: Integer in 3
      };
      f4(i: Integer, s: String): String {
           let a: Integer, b: Integer <- 0 in 3
      };
      f4(i: Integer, s: String): String {
           let a: Integer <- 0, b: Integer in 3
      };
      f4(i: Integer, s: String): String {
           let a: Integer <- 0, b: Integer <-0 in 3
      };
};

Class BB__ inherits A {
};
