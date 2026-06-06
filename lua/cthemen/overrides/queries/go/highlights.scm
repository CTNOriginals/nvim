; extends

; Imported package qualifier (e.g., fmt in fmt.Println)
(selector_expression
  operand: (identifier) @module.qualifier)

; Method receiver parameter (e.g., `s` in `func (s T) Method()`)
(method_declaration
  receiver: (parameter_list
    (parameter_declaration
      name: (identifier) @go.receiver)))
