class A {
      i: Integer;
      s: String;
      method(): String { "tri" };
      f1(i: Integer, s: String): String {
            {
                if 3 then 5 else 0 fi;
                let a: Integer in 3;
                while 5 loop
                      3
                pool;
                method();
           }
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
