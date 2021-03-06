import java.util.List;
import java.util.Arrays;
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
    public static SExpr SExprList(List<SExpr> l) {
        return new SExprList(l);
    }
    public static SExpr SExprQuoted(SExpr e) {
        SExpr quote = SExprSymbol("QUOTE");
        return SExprList(Arrays.asList(quote, e));
    }
}

class SExprSymbol implements SExpr {
    private String value;
    SExprSymbol(String s) {
        value = s;
    }
    public String toString() {
        return "SExprSymbol(" + value + ")";
    }

}

class SExprString implements SExpr {
    private String value;
    SExprString(String s) {
        value = s;
    }
    public String toString() {
        return "SExprString(" + value + ")";
    }
}

class SExprInt implements SExpr {
    private Integer value;
    SExprInt(Integer i) {
        value = i;
    }
    public String toString() {
        return "SExprInt(" + value + ")";
    }
}

class SExprDouble implements SExpr {
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
        return "SExprList(" + String.join(", ", list) + ")";
    }
}
