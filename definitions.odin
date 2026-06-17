package s7


import "core:c"
// Foreign import for the C library
foreign import s7 "s7.o"  // Adjust path for your system

_ :: c



s7_int :: i64

s7_double :: f64

s7_complex :: complex32

s7_scheme :: struct {
}

s7_cell :: struct {}

s7_pointer :: ^s7_cell

s7_function :: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer

s7_pfunc :: proc "c" (^s7_scheme) -> s7_pointer

s7_read_t :: enum c.int {
	READ,
	READ_CHAR,
	READ_LINE,
	PEEK_CHAR,
	IS_CHAR_READY,
	NUM_READ_CHOICES,
}

s7_float_function :: proc "c" (^s7_scheme) -> s7_double

s7_d_t :: proc "c" () -> s7_double

s7_d_d_t :: proc "c" (s7_double) -> s7_double

s7_d_dd_t :: proc "c" (s7_double, s7_double) -> s7_double

s7_d_ddd_t :: proc "c" (s7_double, s7_double, s7_double) -> s7_double

s7_d_dddd_t :: proc "c" (s7_double, s7_double, s7_double, s7_double) -> s7_double

s7_d_v_t :: proc "c" (rawptr) -> s7_double

s7_d_vd_t :: proc "c" (rawptr, s7_double) -> s7_double

s7_d_vdd_t :: proc "c" (rawptr, s7_double, s7_double) -> s7_double

s7_d_vid_t :: proc "c" (rawptr, s7_int, s7_double) -> s7_double

s7_d_p_t :: proc "c" (s7_pointer) -> s7_double

s7_d_pd_t :: proc "c" (s7_pointer, s7_double) -> s7_double

s7_d_7pi_t :: proc "c" (^s7_scheme, s7_pointer, s7_int) -> s7_double

s7_d_7pid_t :: proc "c" (^s7_scheme, s7_pointer, s7_int, s7_double) -> s7_double

s7_d_id_t :: proc "c" (s7_int, s7_double) -> s7_double

s7_d_ip_t :: proc "c" (s7_int, s7_pointer) -> s7_double

s7_i_i_t :: proc "c" (s7_int) -> s7_int

s7_i_7d_t :: proc "c" (^s7_scheme, s7_double) -> s7_int

s7_i_ii_t :: proc "c" (s7_int, s7_int) -> s7_int

s7_i_7p_t :: proc "c" (^s7_scheme, s7_pointer) -> s7_int

s7_b_p_t :: proc "c" (s7_pointer) -> bool

s7_p_d_t :: proc "c" (^s7_scheme, s7_double) -> s7_pointer

s7_p_p_t :: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer

s7_p_pp_t :: proc "c" (^s7_scheme, s7_pointer, s7_pointer) -> s7_pointer

s7_p_ppp_t :: proc "c" (^s7_scheme, s7_pointer, s7_pointer, s7_pointer) -> s7_pointer

s7_Int :: s7_int

s7_Double :: s7_double

