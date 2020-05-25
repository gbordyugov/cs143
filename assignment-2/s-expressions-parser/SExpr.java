interface SExpr {
    public String toString();
}

interface SExprAtom extends SExpr {
}

interface SExprList extends SExpr {
}

class SExprSymbol implements SExprAtom {
    private String value;
    SExprSymbol(String s) {
        value = s;
    }
}

class SExprString implements SExprAtom {
    private String value;
    SExprString(String s) {
        value = s;
    }
}

class SExprInt implements SExprAtom {
    private Integer value;
    SExprInt(Integer i) {
        value = i;
    }
}

class SExprDouble implements SExprAtom {
    private Double value;
    SExprDouble(Double d) {
        value = d;
    }
}
