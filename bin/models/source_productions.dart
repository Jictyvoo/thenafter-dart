const SourceProductions = <String, List<List<String>>>{
  "<Base>": [
    ["<Type>"],
    ["struct", "<Extends>", "'{'", "<VariablesList>", "'}'"],
    ["<Struct Decl>"]
  ],
  "<Relational Expression>": [
    ["<Exp>", "<Relational>"]
  ],
  "<Formal Parameter List Read>": [
    ["Identifier"],
    ["<Formal Parameter List Read>", "','", "Identifier"]
  ],
  "<Conditional Operator>": [
    ["'&&'"],
    ["'||'"]
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
  "<Then>": [
    ["')'", "'then'", "'{'", "<Body>", "'}'", "<Else>"]
  ],
  "<If>": [
    ["'if'", "'('", "<Conditional Expression>", "<Then>"]
  ],
  "<Body>": [
    ["<Body Item>", "<Body>"],
    [""]
  ],
  "<Type>": [
    ["int"],
    ["real"],
    ["boolean"],
    ["string"],
    ["struct", "Identifier"],
    ["Identifier"]
  ],
  "<Var Decl>": [
    ["'var'", "'{'", "<VariablesList>", "'}'"],
    [""]
  ],
  "<Assignment_matrix_aux1>": [
    ["<Assignment_vector_aux1>"]
  ],
  "<Function Call>": [
    ["Identifier", "'('", "<Formal Parameter List>", "')'"]
  ],
  "<Value_assigned_vector>": [
    ["<Value>", "','", "<Value_assigned_vector>"],
    ["<Value>"]
  ],
  "<Index>": [
    ["DecLiteral"],
    ["OctLiteral"],
    ["Identifier"]
  ],
  "<Assignment_vector_aux2>": [
    ["'='", "'{'", "<Value_assigned_vector>", "'}'"]
  ],
  "<Program>": [
    ["<Global Decl>", "<Decls>", "<Start>"]
  ],
  "<Read>": [
    ["'read'", "'('", "<Formal Parameter List Read>", "')'", "';'"]
  ],
  "<Relational>": [
    ["'>'", "<Exp>"],
    ["'<'", "<Exp>"],
    ["'<='", "<Exp>"],
    ["'>='", "<Exp>"],
    ["'=='", "<Exp>"],
    ["'!='", "<Exp>"]
  ],
  "<Else>": [
    ["'else'", "'{'", "<Body>", "'}'"],
    [""]
  ],
  "<Assignment_vector>": [
    ["<Assignment_vector_aux1>"],
    ["<Assignment_vector_aux2>"],
    [""]
  ],
  "<Const Decl>": [
    ["'const'", "'{'", "<ConstList>", "'}'"],
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
  "<Value>": [
    ["<Number>"],
    ["<Boolean Literal>"],
    ["StringLiteral"]
  ],
  "<Assign>": [
    ["<PrefixGlobalLocal>", "Identifier", "'='", "<Exp>", "';'"],
    ["Identifier", "'='", "<Exp>", "';'"],
    ["Identifier", "<Vector>", "<Assignment_vector>", "';'"],
    ["Identifier", "<Matrix>", "<Assignment_matrix>", "';'"],
    ["<Exp>", "';'"]
  ],
  "<Const>": [
    ["Identifier", "'='", "<Value>", "<Delimiter Const>"]
  ],
  "<Start>": [
    ["'start'", "'('", "')'", "'{'", "<Body Procedure>", "'}'", "<Decls>"]
  ],
  "<Conditional Expression>": [
    ["<Boolean Literal>"],
    ["<Relational Expression>"],
    ["<Logical Expression>"]
  ],
  "<Variable>": [
    ["Identifier", "<Aux>"]
  ],
  "<If Procedure>": [
    ["'if'", "'('", "<Conditional Expression>", "<Then Procedure>"]
  ],
  "<Boolean Literal>": [
    ["'true'"],
    ["'false'"]
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
  "<Exp>": [
    ["<PrefixGlobalLocal>", "<Term>", "<Add Exp>"],
    ["<Term>", "<Add Exp>"]
  ],
  "<Then Procedure>": [
    ["')'", "'then'", "'{'", "<Body Procedure>", "'}'", "<Else Procedure>"]
  ],
  "<Body Item Procedure>": [
    ["<Var Decl>"],
    ["<While Procedure>"],
    ["<If Procedure>"],
    ["<Read>"],
    ["<Print>"],
    ["<Assign>"]
  ],
  "<Typedef Decl>": [
    ["typedef", "<Base>", "Identifier", "';'"]
  ],
  "<Logical Denied>": [
    ["'!'", "Identifier"],
    ["'!'", "<Boolean Literal>"],
    ["'!'", "<Logical Expression>"],
    ["'!'", "<Relational Expression>"]
  ],
  "<Print>": [
    ["print", "'('", "<Formal Parameter List>", "')'", "';'"]
  ],
  "<VariablesList>": [
    ["<Type>", "<Variable>", "<VariablesList>"],
    [""]
  ],
  "<Global Decl>": [
    ["<Const Decl>", "<Var Decl>"],
    ["<Var Decl>", "<Const Decl>"],
    [""]
  ],
  "<Param>": [
    ["const", "<Type>", "Identifier"],
    ["<Type>", "Identifier"]
  ],
  "<Else Procedure>": [
    ["'else'", "'{'", "<Body Procedure>", "'}'"],
    [""]
  ],
  "<Extends>": [
    ["'extends'", "Identifier"],
    [""]
  ],
  "<Vector>": [
    ["'['", "<Index>", "']'"]
  ],
  "<Delimiter Var>": [
    ["','", "<Variable>"],
    ["';'"]
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
  "<Aux>": [
    ["'='", "<Value>", "<Delimiter Var>"],
    ["<Delimiter Var>"],
    ["<Vector>", "<Assignment_vector>", "<Delimiter Var>"],
    ["<Matrix>", "<Assignment_matrix>", "<Delimiter Var>"]
  ],
  "<Dimensao_matrix2>": [
    ["','", "'{'", "<Value_assigned_matrix>", "'}'", "'}'"]
  ],
  "<Term>": [
    ["<Expression Value>", "<Mult Exp>"]
  ],
  "<Add Exp>": [
    ["'+'", "<Exp>"],
    ["'-'", "<Exp>"],
    [""]
  ],
  "<Body Procedure>": [
    ["<Body Item Procedure>", "<Body Procedure>"],
    [""]
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
  "<PrefixGlobalLocal>": [
    ["'global'", "'.'"],
    ["'local'", "'.'"]
  ],
  "<Expression Value Logical>": [
    ["Identifier"],
    ["<Boolean Literal>"],
    ["StringLiteral"],
    ["<Function Call>"],
    ["<Relational Expression>"]
  ],
  "<Matrix>": [
    ["'['", "<Index>", "']'", "<Vector>"]
  ],
  "<Mult Exp>": [
    ["'*'", "<Term>"],
    ["'/'", "<Term>"],
    [""]
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
  "<Logical>": [
    ["<Conditional Operator>", "<Expression Value Logical>"],
    ["<Conditional Operator>", "<Logical Denied>"]
  ],
  "<Formal Parameter List>": [
    ["<Exp>"],
    ["<Exp>", "','", "<Formal Parameter List>"],
    [""]
  ],
  "<Logical Expression>": [
    ["<Expression Value Logical>", "<Logical>"],
    ["<Logical Denied>"]
  ],
  "<Return Statement>": [
    ["'return'", "';'"],
    ["'return'", "<Assign>"]
  ],
  "<Decls>": [
    ["<Decl>", "<Decls>"],
    [""]
  ],
  "<ConstList>": [
    ["<Type>", "<Const>", "<ConstList>"],
    [""]
  ],
  "<Number>": [
    ["DecLiteral"],
    ["OctLiteral"],
    ["HexLiteral"],
    ["FloatLiteral"]
  ],
  "<Struct Decl>": [
    ["struct", "Identifier", "<Extends>", "'{'", "<VariablesList>", "'}'"]
  ],
  "<Assignment_matrix>": [
    ["<Assignment_matrix_aux1>"],
    ["<Assignment_matrix_aux2>"],
    [""]
  ],
  "<Value_assigned_matrix>": [
    ["<Value>", "','", "<Value_assigned_matrix>"],
    ["<Value>"]
  ],
  "<Decl>": [
    ["<Function Declaration>"],
    ["<Proc Decl>"],
    ["<Struct Decl>"],
    ["<Typedef Decl>"]
  ],
  "<Delimiter Const>": [
    ["','", "<Const>"],
    ["';'"]
  ],
  "<Assignment_vector_aux1>": [
    ["'='", "<Value>"]
  ]
};
