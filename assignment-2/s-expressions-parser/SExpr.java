import java.util.List;
import java.util.stream.Collectors;

interface SExpr {
    public String toString();

    public static SExpr SExprInt(Integer i) {
        return new SExprInt(i);
    }
    public static SExpr SExprDouble(Double d) {
        return new SExprDouble(d);
    }
    public static SExpr SExprString(String s) {
        return new SExprString(s);
    }
    public static SExpr SExprSymbol(String s) {
        return new SExprSymbol(s);
    }
}

interface SExprAtom extends SExpr {
}

class SExprSymbol implements SExprAtom {
    private String value;
    SExprSymbol(String s) {
        value = s;
    }
    public String toString() {
        return "SExprSymbol(" + value + ")";
    }

}

class SExprString implements SExprAtom {
    private String value;
    SExprString(String s) {
        value = s;
    }
    public String toString() {
        return "SExprSymbol(" + value + ")";
    }
}

class SExprInt implements SExprAtom {
    private Integer value;
    SExprInt(Integer i) {
        value = i;
    }
    public String toString() {
        return "SExprInt(" + value + ")";
    }
}

class SExprDouble implements SExprAtom {
    private Double value;
    SExprDouble(Double d) {
        value = d;
    }
    public String toString() {
        return "SExprDouble(" + value + ")";
    }
}

class SExprList implements SExpr {
    private List<SExpr> values;
    SExprList(List<SExpr> vals) {
        values = vals;
    }
    public String toString() {
        List<String> list = values.stream()
            .map(elt -> elt.toString())
            .collect(Collectors.toList());
        return String.join(", ", list);
    }
}
