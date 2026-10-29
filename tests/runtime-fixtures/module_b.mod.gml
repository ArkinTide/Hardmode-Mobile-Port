global.shared = 100
#define read_other
result = mod_variable_get("mod", "runtime-fixtures/module_a", "shared")
return result
#define target_callback(value)
marker += value
return marker
#define context_callback
observed_other = other.marker
return id
