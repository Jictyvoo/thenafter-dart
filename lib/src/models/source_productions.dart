const SourceProductions = <String, List<List<String>>>{
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
  "<Function Call>": [
    ["Identifier", "'('", "<Formal Parameter List>", "')'"]
  ],
  "<Value_assigned_matrix>": [
    ["<Value>", "','", "<Value_assigned_matrix>"],
    ["<Value>"]
  ],
  "<Number>": [
    ["DecLiteral"],
    ["OctLiteral"],
    ["HexLiteral"],
    ["FloatLiteral"]
  ],
  "<Logical Expression>": [
    ["<Expression Value Logical>", "<Logical>"],
    ["<Logical Denied>"]
  ],
  "<Global Decl>": [
    ["<Const Decl>"],
    ["<Var Decl>"],
    ["<Const Decl>", "<Var Decl>"],
    ["<Var Decl>", "<Const Decl>"],
    [""]
  ],
  "<Else Procedure>": [
    ["'else'", "'{'", "<Body Procedure>", "'}'"],
    [""]
  ],
  "<Term>": [
    ["<Expression Value>", "<Mult Exp>"]
  ],
  "<Type>": [
    ["int"],
    ["real"],
    ["boolean"],
    ["string"],
    ["struct", "Identifier"],
    ["Identifier"]
  ],
  "<Typedef Decl>": [
    ["typedef", "<Base>", "Identifier", "';'"]
  ],
  "<Relational>": [
    ["'>'", "<Exp>"],
    ["'<'", "<Exp>"],
    ["'<='", "<Exp>"],
    ["'>='", "<Exp>"],
    ["'=='", "<Exp>"],
    ["'!='", "<Exp>"]
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
  "<Body Item Procedure>": [
    ["<Var Decl>"],
    ["<While Procedure>"],
    ["<If Procedure>"],
    ["<Read>"],
    ["<Print>"],
    ["<Assign>"]
  ],
  "<Relational Expression>": [
    ["<Exp>", "<Relational>"]
  ],
  "<If>": [
    ["'if'", "'('", "<Conditional Expression>", "<Then>"]
  ],
  "<Else>": [
    ["'else'", "'{'", "<Body>", "'}'"],
    [""]
  ],
  "<ConstList>": [
    ["<Type>", "<Const>", "<ConstList>"],
    [""]
  ],
  "<Struct Decl>": [
    ["struct", "Identifier", "<Extends>", "'{'", "<VariablesList>", "'}'"]
  ],
  "<Assignment_vector_aux2>": [
    ["'='", "'{'", "<Value_assigned_vector>", "'}'"]
  ],
  "<Extends>": [
    ["'extends'", "Identifier"],
    [""]
  ],
  "<PrefixGlobalLocal>": [
    ["'global'", "'.'"],
    ["'local'", "'.'"]
  ],
  "<Read>": [
    ["read", "'('", "<Formal Parameter List Read>", "')'", "';'"]
  ],
  "<Value>": [
    ["<Number>"],
    ["<Boolean Literal>"],
    ["StringLiteral"]
  ],
  "<Params>": [
    ["<Param>", "','", "<Params>"],
    ["<Param>"],
    [""]
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
  "<Assignment_vector>": [
    ["<Assignment_vector_aux1>"],
    ["<Assignment_vector_aux2>"],
    [""]
  ],
  "<VariablesList>": [
    ["<Type>", "<Variable>", "<VariablesList>"],
    [""]
  ],
  "<Assignment_matrix_aux1>": [
    ["<Assignment_vector_aux1>"]
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
  "<Vector>": [
    ["'['", "<Index>", "']'"]
  ],
  "<Body>": [
    ["<Body Item>", "<Body>"],
    [""]
  ],
  "<Decls>": [
    ["<Decl>", "<Decls>"],
    [""]
  ],
  "<Const Decl>": [
    ["'const'", "'{'", "<ConstList>", "'}'"]
  ],
  "<Expression Value Logical>": [
    ["Identifier"],
    ["<Boolean Literal>"],
    ["StringLiteral"],
    ["<Function Call>"],
    ["<Relational Expression>"]
  ],
  "<Logical>": [
    ["<Conditional Operator>", "<Expression Value Logical>"],
    ["<Conditional Operator>", "<Logical Denied>"]
  ],
  "<Decl>": [
    ["<Function Declaration>"],
    ["<Proc Decl>"],
    ["<Struct Decl>"],
    ["<Typedef Decl>"]
  ],
  "<Assignment_matrix>": [
    ["<Assignment_matrix_aux1>"],
    ["<Assignment_matrix_aux2>"],
    [""]
  ],
  "<Return Statement>": [
    ["'return'", "';'"],
    ["'return'", "<Assign>"]
  ],
  "<Aux>": [
    ["'='", "<Value>", "<Delimiter Var>"],
    ["<Delimiter Var>"],
    ["<Vector>", "<Assignment_vector>", "<Delimiter Var>"],
    ["<Matrix>", "<Assignment_matrix>", "<Delimiter Var>"]
  ],
  "<Add Exp>": [
    ["'+'", "<Exp>"],
    ["'-'", "<Exp>"],
    [""]
  ],
  "<Base>": [
    ["<Type>"],
    ["struct", "<Extends>", "'{'", "<VariablesList>", "'}'"],
    ["<Struct Decl>"]
  ],
  "<Assign>": [
    ["<PrefixGlobalLocal>", "Identifier", "'='", "<Exp>", "';'"],
    ["Identifier", "'='", "<Exp>", "';'"],
    ["Identifier", "<Vector>", "<Assignment_vector>", "';'"],
    ["Identifier", "<Matrix>", "<Assignment_matrix>", "';'"],
    ["<Exp>", "';'"]
  ],
  "<Delimiter Var>": [
    ["','", "<Variable>"],
    ["';'"]
  ],
  "<Value_assigned_vector>": [
    ["<Value>", "','", "<Value_assigned_vector>"],
    ["<Value>"]
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
  "<Conditional Expression>": [
    ["<Boolean Literal>"],
    ["<Relational Expression>"],
    ["<Logical Expression>"]
  ],
  "<Mult Exp>": [
    ["'*'", "<Term>"],
    ["'/'", "<Term>"],
    [""]
  ],
  "<Exp>": [
    ["<PrefixGlobalLocal>", "<Term>", "<Add Exp>"],
    ["<Term>", "<Add Exp>"]
  ],
  "<Formal Parameter List Read>": [
    ["Identifier"],
    ["<Formal Parameter List Read>", "','", "Identifier"]
  ],
  "<Var Decl>": [
    ["'var'", "'{'", "<VariablesList>", "'}'"]
  ],
  "<Assignment_vector_aux1>": [
    ["'='", "<Value>"]
  ],
  "<Index>": [
    ["DecLiteral", "OctLiteral", "Identifier"]
  ],
  "<Boolean Literal>": [
    ["'true'"],
    ["'false'"]
  ],
  "<Const>": [
    ["Identifier", "'='", "<Value>", "<Delimiter Const>"]
  ],
  "<Conditional Operator>": [
    ["'&&'"],
    ["'||'"]
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
  "<Formal Parameter List>": [
    ["<Exp>"],
    ["<Exp>", "','", "<Formal Parameter List>"],
    [""]
  ],
  "<Then Procedure>": [
    ["')'", "'then'", "'{'", "<Body Procedure>", "'}'", "<Else Procedure>"]
  ],
  "<Start>": [
    ["'start'", "'('", "')'", "'{'", "<Body Procedure>", "'}'", "<Decls>"]
  ],
  "<Print>": [
    ["print", "'('", "<Formal Parameter List>", "')'", "';'"]
  ],
  "<Dimensao_matrix2>": [
    ["','", "'{'", "<Value_assigned_matrix>", "'}'", "'}'"]
  ],
  "<If Procedure>": [
    ["'if'", "'('", "<Conditional Expression>", "<Then Procedure>"]
  ],
  "<Then>": [
    ["')'", "'then'", "'{'", "<Body>", "'}'", "<Else>"]
  ],
  "<Param>": [
    ["const", "<Type>", "Identifier"],
    ["<Type>", "Identifier"]
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
  "<Variable>": [
    ["Identifier", "<Aux>"]
  ],
  "<Delimiter Const>": [
    ["','", "<Const>"],
    ["';'"]
  ],
  "<Program>": [
    ["<Global Decl>", "<Decls>", "<Start>"]
  ],
  "<Matrix>": [
    ["'['", "<Index>", "']'", "<Vector>"]
  ]
};