@(default_calling_convention="c", link_prefix="")
foreign s7 {
	s7_init :: proc() -> ^s7_scheme ---

	/* s7_scheme is our interpreter
	* s7_pointer is a Scheme object of any (Scheme) type
	* s7_init creates the interpreter.
	*/
	s7_free           :: proc(sc: ^s7_scheme) ---
	s7_f              :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_t              :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_nil            :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_undefined      :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_unspecified    :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_is_unspecified :: proc(sc: ^s7_scheme, val: s7_pointer) -> bool ---
	s7_eof_object     :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_is_null        :: proc(sc: ^s7_scheme, p: s7_pointer) -> bool ---

	/* these are the Scheme constants; they do not change in value during a run,
	*   so they can be safely assigned to C global variables if desired.
	*/
	s7_is_valid                         :: proc(sc: ^s7_scheme, arg: s7_pointer) -> bool ---
	s7_is_c_pointer                     :: proc(arg: s7_pointer) -> bool ---
	s7_is_c_pointer_of_type             :: proc(arg: s7_pointer, type: s7_pointer) -> bool ---
	s7_c_pointer                        :: proc(p: s7_pointer) -> rawptr ---
	s7_c_pointer_with_type              :: proc(sc: ^s7_scheme, p: s7_pointer, expected_type: s7_pointer, caller: cstring, argnum: s7_int) -> rawptr ---
	s7_c_pointer_type                   :: proc(p: s7_pointer) -> s7_pointer ---
	s7_make_c_pointer                   :: proc(sc: ^s7_scheme, ptr: rawptr) -> s7_pointer ---
	s7_make_c_pointer_with_type         :: proc(sc: ^s7_scheme, ptr: rawptr, type: s7_pointer, info: s7_pointer) -> s7_pointer ---
	s7_make_c_pointer_wrapper_with_type :: proc(sc: ^s7_scheme, ptr: rawptr, type: s7_pointer, info: s7_pointer) -> s7_pointer ---
	s7_eval_c_string                    :: proc(sc: ^s7_scheme, str: cstring) -> s7_pointer ---
	s7_eval_c_string_with_environment   :: proc(sc: ^s7_scheme, str: cstring, e: s7_pointer) -> s7_pointer ---
	s7_object_to_string                 :: proc(sc: ^s7_scheme, arg: s7_pointer, use_write: bool) -> s7_pointer ---

	/* (object->string obj) */
	s7_object_to_c_string             :: proc(sc: ^s7_scheme, obj: s7_pointer) -> cstring ---
	s7_load                           :: proc(sc: ^s7_scheme, file: cstring) -> s7_pointer ---
	s7_load_with_environment          :: proc(sc: ^s7_scheme, filename: cstring, e: s7_pointer) -> s7_pointer ---
	s7_load_c_string                  :: proc(sc: ^s7_scheme, content: cstring, bytes: s7_int) -> s7_pointer ---
	s7_load_c_string_with_environment :: proc(sc: ^s7_scheme, content: cstring, bytes: s7_int, e: s7_pointer) -> s7_pointer ---
	s7_load_path                      :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_add_to_load_path               :: proc(sc: ^s7_scheme, dir: cstring) -> s7_pointer ---
	s7_autoload                       :: proc(sc: ^s7_scheme, symbol: s7_pointer, file_or_function: s7_pointer) -> s7_pointer ---
	s7_autoload_set_names             :: proc(sc: ^s7_scheme, names: ^^u8, size: s7_int) ---

	/* the load path is a list of directories to search if load can't find the file passed as its argument.
	*
	*   s7_load and s7_load_with_environment can load shared object files as well as scheme code.
	*   The scheme (load "somelib.so" (inlet 'init_func 'somelib_init)) is equivalent to
	*     s7_load_with_environment(s7, "somelib.so", s7_inlet(s7, s7_list(s7, 2, s7_make_symbol(s7, "init_func"), s7_make_symbol(s7, "somelib_init"))))
	*   s7_load_with_environment returns NULL if it can't load the file.
	*/
	s7_quit :: proc(sc: ^s7_scheme) ---

	/* this tries to break out of the current evaluation, leaving everything else intact */
	s7_begin_hook     :: proc(sc: ^s7_scheme) ---
	s7_set_begin_hook :: proc(sc: ^s7_scheme, hook: proc "c" (^s7_scheme, ^bool)) ---

	/* call "hook" at the start of any block; use NULL to cancel.
	*   s7_begin_hook returns the current begin_hook function or NULL.
	*/
	s7_eval                 :: proc(sc: ^s7_scheme, code: s7_pointer, e: s7_pointer) -> s7_pointer ---
	s7_eval_with_location   :: proc(sc: ^s7_scheme, code: s7_pointer, e: s7_pointer, caller: cstring, file: cstring, line: s7_int) -> s7_pointer ---
	s7_provide              :: proc(sc: ^s7_scheme, feature: cstring) ---
	s7_is_provided          :: proc(sc: ^s7_scheme, feature: cstring) -> bool ---
	s7_repl                 :: proc(sc: ^s7_scheme) ---
	s7_error                :: proc(sc: ^s7_scheme, type: s7_pointer, info: s7_pointer) -> s7_pointer ---
	s7_wrong_type_arg_error :: proc(sc: ^s7_scheme, caller: cstring, arg_n: s7_int, arg: s7_pointer, descr: cstring) -> s7_pointer ---
	s7_wrong_type_error     :: proc(sc: ^s7_scheme, caller: s7_pointer, arg_n: s7_int, arg: s7_pointer, descr: s7_pointer) -> s7_pointer ---

	/* set arg_n to 0 to indicate that caller takes only one argument (so the argument number need not be reported */
	s7_out_of_range_error         :: proc(sc: ^s7_scheme, caller: cstring, arg_n: s7_int, arg: s7_pointer, descr: cstring) -> s7_pointer ---
	s7_wrong_number_of_args_error :: proc(sc: ^s7_scheme, caller: cstring, args: s7_pointer) -> s7_pointer ---

	/* these are equivalent to (error ...) in Scheme
	*   the first argument to s7_error is a symbol that can be caught (via (catch tag ...))
	*   the rest of the arguments are passed to the error handler (if in catch)
	*   or printed out (in the default case).  If the first element of the list
	*   of args ("info") is a string, the default error handler treats it as
	*   a format control string, and passes it to format with the rest of the
	*   info list as the format function arguments.
	*
	*   s7_wrong_type_arg_error is equivalent to s7_error with a type of 'wrong-type-arg
	*   and similarly s7_out_of_range_error with type 'out-of-range.
	*
	* catch in Scheme is taken from Guile:
	*
	*  (catch tag thunk handler)
	*
	*  evaluates 'thunk'.  If an error occurs, and the type matches 'tag' (or if 'tag' is #t),
	*  the handler is called, passing it the arguments (including the type) passed to the
	*  error function.  If no handler is found, the default error handler is called,
	*  normally printing the error arguments to current-error-port.
	*/
	s7_stacktrace                :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_history                   :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_add_to_history            :: proc(sc: ^s7_scheme, entry: s7_pointer) -> s7_pointer ---
	s7_history_enabled           :: proc(sc: ^s7_scheme) -> bool ---
	s7_set_history_enabled       :: proc(sc: ^s7_scheme, enabled: bool) -> bool ---
	s7_gc_on                     :: proc(sc: ^s7_scheme, on: bool) -> s7_pointer ---
	s7_gc_protect                :: proc(sc: ^s7_scheme, x: s7_pointer) -> s7_int ---
	s7_gc_unprotect_at           :: proc(sc: ^s7_scheme, loc: s7_int) ---
	s7_gc_protected_at           :: proc(sc: ^s7_scheme, loc: s7_int) -> s7_pointer ---
	s7_gc_protect_via_stack      :: proc(sc: ^s7_scheme, x: s7_pointer) -> s7_pointer ---
	s7_gc_protect_2_via_stack    :: proc(sc: ^s7_scheme, x: s7_pointer, y: s7_pointer) -> s7_pointer ---
	s7_gc_unprotect_via_stack    :: proc(sc: ^s7_scheme, x: s7_pointer) -> s7_pointer ---
	s7_gc_protect_via_location   :: proc(sc: ^s7_scheme, x: s7_pointer, loc: s7_int) -> s7_pointer ---
	s7_gc_unprotect_via_location :: proc(sc: ^s7_scheme, loc: s7_int) -> s7_pointer ---

	/* any s7_pointer object held in C (as a local variable for example) needs to be
	*   protected from garbage collection if there is any chance the GC may run without
	*   an existing Scheme-level reference to that object.  s7_gc_protect places the
	*   object in a vector that the GC always checks, returning the object's location
	*   in that table.  s7_gc_unprotect_at unprotects the object (removes it from the
	*   vector) using the location passed to it.  s7_gc_protected_at returns the object
	*   at the given location.
	*
	* You can turn the GC on and off via s7_gc_on.
	*
	* There is a built-in lag between the creation of a new object and its first possible GC
	*    (the lag time is set indirectly by GC_TEMPS_SIZE in s7.c), so you don't need to worry about
	*    very short term temps such as the arguments to s7_cons in:
	*
	*    s7_cons(s7, s7_make_real(s7, 3.14),
	*                s7_cons(s7, s7_make_integer(s7, 123), s7_nil(s7)));
	*/
	s7_is_eq         :: proc(a: s7_pointer, b: s7_pointer) -> bool ---
	s7_is_eqv        :: proc(sc: ^s7_scheme, a: s7_pointer, b: s7_pointer) -> bool ---
	s7_is_equal      :: proc(sc: ^s7_scheme, a: s7_pointer, b: s7_pointer) -> bool ---
	s7_is_equivalent :: proc(sc: ^s7_scheme, x: s7_pointer, y: s7_pointer) -> bool ---
	s7_is_boolean    :: proc(x: s7_pointer) -> bool ---
	s7_boolean       :: proc(sc: ^s7_scheme, x: s7_pointer) -> bool ---
	s7_make_boolean  :: proc(sc: ^s7_scheme, x: bool) -> s7_pointer ---

	/* for each Scheme type (boolean, integer, string, etc), there are three
	*   functions: s7_<type>(...), s7_make_<type>(...), and s7_is_<type>(...):
	*
	*   s7_boolean(s7, obj) returns the C bool corresponding to the value of 'obj' (#f -> false)
	*   s7_make_boolean(s7, false|true) returns the s7 boolean corresponding to the C bool argument (false -> #f)
	*   s7_is_boolean(s7, obj) returns true if 'obj' has a boolean value (#f or #t).
	*/
	s7_is_pair                         :: proc(p: s7_pointer) -> bool ---
	s7_cons                            :: proc(sc: ^s7_scheme, a: s7_pointer, b: s7_pointer) -> s7_pointer ---
	s7_car                             :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdr                             :: proc(p: s7_pointer) -> s7_pointer ---
	s7_set_car                         :: proc(p: s7_pointer, q: s7_pointer) -> s7_pointer ---
	s7_set_cdr                         :: proc(p: s7_pointer, q: s7_pointer) -> s7_pointer ---
	s7_cadr                            :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cddr                            :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdar                            :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caar                            :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caadr                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caddr                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cadar                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caaar                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdadr                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdddr                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cddar                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdaar                           :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caaadr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caaddr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caadar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caaaar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cadadr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cadddr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_caddar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cadaar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdaadr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdaddr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdadar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdaaar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cddadr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cddddr                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cdddar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_cddaar                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_is_list                         :: proc(sc: ^s7_scheme, p: s7_pointer) -> bool ---
	s7_is_proper_list                  :: proc(sc: ^s7_scheme, p: s7_pointer) -> bool ---
	s7_list_length                     :: proc(sc: ^s7_scheme, a: s7_pointer) -> s7_int ---
	s7_make_list                       :: proc(sc: ^s7_scheme, len: s7_int, init: s7_pointer) -> s7_pointer ---
	s7_list                            :: proc(sc: ^s7_scheme, num_values: s7_int) -> s7_pointer ---
	s7_list_nl                         :: proc(sc: ^s7_scheme, num_values: s7_int) -> s7_pointer ---
	s7_array_to_list                   :: proc(sc: ^s7_scheme, num_values: s7_int, array: ^s7_pointer) -> s7_pointer ---
	s7_list_to_array                   :: proc(sc: ^s7_scheme, list: s7_pointer, array: ^s7_pointer, len: i32) ---
	s7_reverse                         :: proc(sc: ^s7_scheme, a: s7_pointer) -> s7_pointer ---
	s7_append                          :: proc(sc: ^s7_scheme, a: s7_pointer, b: s7_pointer) -> s7_pointer ---
	s7_list_ref                        :: proc(sc: ^s7_scheme, lst: s7_pointer, num: s7_int) -> s7_pointer ---
	s7_list_set                        :: proc(sc: ^s7_scheme, lst: s7_pointer, num: s7_int, val: s7_pointer) -> s7_pointer ---
	s7_assoc                           :: proc(sc: ^s7_scheme, obj: s7_pointer, lst: s7_pointer) -> s7_pointer ---
	s7_assq                            :: proc(sc: ^s7_scheme, obj: s7_pointer, x: s7_pointer) -> s7_pointer ---
	s7_member                          :: proc(sc: ^s7_scheme, obj: s7_pointer, lst: s7_pointer) -> s7_pointer ---
	s7_memq                            :: proc(sc: ^s7_scheme, obj: s7_pointer, x: s7_pointer) -> s7_pointer ---
	s7_tree_memq                       :: proc(sc: ^s7_scheme, sym: s7_pointer, tree: s7_pointer) -> bool ---
	s7_is_string                       :: proc(p: s7_pointer) -> bool ---
	s7_string                          :: proc(p: s7_pointer) -> cstring ---
	s7_make_string                     :: proc(sc: ^s7_scheme, str: cstring) -> s7_pointer ---
	s7_make_string_with_length         :: proc(sc: ^s7_scheme, str: cstring, len: s7_int) -> s7_pointer ---
	s7_make_string_wrapper             :: proc(sc: ^s7_scheme, str: cstring) -> s7_pointer ---
	s7_make_string_wrapper_with_length :: proc(sc: ^s7_scheme, str: cstring, len: s7_int) -> s7_pointer ---
	s7_make_permanent_string           :: proc(sc: ^s7_scheme, str: cstring) -> s7_pointer ---
	s7_make_semipermanent_string       :: proc(sc: ^s7_scheme, str: cstring) -> s7_pointer ---
	s7_string_length                   :: proc(str: s7_pointer) -> s7_int ---
	s7_is_character                    :: proc(p: s7_pointer) -> bool ---
	s7_character                       :: proc(p: s7_pointer) -> u8 ---
	s7_make_character                  :: proc(sc: ^s7_scheme, _c: u8) -> s7_pointer ---
	s7_is_number                       :: proc(p: s7_pointer) -> bool ---
	s7_is_integer                      :: proc(p: s7_pointer) -> bool ---
	s7_integer                         :: proc(p: s7_pointer) -> s7_int ---
	s7_make_integer                    :: proc(sc: ^s7_scheme, num: s7_int) -> s7_pointer ---
	s7_is_real                         :: proc(p: s7_pointer) -> bool ---
	s7_real                            :: proc(p: s7_pointer) -> s7_double ---
	s7_make_real                       :: proc(sc: ^s7_scheme, num: s7_double) -> s7_pointer ---
	s7_make_mutable_real               :: proc(sc: ^s7_scheme, n: s7_double) -> s7_pointer ---
	s7_number_to_real                  :: proc(sc: ^s7_scheme, x: s7_pointer) -> s7_double ---
	s7_number_to_real_with_caller      :: proc(sc: ^s7_scheme, x: s7_pointer, caller: cstring) -> s7_double ---
	s7_number_to_real_with_location    :: proc(sc: ^s7_scheme, x: s7_pointer, caller: s7_pointer) -> s7_double ---
	s7_number_to_integer               :: proc(sc: ^s7_scheme, x: s7_pointer) -> s7_int ---
	s7_number_to_integer_with_caller   :: proc(sc: ^s7_scheme, x: s7_pointer, caller: cstring) -> s7_int ---
	s7_is_rational                     :: proc(arg: s7_pointer) -> bool ---
	s7_is_ratio                        :: proc(arg: s7_pointer) -> bool ---
	s7_make_ratio                      :: proc(sc: ^s7_scheme, a: s7_int, b: s7_int) -> s7_pointer ---
	s7_rationalize                     :: proc(sc: ^s7_scheme, x: s7_double, error: s7_double) -> s7_pointer ---
	s7_numerator                       :: proc(x: s7_pointer) -> s7_int ---
	s7_denominator                     :: proc(x: s7_pointer) -> s7_int ---
	s7_random                          :: proc(sc: ^s7_scheme, state: s7_pointer) -> s7_double ---
	s7_random_state                    :: proc(sc: ^s7_scheme, seed: s7_pointer) -> s7_pointer ---
	s7_random_state_to_list            :: proc(sc: ^s7_scheme, args: s7_pointer) -> s7_pointer ---
	s7_set_default_random_state        :: proc(sc: ^s7_scheme, seed: s7_int, carry: s7_int) ---
	s7_is_random_state                 :: proc(p: s7_pointer) -> bool ---
	s7_is_complex                      :: proc(arg: s7_pointer) -> bool ---
	s7_make_complex                    :: proc(sc: ^s7_scheme, a: s7_double, b: s7_double) -> s7_pointer ---
	s7_real_part                       :: proc(z: s7_pointer) -> s7_double ---
	s7_imag_part                       :: proc(z: s7_pointer) -> s7_double ---
	s7_number_to_string                :: proc(sc: ^s7_scheme, obj: s7_pointer, radix: s7_int) -> cstring ---
	s7_is_vector                       :: proc(p: s7_pointer) -> bool ---
	s7_vector_length                   :: proc(vec: s7_pointer) -> s7_int ---
	s7_vector_rank                     :: proc(vect: s7_pointer) -> s7_int ---
	s7_vector_dimension                :: proc(vec: s7_pointer, dim: s7_int) -> s7_int ---
	s7_vector_elements                 :: proc(vec: s7_pointer) -> ^s7_pointer ---
	s7_int_vector_elements             :: proc(vec: s7_pointer) -> ^s7_int ---
	s7_byte_vector_elements            :: proc(vec: s7_pointer) -> ^u8 ---
	s7_float_vector_elements           :: proc(vec: s7_pointer) -> ^s7_double ---
	s7_is_float_vector                 :: proc(p: s7_pointer) -> bool ---
	s7_is_complex_vector               :: proc(p: s7_pointer) -> bool ---
	s7_is_int_vector                   :: proc(p: s7_pointer) -> bool ---
	s7_is_byte_vector                  :: proc(p: s7_pointer) -> bool ---
	s7_vector_ref                      :: proc(sc: ^s7_scheme, vec: s7_pointer, index: s7_int) -> s7_pointer ---
	s7_vector_set                      :: proc(sc: ^s7_scheme, vec: s7_pointer, index: s7_int, a: s7_pointer) -> s7_pointer ---
	s7_vector_ref_n                    :: proc(sc: ^s7_scheme, vector: s7_pointer, indices: s7_int) -> s7_pointer ---
	s7_vector_set_n                    :: proc(sc: ^s7_scheme, vector: s7_pointer, value: s7_pointer, indices: s7_int) -> s7_pointer ---
	s7_vector_dimensions               :: proc(vec: s7_pointer, dims: ^s7_int, dims_size: s7_int) -> s7_int ---
	s7_vector_offsets                  :: proc(vec: s7_pointer, offs: ^s7_int, offs_size: s7_int) -> s7_int ---
	s7_int_vector_ref                  :: proc(vec: s7_pointer, index: s7_int) -> s7_int ---
	s7_int_vector_set                  :: proc(vec: s7_pointer, index: s7_int, value: s7_int) -> s7_int ---
	s7_byte_vector_ref                 :: proc(vec: s7_pointer, index: s7_int) -> u8 ---
	s7_byte_vector_set                 :: proc(vec: s7_pointer, index: s7_int, value: u8) -> u8 ---
	s7_float_vector_ref                :: proc(vec: s7_pointer, index: s7_int) -> s7_double ---
	s7_float_vector_set                :: proc(vec: s7_pointer, index: s7_int, value: s7_double) -> s7_double ---
	s7_make_vector                     :: proc(sc: ^s7_scheme, len: s7_int) -> s7_pointer ---
	s7_make_normal_vector              :: proc(sc: ^s7_scheme, len: s7_int, dims: s7_int, dim_info: ^s7_int) -> s7_pointer ---
	s7_make_and_fill_vector            :: proc(sc: ^s7_scheme, len: s7_int, fill: s7_pointer) -> s7_pointer ---
	s7_make_int_vector                 :: proc(sc: ^s7_scheme, len: s7_int, dims: s7_int, dim_info: ^s7_int) -> s7_pointer ---
	s7_make_byte_vector                :: proc(sc: ^s7_scheme, len: s7_int, dims: s7_int, dim_info: ^s7_int) -> s7_pointer ---
	s7_make_float_vector               :: proc(sc: ^s7_scheme, len: s7_int, dims: s7_int, dim_info: ^s7_int) -> s7_pointer ---
	s7_make_float_vector_wrapper       :: proc(sc: ^s7_scheme, len: s7_int, data: ^s7_double, dims: s7_int, dim_info: ^s7_int, free_data: bool) -> s7_pointer ---
	s7_make_complex_vector             :: proc(sc: ^s7_scheme, len: s7_int, dims: s7_int, dim_info: ^s7_int) -> s7_pointer ---
	s7_make_complex_vector_wrapper     :: proc(sc: ^s7_scheme, len: s7_int, data: ^s7_complex, dims: s7_int, dim_info: ^s7_int, free_data: bool) -> s7_pointer ---
	s7_complex_vector_elements         :: proc(vec: s7_pointer) -> ^s7_complex ---
	s7_complex_vector_ref              :: proc(vec: s7_pointer, index: s7_int) -> s7_complex ---
	s7_complex_vector_set              :: proc(vec: s7_pointer, index: s7_int, value: s7_complex) -> s7_complex ---
	s7_vector_fill                     :: proc(sc: ^s7_scheme, vec: s7_pointer, obj: s7_pointer) ---
	s7_vector_copy                     :: proc(sc: ^s7_scheme, old_vect: s7_pointer) -> s7_pointer ---
	s7_vector_to_list                  :: proc(sc: ^s7_scheme, vect: s7_pointer) -> s7_pointer ---

	/*
	*  (vect i) is the same as (vector-ref vect i)
	*  (set! (vect i) x) is the same as (vector-set! vect i x)
	*  (vect i j k) accesses the 3-dimensional vect
	*  (set! (vect i j k) x) sets that element (vector-ref and vector-set! can also be used)
	*  (make-vector (list 2 3 4)) returns a 3-dimensional vector with the given dimension sizes
	*  (make-vector '(2 3) 1.0) returns a 2-dim vector with all elements set to 1.0
	*/
	s7_is_hash_table   :: proc(p: s7_pointer) -> bool ---
	s7_make_hash_table :: proc(sc: ^s7_scheme, size: s7_int) -> s7_pointer ---
	s7_hash_table_ref  :: proc(sc: ^s7_scheme, table: s7_pointer, key: s7_pointer) -> s7_pointer ---

	/* (hash-table-ref table key) */
	s7_hash_table_set :: proc(sc: ^s7_scheme, table: s7_pointer, key: s7_pointer, value: s7_pointer) -> s7_pointer ---

	/* (hash-table-set! table key value) */
	s7_hash_code               :: proc(sc: ^s7_scheme, obj: s7_pointer, eqfunc: s7_pointer) -> s7_int ---
	s7_hook_functions          :: proc(sc: ^s7_scheme, hook: s7_pointer) -> s7_pointer ---
	s7_hook_set_functions      :: proc(sc: ^s7_scheme, hook: s7_pointer, functions: s7_pointer) -> s7_pointer ---
	s7_is_input_port           :: proc(sc: ^s7_scheme, p: s7_pointer) -> bool ---
	s7_is_output_port          :: proc(sc: ^s7_scheme, p: s7_pointer) -> bool ---
	s7_port_filename           :: proc(sc: ^s7_scheme, x: s7_pointer) -> cstring ---
	s7_port_line_number        :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_int ---
	s7_current_input_port      :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_set_current_input_port  :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_current_output_port     :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_set_current_output_port :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_current_error_port      :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_set_current_error_port  :: proc(sc: ^s7_scheme, port: s7_pointer) -> s7_pointer ---
	s7_close_input_port        :: proc(sc: ^s7_scheme, p: s7_pointer) ---
	s7_close_output_port       :: proc(sc: ^s7_scheme, p: s7_pointer) ---
	s7_open_input_file         :: proc(sc: ^s7_scheme, name: cstring, mode: cstring) -> s7_pointer ---

	/* (open-input-file name mode) */
	s7_open_output_file :: proc(sc: ^s7_scheme, name: cstring, mode: cstring) -> s7_pointer ---

	/* (open-output-file name mode) */
	/* mode here is an optional C style flag, "a" for "alter", etc ("r" is the input default, "w" is the output default) */
	s7_open_input_string :: proc(sc: ^s7_scheme, input_string: cstring) -> s7_pointer ---

	/* (open-input-string str) */
	s7_open_output_string :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_get_output_string  :: proc(sc: ^s7_scheme, out_port: s7_pointer) -> cstring ---

	/*    don't free the string */
	s7_output_string        :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_flush_output_port    :: proc(sc: ^s7_scheme, p: s7_pointer) -> bool ---
	s7_open_output_function :: proc(sc: ^s7_scheme, function: proc "c" (^s7_scheme, u8, s7_pointer)) -> s7_pointer ---
	s7_open_input_function  :: proc(sc: ^s7_scheme, function: proc "c" (^s7_scheme, s7_read_t, s7_pointer) -> s7_pointer) -> s7_pointer ---
	s7_read_char            :: proc(sc: ^s7_scheme, port: s7_pointer) -> s7_pointer ---
	s7_peek_char            :: proc(sc: ^s7_scheme, port: s7_pointer) -> s7_pointer ---
	s7_read                 :: proc(sc: ^s7_scheme, port: s7_pointer) -> s7_pointer ---
	s7_newline              :: proc(sc: ^s7_scheme, port: s7_pointer) ---
	s7_write_char           :: proc(sc: ^s7_scheme, _c: s7_pointer, port: s7_pointer) -> s7_pointer ---
	s7_write                :: proc(sc: ^s7_scheme, obj: s7_pointer, port: s7_pointer) -> s7_pointer ---
	s7_display              :: proc(sc: ^s7_scheme, obj: s7_pointer, port: s7_pointer) -> s7_pointer ---
	s7_format               :: proc(sc: ^s7_scheme, args: s7_pointer) -> cstring ---
	s7_is_syntax            :: proc(p: s7_pointer) -> bool ---
	s7_is_symbol            :: proc(p: s7_pointer) -> bool ---
	s7_symbol_name          :: proc(p: s7_pointer) -> cstring ---
	s7_make_symbol          :: proc(sc: ^s7_scheme, name: cstring) -> s7_pointer ---
	s7_gensym               :: proc(sc: ^s7_scheme, prefix: cstring) -> s7_pointer ---
	s7_is_keyword           :: proc(obj: s7_pointer) -> bool ---
	s7_make_keyword         :: proc(sc: ^s7_scheme, key: cstring) -> s7_pointer ---
	s7_keyword_to_symbol    :: proc(sc: ^s7_scheme, key: s7_pointer) -> s7_pointer ---
	s7_rootlet              :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_shadow_rootlet       :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_set_shadow_rootlet   :: proc(sc: ^s7_scheme, let: s7_pointer) -> s7_pointer ---
	s7_curlet               :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_set_curlet           :: proc(sc: ^s7_scheme, e: s7_pointer) -> s7_pointer ---
	s7_outlet               :: proc(sc: ^s7_scheme, e: s7_pointer) -> s7_pointer ---
	s7_sublet               :: proc(sc: ^s7_scheme, env: s7_pointer, bindings: s7_pointer) -> s7_pointer ---
	s7_inlet                :: proc(sc: ^s7_scheme, bindings: s7_pointer) -> s7_pointer ---
	s7_varlet               :: proc(sc: ^s7_scheme, env: s7_pointer, symbol: s7_pointer, value: s7_pointer) -> s7_pointer ---
	s7_let_to_list          :: proc(sc: ^s7_scheme, env: s7_pointer) -> s7_pointer ---
	s7_is_let               :: proc(e: s7_pointer) -> bool ---
	s7_let_ref              :: proc(sc: ^s7_scheme, env: s7_pointer, sym: s7_pointer) -> s7_pointer ---
	s7_let_set              :: proc(sc: ^s7_scheme, env: s7_pointer, sym: s7_pointer, val: s7_pointer) -> s7_pointer ---
	s7_openlet              :: proc(sc: ^s7_scheme, e: s7_pointer) -> s7_pointer ---
	s7_is_openlet           :: proc(e: s7_pointer) -> bool ---
	s7_method               :: proc(sc: ^s7_scheme, obj: s7_pointer, method: s7_pointer) -> s7_pointer ---

	/* *s7* */
	/* these renamed because "s7_let_field" seems the same as "s7_let", but here we're referring to *s7*, not any let */
	s7_let_field_ref :: proc(sc: ^s7_scheme, sym: s7_pointer) -> s7_pointer ---
	s7_let_field_set :: proc(sc: ^s7_scheme, sym: s7_pointer, new_value: s7_pointer) -> s7_pointer ---

	/* new names */
	s7_starlet_ref              :: proc(sc: ^s7_scheme, sym: s7_pointer) -> s7_pointer ---
	s7_starlet_set              :: proc(sc: ^s7_scheme, sym: s7_pointer, new_value: s7_pointer) -> s7_pointer ---
	s7_name_to_value            :: proc(sc: ^s7_scheme, name: cstring) -> s7_pointer ---
	s7_symbol_table_find_name   :: proc(sc: ^s7_scheme, name: cstring) -> s7_pointer ---
	s7_symbol_value             :: proc(sc: ^s7_scheme, sym: s7_pointer) -> s7_pointer ---
	s7_symbol_set_value         :: proc(sc: ^s7_scheme, sym: s7_pointer, val: s7_pointer) -> s7_pointer ---
	s7_symbol_local_value       :: proc(sc: ^s7_scheme, sym: s7_pointer, local_env: s7_pointer) -> s7_pointer ---
	s7_symbol_initial_value     :: proc(symbol: s7_pointer) -> s7_pointer ---
	s7_symbol_set_initial_value :: proc(sc: ^s7_scheme, symbol: s7_pointer, value: s7_pointer) -> s7_pointer ---
	s7_for_each_symbol_name     :: proc(sc: ^s7_scheme, symbol_func: proc "c" (cstring, rawptr) -> bool, data: rawptr) -> bool ---
	s7_for_each_symbol          :: proc(sc: ^s7_scheme, symbol_func: proc "c" (cstring, rawptr) -> bool, data: rawptr) -> bool ---

	/* these access the current environment and symbol table, providing
	*   a symbol's current binding (s7_name_to_value takes the symbol name as a char*,
	*   s7_symbol_value takes the symbol itself, s7_symbol_set_value changes the
	*   current binding, and s7_symbol_local_value uses the environment passed
	*   as its third argument).
	*
	* To iterate over the complete symbol table, use s7_for_each_symbol_name,
	*   and s7_for_each_symbol.  Both call 'symbol_func' on each symbol, passing it
	*   the symbol or symbol name, and the uninterpreted 'data' pointer.
	*   the current binding. The for-each loop stops if the symbol_func returns true,
	*   or at the end of the table.
	*/
	s7_dynamic_wind                       :: proc(sc: ^s7_scheme, init: s7_pointer, body: s7_pointer, finish: s7_pointer) -> s7_pointer ---
	s7_is_immutable                       :: proc(p: s7_pointer) -> bool ---
	s7_set_immutable                      :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_immutable                          :: proc(p: s7_pointer) -> s7_pointer ---
	s7_define                             :: proc(sc: ^s7_scheme, env: s7_pointer, symbol: s7_pointer, value: s7_pointer) ---
	s7_is_defined                         :: proc(sc: ^s7_scheme, name: cstring) -> bool ---
	s7_define_variable                    :: proc(sc: ^s7_scheme, name: cstring, value: s7_pointer) -> s7_pointer ---
	s7_define_variable_with_documentation :: proc(sc: ^s7_scheme, name: cstring, value: s7_pointer, help: cstring) -> s7_pointer ---
	s7_define_constant                    :: proc(sc: ^s7_scheme, name: cstring, value: s7_pointer) -> s7_pointer ---
	s7_define_constant_with_documentation :: proc(sc: ^s7_scheme, name: cstring, value: s7_pointer, help: cstring) -> s7_pointer ---
	s7_define_constant_with_environment   :: proc(sc: ^s7_scheme, envir: s7_pointer, name: cstring, value: s7_pointer) -> s7_pointer ---

	/* These functions add a symbol and its binding to either the top-level environment
	*    or the 'env' passed as the second argument to s7_define.  Except for s7_define, they return
	*    the name as a symbol.
	*
	*    s7_define_variable(sc, "*features*", s7_nil(sc));
	*
	* in s7.c is equivalent to the top level form
	*
	*    (define *features* ())
	*
	* s7_define_variable is simply s7_define with string->symbol and the global environment.
	* s7_define_constant is s7_define but makes its "definee" immutable.
	* s7_define is equivalent to define in Scheme, except that it does not return the value.
	*/
	s7_is_function             :: proc(p: s7_pointer) -> bool ---
	s7_is_procedure            :: proc(x: s7_pointer) -> bool ---
	s7_is_macro                :: proc(sc: ^s7_scheme, x: s7_pointer) -> bool ---
	s7_closure_body            :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_closure_let             :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_closure_args            :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_funclet                 :: proc(sc: ^s7_scheme, p: s7_pointer) -> s7_pointer ---
	s7_is_aritable             :: proc(sc: ^s7_scheme, x: s7_pointer, args: s7_int) -> bool ---
	s7_arity                   :: proc(sc: ^s7_scheme, x: s7_pointer) -> s7_pointer ---
	s7_help                    :: proc(sc: ^s7_scheme, obj: s7_pointer) -> cstring ---
	s7_make_continuation       :: proc(sc: ^s7_scheme) -> s7_pointer ---
	s7_function_let            :: proc(sc: ^s7_scheme, obj: s7_pointer) -> s7_pointer ---
	s7_documentation           :: proc(sc: ^s7_scheme, p: s7_pointer) -> cstring ---
	s7_set_documentation       :: proc(sc: ^s7_scheme, p: s7_pointer, new_doc: cstring) -> cstring ---
	s7_setter                  :: proc(sc: ^s7_scheme, obj: s7_pointer) -> s7_pointer ---
	s7_set_setter              :: proc(sc: ^s7_scheme, p: s7_pointer, setter: s7_pointer) -> s7_pointer ---
	s7_signature               :: proc(sc: ^s7_scheme, func: s7_pointer) -> s7_pointer ---
	s7_make_signature          :: proc(sc: ^s7_scheme, len: s7_int) -> s7_pointer ---
	s7_make_circular_signature :: proc(sc: ^s7_scheme, cycle_point: s7_int, len: s7_int) -> s7_pointer ---

	/* possibly unsafe functions: */
	s7_make_function :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring) -> s7_pointer ---

	/* safe functions: */
	s7_make_safe_function                   :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring) -> s7_pointer ---
	s7_make_typed_function                  :: proc(sc: ^s7_scheme, name: cstring, f: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring, signature: s7_pointer) -> s7_pointer ---
	s7_make_typed_function_with_environment :: proc(sc: ^s7_scheme, name: cstring, f: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring, signature: s7_pointer, let: s7_pointer) -> s7_pointer ---

	/* arglist or body possibly unsafe: */
	s7_define_function :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring) -> s7_pointer ---

	/* arglist and body safe: */
	s7_define_safe_function  :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring) -> s7_pointer ---
	s7_define_typed_function :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring, signature: s7_pointer) -> s7_pointer ---

	/* arglist unsafe or body unsafe: */
	s7_define_unsafe_typed_function :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring, signature: s7_pointer) -> s7_pointer ---

	/* arglist safe, body possibly unsafe: */
	s7_define_semisafe_typed_function :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring, signature: s7_pointer) -> s7_pointer ---
	s7_make_function_star             :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, arglist: cstring, doc: cstring) -> s7_pointer ---
	s7_make_safe_function_star        :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, arglist: cstring, doc: cstring) -> s7_pointer ---
	s7_define_function_star           :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, arglist: cstring, doc: cstring) ---
	s7_define_safe_function_star      :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, arglist: cstring, doc: cstring) ---
	s7_define_typed_function_star     :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, arglist: cstring, doc: cstring, signature: s7_pointer) ---
	s7_define_macro                   :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring) -> s7_pointer ---
	s7_define_expansion               :: proc(sc: ^s7_scheme, name: cstring, fnc: s7_function, required_args: s7_int, optional_args: s7_int, rest_arg: bool, doc: cstring) -> s7_pointer ---

	/* In s7, (define* (name . args) body) or (define name (lambda* args body))
	*   define a function that takes optional (keyword) named arguments.
	*   The "args" is a list that can contain either names (normal arguments),
	*   or lists of the form (name default-value), in any order.  When called,
	*   the names are bound to their default values (or #f), then the function's
	*   current arglist is scanned.  Any name that occurs as a keyword (":name")
	*   precedes that argument's new value.  Otherwise, as values occur, they
	*   are plugged into the environment based on their position in the arglist
	*   (as normal for a function).  So,
	*
	*   (define* (hi a (b 32) (c "hi")) (list a b c))
	*     (hi 1) -> '(1 32 "hi")
	*     (hi :b 2 :a 3) -> '(3 2 "hi")
	*     (hi 3 2 1) -> '(3 2 1)
	*
	*   :rest causes its argument to be bound to the rest of the arguments at that point.
	*
	* The C connection to this takes the function name, the C function to call, the argument
	*   list as written in Scheme, and the documentation string.  s7 makes sure the arguments
	*   are ordered correctly and have the specified defaults before calling the C function.
	*     s7_define_function_star(sc, "a-func", a_func, "arg1 (arg2 32)", "an example of C define*");
	*   Now (a-func :arg1 2) calls the C function a_func(2, 32). See the example program in s7.html.
	*
	* In s7 Scheme, define* can be used just for its optional arguments feature, but that is
	*   included in s7_define_function.  s7_define_function_star implements keyword arguments
	*   for C-level functions (as well as optional/rest arguments).
	*/
	s7_apply_function      :: proc(sc: ^s7_scheme, fnc: s7_pointer, args: s7_pointer) -> s7_pointer ---
	s7_apply_function_star :: proc(sc: ^s7_scheme, fnc: s7_pointer, args: s7_pointer) -> s7_pointer ---
	s7_call                :: proc(sc: ^s7_scheme, func: s7_pointer, args: s7_pointer) -> s7_pointer ---
	s7_call_with_location  :: proc(sc: ^s7_scheme, func: s7_pointer, args: s7_pointer, caller: cstring, file: cstring, line: s7_int) -> s7_pointer ---
	s7_call_with_catch     :: proc(sc: ^s7_scheme, tag: s7_pointer, body: s7_pointer, error_handler: s7_pointer) -> s7_pointer ---

	/* s7_call takes a Scheme function and applies it to 'args' (a list of arguments) returning the result.
	*   s7_pointer kar;
	*   kar = s7_make_function(sc, "car", g_car, 1, 0, false, "(car obj)");
	*   s7_integer(s7_call(sc, kar, s7_cons(sc, s7_cons(sc, s7_make_integer(sc, 123), s7_nil(sc)), s7_nil(sc))));
	*   returns 123.
	*
	* s7_call_with_location passes some information to the error handler.
	* s7_call makes sure some sort of catch exists if an error occurs during the call, but
	*   s7_apply_function does not -- it assumes the catch has been set up already.
	* s7_call_with_catch wraps an explicit catch around a function call ("body" above);
	*   s7_call_with_catch(sc, tag, body, err) is equivalent to (catch tag body err).
	*/
	s7_is_dilambda               :: proc(obj: s7_pointer) -> bool ---
	s7_dilambda                  :: proc(sc: ^s7_scheme, name: cstring, getter: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer, get_req_args: s7_int, get_opt_args: s7_int, setter: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer, set_req_args: s7_int, set_opt_args: s7_int, documentation: cstring) -> s7_pointer ---
	s7_typed_dilambda            :: proc(sc: ^s7_scheme, name: cstring, getter: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer, get_req_args: s7_int, get_opt_args: s7_int, setter: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer, set_req_args: s7_int, set_opt_args: s7_int, documentation: cstring, get_sig: s7_pointer, set_sig: s7_pointer) -> s7_pointer ---
	s7_dilambda_with_environment :: proc(sc: ^s7_scheme, envir: s7_pointer, name: cstring, getter: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer, get_req_args: s7_int, get_opt_args: s7_int, setter: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer, set_req_args: s7_int, set_opt_args: s7_int, documentation: cstring) -> s7_pointer ---
	s7_values                    :: proc(sc: ^s7_scheme, args: s7_pointer) -> s7_pointer ---
	s7_is_multiple_value         :: proc(obj: s7_pointer) -> bool ---
	s7_make_iterator             :: proc(sc: ^s7_scheme, e: s7_pointer) -> s7_pointer ---
	s7_is_iterator               :: proc(obj: s7_pointer) -> bool ---
	s7_iterator_is_at_end        :: proc(sc: ^s7_scheme, obj: s7_pointer) -> bool ---
	s7_iterate                   :: proc(sc: ^s7_scheme, iter: s7_pointer) -> s7_pointer ---
	s7_copy                      :: proc(sc: ^s7_scheme, args: s7_pointer) -> s7_pointer ---
	s7_fill                      :: proc(sc: ^s7_scheme, args: s7_pointer) -> s7_pointer ---
	s7_type_of                   :: proc(sc: ^s7_scheme, arg: s7_pointer) -> s7_pointer ---

	/* -------------------------------------------------------------------------------- */
	/* c types/objects */
	s7_mark                     :: proc(p: s7_pointer) ---
	s7_is_c_object              :: proc(p: s7_pointer) -> bool ---
	s7_c_object_type            :: proc(obj: s7_pointer) -> s7_int ---
	s7_c_object_value           :: proc(obj: s7_pointer) -> rawptr ---
	s7_c_object_value_checked   :: proc(obj: s7_pointer, type: s7_int) -> rawptr ---
	s7_make_c_object            :: proc(sc: ^s7_scheme, type: s7_int, value: rawptr) -> s7_pointer ---
	s7_make_c_object_with_let   :: proc(sc: ^s7_scheme, type: s7_int, value: rawptr, let: s7_pointer) -> s7_pointer ---
	s7_make_c_object_without_gc :: proc(sc: ^s7_scheme, type: s7_int, value: rawptr) -> s7_pointer ---
	s7_c_object_let             :: proc(obj: s7_pointer) -> s7_pointer ---
	s7_c_object_set_let         :: proc(sc: ^s7_scheme, obj: s7_pointer, e: s7_pointer) -> s7_pointer ---

	/* the "let" in s7_make_c_object_with_let and s7_c_object_set_let needs to be GC protected by marking it in the c_object's mark function */
	s7_make_c_type :: proc(sc: ^s7_scheme, name: cstring) -> s7_int ---

	/* old style free/mark/equal */
	s7_c_type_set_free  :: proc(sc: ^s7_scheme, tag: s7_int, gc_free: proc "c" (rawptr)) ---
	s7_c_type_set_mark  :: proc(sc: ^s7_scheme, tag: s7_int, mark: proc "c" (rawptr)) ---
	s7_c_type_set_equal :: proc(sc: ^s7_scheme, tag: s7_int, equal: proc "c" (rawptr, rawptr) -> bool) ---

	/* new style free/mark/equal and equivalent */
	s7_c_type_set_gc_free       :: proc(sc: ^s7_scheme, tag: s7_int, gc_free: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_gc_mark       :: proc(sc: ^s7_scheme, tag: s7_int, mark: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_is_equal      :: proc(sc: ^s7_scheme, tag: s7_int, is_equal: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_is_equivalent :: proc(sc: ^s7_scheme, tag: s7_int, is_equivalent: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_ref           :: proc(sc: ^s7_scheme, tag: s7_int, ref: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_set           :: proc(sc: ^s7_scheme, tag: s7_int, set: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_length        :: proc(sc: ^s7_scheme, tag: s7_int, length: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_copy          :: proc(sc: ^s7_scheme, tag: s7_int, copy: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_fill          :: proc(sc: ^s7_scheme, tag: s7_int, fill: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_reverse       :: proc(sc: ^s7_scheme, tag: s7_int, reverse: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_to_list       :: proc(sc: ^s7_scheme, tag: s7_int, to_list: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_to_string     :: proc(sc: ^s7_scheme, tag: s7_int, to_string: proc "c" (^s7_scheme, s7_pointer) -> s7_pointer) ---
	s7_c_type_set_getter        :: proc(sc: ^s7_scheme, tag: s7_int, getter: s7_pointer) ---
	s7_c_type_set_setter        :: proc(sc: ^s7_scheme, tag: s7_int, setter: s7_pointer) ---

	/* -------------------------------------------------------------------------------- */
	/* the new clm optimizer!  this time for sure!
	*    d=double, i=integer, v=c_object, p=s7_pointer
	*    first return type, then arg types, d_vd -> returns double takes c_object and double (i.e. a standard clm generator)
	*
	* It is possible to tell s7 to call a foreign function directly, without any scheme-related
	*   overhead.  The call needs to take the form of one of the s7_*_t functions in s7.h.  For example,
	*   one way to call + is to pass it two s7_double arguments and get an s7_double back.  This is the
	*   s7_d_dd_t function (the first letter gives the return type, the rest give successive argument types).
	*   We tell s7 about it via s7_set_d_dd_function.  Whenever s7's optimizer encounters + with two arguments
	*   that it (the optimizer) knows are s7_doubles, in a context where an s7_double result is expected,
	*   s7 calls the s7_d_dd_t function directly without consing a list of arguments, and without
	*   wrapping up the result as a scheme cell.
	*/
	s7_optimize            :: proc(sc: ^s7_scheme, expr: s7_pointer) -> s7_pfunc ---
	s7_float_optimize      :: proc(sc: ^s7_scheme, expr: s7_pointer) -> s7_float_function ---
	s7_set_d_function      :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_t) ---
	s7_d_function          :: proc(f: s7_pointer) -> s7_d_t ---
	s7_set_d_d_function    :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_d_t) ---
	s7_d_d_function        :: proc(f: s7_pointer) -> s7_d_d_t ---
	s7_set_d_dd_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_dd_t) ---
	s7_d_dd_function       :: proc(f: s7_pointer) -> s7_d_dd_t ---
	s7_set_d_ddd_function  :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_ddd_t) ---
	s7_d_ddd_function      :: proc(f: s7_pointer) -> s7_d_ddd_t ---
	s7_set_d_dddd_function :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_dddd_t) ---
	s7_d_dddd_function     :: proc(f: s7_pointer) -> s7_d_dddd_t ---
	s7_set_d_v_function    :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_v_t) ---
	s7_d_v_function        :: proc(f: s7_pointer) -> s7_d_v_t ---
	s7_set_d_vd_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_vd_t) ---
	s7_d_vd_function       :: proc(f: s7_pointer) -> s7_d_vd_t ---
	s7_set_d_vdd_function  :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_vdd_t) ---
	s7_d_vdd_function      :: proc(f: s7_pointer) -> s7_d_vdd_t ---
	s7_set_d_vid_function  :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_vid_t) ---
	s7_d_vid_function      :: proc(f: s7_pointer) -> s7_d_vid_t ---
	s7_set_d_p_function    :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_p_t) ---
	s7_d_p_function        :: proc(f: s7_pointer) -> s7_d_p_t ---
	s7_set_d_pd_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_pd_t) ---
	s7_d_pd_function       :: proc(f: s7_pointer) -> s7_d_pd_t ---
	s7_set_d_7pi_function  :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_7pi_t) ---
	s7_d_7pi_function      :: proc(f: s7_pointer) -> s7_d_7pi_t ---
	s7_set_d_7pid_function :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_7pid_t) ---
	s7_d_7pid_function     :: proc(f: s7_pointer) -> s7_d_7pid_t ---
	s7_set_d_id_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_id_t) ---
	s7_d_id_function       :: proc(f: s7_pointer) -> s7_d_id_t ---
	s7_set_d_ip_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_d_ip_t) ---
	s7_d_ip_function       :: proc(f: s7_pointer) -> s7_d_ip_t ---
	s7_set_i_i_function    :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_i_i_t) ---
	s7_i_i_function        :: proc(f: s7_pointer) -> s7_i_i_t ---
	s7_set_i_7d_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_i_7d_t) ---
	s7_i_7d_function       :: proc(f: s7_pointer) -> s7_i_7d_t ---
	s7_set_i_ii_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_i_ii_t) ---
	s7_i_ii_function       :: proc(f: s7_pointer) -> s7_i_ii_t ---
	s7_set_i_7p_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_i_7p_t) ---
	s7_i_7p_function       :: proc(f: s7_pointer) -> s7_i_7p_t ---
	s7_set_b_p_function    :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_b_p_t) ---
	s7_b_p_function        :: proc(f: s7_pointer) -> s7_b_p_t ---
	s7_set_p_d_function    :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_p_d_t) ---
	s7_p_d_function        :: proc(f: s7_pointer) -> s7_p_d_t ---
	s7_set_p_p_function    :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_p_p_t) ---
	s7_p_p_function        :: proc(f: s7_pointer) -> s7_p_p_t ---
	s7_set_p_pp_function   :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_p_pp_t) ---
	s7_p_pp_function       :: proc(f: s7_pointer) -> s7_p_pp_t ---
	s7_set_p_ppp_function  :: proc(sc: ^s7_scheme, f: s7_pointer, df: s7_p_ppp_t) ---
	s7_p_ppp_function      :: proc(f: s7_pointer) -> s7_p_ppp_t ---

	/* maybe remove these? */
	s7_slot                :: proc(sc: ^s7_scheme, symbol: s7_pointer) -> s7_pointer ---
	s7_slot_value          :: proc(slot: s7_pointer) -> s7_pointer ---
	s7_slot_set_value      :: proc(sc: ^s7_scheme, slot: s7_pointer, value: s7_pointer) -> s7_pointer ---
	s7_make_slot           :: proc(sc: ^s7_scheme, env: s7_pointer, symbol: s7_pointer, value: s7_pointer) -> s7_pointer ---
	s7_slot_set_real_value :: proc(sc: ^s7_scheme, slot: s7_pointer, value: s7_double) ---
	s7_is_bignum           :: proc(obj: s7_pointer) -> bool ---
}
