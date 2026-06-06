; extends

; Imported package qualifier (e.g., fmt in fmt.Println)
(qualified_identifier
  (package_identifier) @module.qualifier)

; Capture builtin constants (nil, iota) separately from boolean literals.
; true/false are handled by the default parser as @boolean.
(nil) @constant.builtin
(iota) @constant.builtin
