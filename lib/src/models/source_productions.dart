const SourceProductions = <String, List<List<String>>>{
  "<Log Or_>": [
    [
      "'||'",
      "<Log And>",
      "<Log Or_>",
    ],
    [
      "",
    ],
  ],
  "<Params List>": [
    [
      "','",
      "<Param>",
      "<Params List>",
    ],
    [
      "",
    ],
  ],
  "<Array Decl>": [
    [
      "'['",
      "<Array Def>",
      "']'",
      "<Array Vector>",
    ],
  ],
  "<Param Type>": [
    [
      "<Type>",
    ],
    [
      "id",
    ],
  ],
  "<Add>": [
    [
      "<Mult>",
      "<Add_>",
    ],
  ],
  "<Args List>": [
    [
      "','",
      "<Expr>",
      "<Args List>",
    ],
    [
      "",
    ],
  ],
  "<Array Def>": [
    [
      "<Expr>",
      "<Array Expr>",
    ],
  ],
  "<Var Decls>": [
    [
      "<Var Decl>",
      "<Var Decls>",
    ],
    [
      "",
    ],
  ],
  "<Equate_>": [
    [
      "'=='",
      "<Compare>",
      "<Equate_>",
    ],
    [
      "'!='",
      "<Compare>",
      "<Equate_>",
    ],
    [
      "",
    ],
  ],
  "<Extends>": [
    [
      "extends",
      "struct",
      "id",
    ],
    [
      "",
    ],
  ],
  "<Const Decls>": [
    [
      "<Const Decl>",
      "<Const Decls>",
    ],
    [
      "",
    ],
  ],
  "<Value>": [
    [
      "'-'",
      "<Value>",
    ],
    [
      "num",
    ],
    [
      "str",
    ],
    [
      "log",
    ],
    [
      "local",
      "<Access>",
    ],
    [
      "global",
      "<Access>",
    ],
    [
      "id",
      "<Id Value>",
    ],
    [
      "'('",
      "<Expr>",
      "')'",
    ],
  ],
  "<Log Unary>": [
    [
      "'!'",
      "<Log Unary>",
    ],
    [
      "<Log Value>",
    ],
  ],
  "<Decls>": [
    [
      "<Decl>",
      "<Decls>",
    ],
    [
      "",
    ],
  ],
  "<Index>": [
    [
      "<Expr>",
    ],
    [
      "",
    ],
  ],
  "<And_>": [
    [
      "'&&'",
      "<Equate>",
      "<And_>",
    ],
    [
      "",
    ],
  ],
  "<Const Decl>": [
    [
      "<Type>",
      "<Const>",
      "<Const List>",
    ],
    [
      "<Typedef>",
    ],
    [
      "<Stm Scope>",
    ],
    [
      "id",
      "<Const Id>",
    ],
  ],
  "<Accesses>": [
    [
      "<Access>",
      "<Accesses>",
    ],
    [
      "",
    ],
  ],
  "<Param>": [
    [
      "<Param Type>",
      "id",
      "<Param Arrays>",
    ],
  ],
  "<Var>": [
    [
      "id",
      "<Arrays>",
    ],
  ],
  "<Func Block>": [
    [
      "<Var Block>",
      "<Func Stms>",
    ],
  ],
  "<Start Block>": [
    [
      "start",
      "'('",
      "')'",
      "'['",
      "<Func Block>",
      "']'",
    ],
  ],
  "<Func Stms>": [
    [
      "<Func Stm>",
      "<Func Stms>",
    ],
    [
      "",
    ],
  ],
  "<Struct Block>": [
    [
      "struct",
      "id",
      "<Extends>",
      "'['",
      "<Var Decls>",
      "']'",
    ],
    [
      "typedef",
      "struct",
      "<Extends>",
      "'['",
      "<Var Decls>",
      "']'",
      "id",
      "';'",
    ],
  ],
  "<Stm Id>": [
    [
      "<Assign>",
    ],
    [
      "<Array>",
      "<Arrays>",
      "<Accesses>",
      "<Assign>",
    ],
    [
      "<Access>",
      "<Accesses>",
      "<Assign>",
    ],
    [
      "'('",
      "<Args>",
      "')'",
      "';'",
    ],
  ],
  "<Array>": [
    [
      "'['",
      "<Index>",
      "']'",
    ],
  ],
  "<Decl>": [
    [
      "<Func Decl>",
    ],
    [
      "<Proc Decl>",
    ],
    [
      "<Struct Block>",
    ],
  ],
  "<Var Block>": [
    [
      "var",
      "'['",
      "<Var Decls>",
      "']'",
    ],
    [
      "",
    ],
  ],
  "<Array Expr>": [
    [
      "','",
      "<Array Def>",
    ],
    [
      "",
    ],
  ],
  "<Arrays>": [
    [
      "<Array>",
      "<Arrays>",
    ],
    [
      "",
    ],
  ],
  "<Access>": [
    [
      "'.'",
      "id",
      "<Arrays>",
    ],
  ],
  "<Stm Cmd>": [
    [
      "print",
      "'('",
      "<Args>",
      "')'",
      "';'",
    ],
    [
      "read",
      "'('",
      "<Args>",
      "')'",
      "';'",
    ],
  ],
  "<Var Stm>": [
    [
      "<Stm Scope>",
    ],
    [
      "id",
      "<Stm Id>",
    ],
    [
      "<Stm Cmd>",
    ],
  ],
  "<Const Block>": [
    [
      "const",
      "'['",
      "<Const Decls>",
      "']'",
    ],
    [
      "",
    ],
  ],
  "<Proc Decl>": [
    [
      "procedure",
      "id",
      "'('",
      "<Params>",
      "')'",
      "'['",
      "<Func Block>",
      "']'",
    ],
  ],
  "<Decl Atribute>": [
    [
      "<Array Decl>",
    ],
    [
      "<Expr>",
    ],
  ],
  "<Compare_>": [
    [
      "'<'",
      "<Add>",
      "<Compare_>",
    ],
    [
      "'>'",
      "<Add>",
      "<Compare_>",
    ],
    [
      "'<='",
      "<Add>",
      "<Compare_>",
    ],
    [
      "'>='",
      "<Add>",
      "<Compare_>",
    ],
    [
      "",
    ],
  ],
  "<Stm Scope>": [
    [
      "local",
      "<Access>",
      "<Accesses>",
      "<Assign>",
    ],
    [
      "global",
      "<Access>",
      "<Accesses>",
      "<Assign>",
    ],
  ],
  "<Func Normal Stm>": [
    [
      "'['",
      "<Func Stms>",
      "']'",
    ],
    [
      "<Var Stm>",
    ],
    [
      "return",
      "<Expr>",
      "';'",
    ],
  ],
  "<Else Stm>": [
    [
      "else",
      "<Func Normal Stm>",
    ],
    [
      "",
    ],
  ],
  "<Log Compare>": [
    [
      "<Log Unary>",
      "<Log Compare_>",
    ],
  ],
  "<Var Decl>": [
    [
      "<Type>",
      "<Var>",
      "<Var List>",
      "';'",
    ],
    [
      "<Typedef>",
    ],
    [
      "<Stm Scope>",
    ],
    [
      "id",
      "<Var Id>",
    ],
  ],
  "<Const>": [
    [
      "id",
      "<Arrays>",
    ],
  ],
  "<Const List>": [
    [
      "','",
      "<Const>",
      "<Const List>",
    ],
    [
      "'='",
      "<Decl Atribute>",
      "';'",
    ],
  ],
  "<Var List>": [
    [
      "','",
      "<Var>",
      "<Var List>",
    ],
    [
      "'='",
      "<Expr>",
      "<Var List>",
    ],
    [
      "",
    ],
  ],
  "<Array Vector>": [
    [
      "','",
      "<Array Decl>",
    ],
    [
      "",
    ],
  ],
  "<Type>": [
    [
      "int",
    ],
    [
      "real",
    ],
    [
      "boolean",
    ],
    [
      "string",
    ],
    [
      "struct",
      "id",
    ],
  ],
  "<Log Or>": [
    [
      "<Log And>",
      "<Log Or_>",
    ],
  ],
  "<Log Value>": [
    [
      "num",
    ],
    [
      "str",
    ],
    [
      "log",
    ],
    [
      "local",
      "<Access>",
    ],
    [
      "global",
      "<Access>",
    ],
    [
      "id",
      "<Id Value>",
    ],
    [
      "'('",
      "<Log Expr>",
      "')'",
    ],
  ],
  "<Log Compare_>": [
    [
      "'<'",
      "<Log Unary>",
      "<Log Compare_>",
    ],
    [
      "'>'",
      "<Log Unary>",
      "<Log Compare_>",
    ],
    [
      "'<='",
      "<Log Unary>",
      "<Log Compare_>",
    ],
    [
      "'>='",
      "<Log Unary>",
      "<Log Compare_>",
    ],
    [
      "",
    ],
  ],
  "<Assign>": [
    [
      "'='",
      "<Expr>",
      "';'",
    ],
    [
      "'++'",
      "';'",
    ],
    [
      "'--'",
      "';'",
    ],
  ],
  "<Log Equate>": [
    [
      "<Log Compare>",
      "<Log Equate_>",
    ],
  ],
  "<Args>": [
    [
      "<Expr>",
      "<Args List>",
    ],
    [
      "",
    ],
  ],
  "<Log And_>": [
    [
      "'&&'",
      "<Log Equate>",
      "<Log And_>",
    ],
    [
      "",
    ],
  ],
  "<Or>": [
    [
      "<And>",
      "<Or_>",
    ],
  ],
  "<Id Value>": [
    [
      "<Arrays>",
      "<Accesses>",
    ],
    [
      "'('",
      "<Args>",
      "')'",
    ],
  ],
  "<Or_>": [
    [
      "'||'",
      "<And>",
      "<Or_>",
    ],
    [
      "",
    ],
  ],
  "<Log And>": [
    [
      "<Log Equate>",
      "<Log And_>",
    ],
  ],
  "<Func Decl>": [
    [
      "function",
      "<Param Type>",
      "id",
      "'('",
      "<Params>",
      "')'",
      "'['",
      "<Func Block>",
      "']'",
    ],
  ],
  "<Param Arrays>": [
    [
      "'['",
      "']'",
      "<Param Mult Arrays>",
    ],
    [
      "",
    ],
  ],
  "<Param Mult Arrays>": [
    [
      "'['",
      "num",
      "']'",
      "<Param Mult Arrays>",
    ],
    [
      "",
    ],
  ],
  "<Unary>": [
    [
      "'!'",
      "<Unary>",
    ],
    [
      "<Value>",
    ],
  ],
  "<Typedef>": [
    [
      "typedef",
      "<Type>",
      "id",
      "';'",
    ],
  ],
  "<Var Id>": [
    [
      "<Var>",
      "<Var List>",
      "';'",
    ],
    [
      "<Stm Id>",
    ],
  ],
  "<Mult_>": [
    [
      "'*'",
      "<Unary>",
      "<Mult_>",
    ],
    [
      "'/'",
      "<Unary>",
      "<Mult_>",
    ],
    [
      "",
    ],
  ],
  "<Expr>": [
    [
      "<Or>",
    ],
  ],
  "<Params>": [
    [
      "<Param>",
      "<Params List>",
    ],
    [
      "",
    ],
  ],
  "<And>": [
    [
      "<Equate>",
      "<And_>",
    ],
  ],
  "<Const Id>": [
    [
      "<Const>",
      "<Const List>",
      "';'",
    ],
    [
      "<Stm Id>",
    ],
  ],
  "<Add_>": [
    [
      "'+'",
      "<Mult>",
      "<Add_>",
    ],
    [
      "'-'",
      "<Mult>",
      "<Add_>",
    ],
    [
      "",
    ],
  ],
  "<Func Stm>": [
    [
      "if",
      "'('",
      "<Log Expr>",
      "')'",
      "then",
      "<Func Normal Stm>",
      "<Else Stm>",
    ],
    [
      "while",
      "'('",
      "<Log Expr>",
      "')'",
      "<Func Stm>",
    ],
    [
      "<Func Normal Stm>",
    ],
  ],
  "<Compare>": [
    [
      "<Add>",
      "<Compare_>",
    ],
  ],
  "<Equate>": [
    [
      "<Compare>",
      "<Equate_>",
    ],
  ],
  "<Log Equate_>": [
    [
      "'=='",
      "<Log Compare>",
      "<Log Equate_>",
    ],
    [
      "'!='",
      "<Log Compare>",
      "<Log Equate_>",
    ],
    [
      "",
    ],
  ],
  "<Mult>": [
    [
      "<Unary>",
      "<Mult_>",
    ],
  ],
  "<Program>": [
    [
      "<Const Block>",
      "<Var Block>",
      "<Decls>",
      "<Start Block>",
      "<Decls>",
    ],
  ],
  "<Log Expr>": [
    [
      "<Log Or>",
    ],
  ],
};
