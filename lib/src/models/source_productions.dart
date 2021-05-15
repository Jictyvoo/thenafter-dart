const SourceProductions = <String, List<List<String>>>{
  "<Start>": [
    ["'start'", "'('", "')'", "'{'", "<Body Procedure>", "'}'", "<Decls>"]
  ],
  "<Proc Decl>": [
    [
      "'procedure'",
      "Identifier",
      "'('",
      "<Params>",
      "')'",
      "'{'",
      "<Body Procedure>",
      "'}'"
    ],
    [
      "Identifier",
      "'('",
      "<Formal Parameter List>",
      "')'",
      "'{'",
      "<Body Procedure>",
      "'}'"
    ]
  ],
  "<Param>": [
    ["const", "<Type>", "Identifier"],
    ["<Type>", "Identifier"]
  ],
  "<Assignment_matrix_aux1>": [
    ["<Assignment_vector_aux1>"]
  ],
  "<Value_assigned_vector>": [
    ["<Value>", "','", "<Value_assigned_vector>"],
    ["<Value>"]
  ],
  "<Body Item>": [
    ["<Var Decl>"],
    ["<While>"],
    ["<If>"],
    ["<Read>"],
    ["<Print>"],
    ["<Assign>"],
    ["<Return Statement>"]
  ],
  "<Formal Parameter List Read>": [
    ["Identifier"],
    ["<Formal Parameter List Read>", "','", "Identifier"]
  ],
  "<PrefixGlobalLocal>": [
    ["'global.'"],
    ["'local.'"]
  ],
  "<Function Call>": [
    ["Identifier", "'('", "<Formal Parameter List>", "')'"]
  ],
  "<Body Item Procedure>": [
    ["<Var Decl>"],
    ["<While Procedure>"],
    ["<If Procedure>"],
    ["<Read>"],
    ["<Print>"],
    ["<Assign>"]
  ],
  "<Body>": [
    ["<Body Item>", "<Body>"],
    [""]
  ],
  "<Relational>": [
    ["'>'", "<Exp>"],
    ["'<'", "<Exp>"],
    ["'<='", "<Exp>"],
    ["'>='", "<Exp>"],
    ["'=='", "<Exp>"],
    ["'!='", "<Exp>"]
  ],
  "<Conditional Expression>": [
    ["<Boolean Literal>"],
    ["<Relational Expression>"],
    ["<Logical Expression>"]
  ],
  "<While>": [
    [
      "'while'",
      "'('",
      "<Conditional Expression>",
      "')'",
      "'{'",
      "<Body>",
      "'}'"
    ]
  ],
  "<Number>": [
    ["DecLiteral"],
    ["OctLiteral"],
    ["HexLiteral"],
    ["FloatLiteral"]
  ],
  "<Base>": [
    ["<Type>"],
    ["struct", "<Extends>", "'{'", "<VariablesList>", "'}'"],
    ["<Struct Decl>"]
  ],
  "<Assignment_matrix_aux2>": [
    [
      "'='",
      "'{'",
      "'{'",
      "<Value_assigned_matrix>",
      "'}'",
      "<Dimensao_matrix2>"
    ]
  ],
  "<Vector>": [
    ["'['", "<Index>", "']'"]
  ],
  "<Index>": [
    ["DecLiteral|", "OctLiteral|", "Identifier"]
  ],
  "<Value_assigned_matrix>": [
    ["<Value>", "','", "<Value_assigned_matrix>"],
    ["<Value>"]
  ],
  "<Matrix>": [
    ["'['", "<Index>", "']'", "<Vector>"]
  ],
  "<Struct Decl>": [
    ["struct", "Identifier", "<Extends>", "'{'", "<VariablesList>", "'}'"]
  ],
  "<Conditional Operator>": [
    ["'&&'"],
    ["'||'"]
  ],
  "<Formal Parameter List>": [
    ["<Exp>"],
    ["<Exp>", "','", "<Formal Parameter List>"],
    [""]
  ],
  "<Variable>": [
    ["Identifier", "<Aux>"]
  ],
  "<Then Procedure>": [
    ["')'", "'then'", "'{'", "<Body Procedure>", "'}'", "<Else Procedure>"]
  ],
  "<ConstList>": [
    ["<Type>", "<Const>", "<ConstList>"],
    [""]
  ],
  "<Function Declaration>": [
    [
      "'function'",
      "<Type>",
      "Identifier",
      "'('",
      "<Params>",
      "')'",
      "'{'",
      "<Body>",
      "'}'"
    ]
  ],
  "<Const>": [
    ["Identifier", "'='", "<Value>", "<Delimiter Const>"]
  ],
  "<Read>": [
    ["read'('", "<Formal Parameter List Read>", "')'", "';'"]
  ],
  "<Dimensao_matrix2>": [
    ["','", "'{'", "<Value_assigned_matrix>", "'}'", "'}'"]
  ],
  "<Relational Expression>": [
    ["<Exp>", "<Relational>"]
  ],
  "<Delimiter Var>": [
    ["','", "<Variable>"],
    ["';'"]
  ],
  "<Global Decl>": [
    ["<Const Decl>"],
    ["<Var Decl>"],
    ["<Const Decl>", "<Var Decl>"],
    ["<Var Decl>", "<Const Decl>"],
    [""]
  ],
  "<Assign>": [
    ["<PrefixGlobalLocal>", "Identifier", "'='", "<Exp>", "';'"],
    ["Identifier", "'='", "<Exp>", "';'"],
    ["Identifier", "<Vector>", "<Assignment_vector>", "';'"],
    ["Identifier", "<Matrix>", "<Assignment_matrix>", "';'"],
    ["<Exp>", "';'"]
  ],
  "<VariablesList>": [
    ["<Type>", "<Variable>", "<VariablesList>"],
    [""]
  ],
  "<Logical Expression>": [
    ["<Expression Value Logical>", "<Logical>"],
    ["<Logical Denied>"]
  ],
  "<Value>": [
    ["<Number>"],
    ["<Boolean Literal>"],
    ["StringLiteral"]
  ],
  "<Exp>": [
    ["<PrefixGlobalLocal>", "<Term>", "<Add Exp>"],
    ["<Term>", "<Add Exp>"]
  ],
  "<Expression Value>": [
    ["'-'", "<Expression Value>"],
    ["Identifier"],
    ["'('", "<Exp>", "')'"],
    ["<Number>"],
    ["<Boolean Literal>"],
    ["StringLiteral"],
    ["<Function Call>"]
  ],
  "<Type>": [
    ["int"],
    ["real"],
    ["boolean"],
    ["string"],
    ["struct", "Identifier"],
    ["Identifier"]
  ],
  "<Mult Exp>": [
    ["'*'", "<Term>"],
    ["'/'", "<Term>"],
    [""]
  ],
  "<Delimiter Const>": [
    ["','", "<Const>"],
    ["';'"]
  ],
  "<Term>": [
    ["<Expression Value>", "<Mult Exp>"]
  ],
  "<Add Exp>": [
    ["'+'", "<Exp>"],
    ["'-'", "<Exp>"],
    [""]
  ],
  "<If>": [
    ["'if'", "'('", "<Conditional Expression>", "<Then>"]
  ],
  "<Expression Value Logical>": [
    ["Identifier"],
    ["<Boolean Literal>"],
    ["StringLiteral"],
    ["<Function Call>"],
    ["<Relational Expression>"]
  ],
  "<Extends>": [
    ["'extends'", "Identifier"],
    [""]
  ],
  "<Assignment_vector>": [
    ["<Assignment_vector_aux1>"],
    ["<Assignment_vector_aux2>"],
    [""]
  ],
  "<Else>": [
    ["'else'", "'{'", "<Body>", "'}'"],
    [""]
  ],
  "<Logical Denied>": [
    ["'!'", "Identifier"],
    ["'!'", "<Boolean Literal>"],
    ["'!'", "<Logical Expression>"],
    ["'!'", "<Relational Expression>"]
  ],
  "<Body Procedure>": [
    ["<Body Item Procedure>", "<Body Procedure>"],
    [""]
  ],
  "<Return Statement>": [
    ["'return'", "';'"],
    ["'return'", "<Assign>"]
  ],
  "<Params>": [
    ["<Param>", "','", "<Params>"],
    ["<Param>"],
    [""]
  ],
  "<While Procedure>": [
    [
      "'while'",
      "'('",
      "<Conditional Expression>",
      "')'",
      "'{'",
      "<Body Procedure>",
      "'}'"
    ]
  ],
  "<If Procedure>": [
    ["'if'", "'('", "<Conditional Expression>", "<Then Procedure>"]
  ],
  "<Aux>": [
    ["'='", "<Value>", "<Delimiter Var>"],
    ["<Delimiter Var>"],
    ["<Vector>", "<Assignment_vector>", "<Delimiter Var>"],
    ["<Matrix>", "<Assignment_matrix>", "<Delimiter Var>"]
  ],
  "<Program>": [
    ["<Global Decl>", "<Decls>", "<Start>"]
  ],
  "<Logical>": [
    ["<Conditional Operator>", "<Expression Value Logical>"],
    ["<Conditional Operator>", "<Logical Denied>"]
  ],
  "<Const Decl>": [
    ["'const'", "'{'", "<ConstList>", "'}'"]
  ],
  "<Then>": [
    ["')'", "'then'", "'{'", "<Body>", "'}'", "<Else>"]
  ],
  "<Decls>": [
    ["<Decl>", "<Decls>"],
    [""]
  ],
  "<Assignment_vector_aux2>": [
    ["'='", "'{'", "<Value_assigned_vector>", "'}'"]
  ],
  "<Typedef Decl>": [
    ["typedef", "<Base>", "Identifier", "';'"]
  ],
  "<Decl>": [
    ["<Function Declaration>"],
    ["<Proc Decl>"],
    ["<Struct Decl>"],
    ["<Typedef Decl>"]
  ],
  "<Print>": [
    ["print'('", "<Formal Parameter List>", "')'", "';'"]
  ],
  "<Assignment_matrix>": [
    ["<Assignment_matrix_aux1>"],
    ["<Assignment_matrix_aux2>"],
    [""]
  ],
  "<Var Decl>": [
    ["'var'", "'{'", "<VariablesList>", "'}'"]
  ],
  "<Boolean Literal>": [
    ["'true'"],
    ["'false'"]
  ],
  "<Assignment_vector_aux1>": [
    ["'='", "<Value>"]
  ],
  "<Else Procedure>": [
    ["'else'", "'{'", "<Body Procedure>", "'}'"],
    [""]
  ]
};
