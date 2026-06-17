S7 Bindings for Odin

Example
```Odin
package main

import s7 "s7"
import rl "vendor:raylib"
import "core:fmt"
import "core:c"
import "core:os"
import "core:strings"
// Foreign import for the C library


draw_text :: proc "c" (sc : ^s7.s7_scheme,  args : s7.s7_pointer) -> s7.s7_pointer
{
    /* This function expects: (draw-text "text" x y font-size color) */
    arg1 := s7.s7_car(args)
    arg2 := s7.s7_cadr(args)     // x position
    arg3 := s7.s7_caddr(args)   // y position
    arg4 := s7.s7_cadddr(args)    // font size
    
    if (!s7.s7_is_string(arg1)){
        return s7.s7_wrong_type_arg_error(sc,"draw-text", 1 ,arg1, "No text")
    }
    if (!s7.s7_is_integer(arg2)){ 
        return s7.s7_wrong_type_arg_error(sc,"draw-text", 1 ,arg1, "No int")}

    if (!s7.s7_is_integer(arg3)){ 
        return s7.s7_wrong_type_arg_error(sc,"draw-text", 1 ,arg1, "No int")}
     
    if (!s7.s7_is_integer(arg4)){ 
        return s7.s7_wrong_type_arg_error(sc,"draw-text", 1 ,arg1, "No int")}

    
    text := s7.s7_string(arg1)
    x := i32(s7.s7_integer(arg2))
    y := i32(s7.s7_integer(arg3))
    fontSize := i32(s7.s7_integer(arg4))
    
    // Draw the text using raylib
    rl.DrawText(text, x, y, fontSize, rl.BLACK);
    
    return(s7.s7_make_integer(sc, 0));  // return 0 for success
}



add1 :: proc "c" (sc : ^s7.s7_scheme,  args : s7.s7_pointer) -> s7.s7_pointer
{
  // Example add1
  if (s7.s7_is_integer(s7.s7_car(args))) {
    return(s7.s7_make_integer(sc, 1 + s7.s7_integer(s7.s7_car(args))))
  }
  return(s7.s7_wrong_type_arg_error(sc, "add1", 1,s7.s7_car(args), "an integer"))
}

vals :: proc "c" (s: ^s7.s7_scheme, args: s7.s7_pointer) -> s7.s7_pointer {
    return s7.s7_values(s, args)
}


main :: proc() {

    // Show window in Raylib
    s7_ := s7.s7_init()
    
  
    rl.InitWindow(600,400,"Window")
    defer rl.CloseWindow()
    // draw-text is defined in Oding
    s7.s7_define_function(s7_, "draw-text", draw_text, 4, 0, false, 
                       "(draw-text text x y font-size) draws text at position")
    // called in game.scm
    /* 
    ;; game.scm
    ;; Simple function to draw hello world
    (define (hello-world)
    (draw-text "Hello World!" 100 100 40))
    */
    result := s7.s7_load(s7_, "game.scm");
		if (s7.s7_is_null(s7_,result)) {
			fmt.println("Error loading Scheme file: %s\n", s7.s7_string(result));
		}
    for !rl.WindowShouldClose(){
        rl.BeginDrawing()
        rl.ClearBackground(rl.RAYWHITE)
        s7.s7_eval_c_string(s7_,"(hello-world)")
        rl.EndDrawing()
    }
    
  
    /*
    Example from S7 Website
       // Define the vals function
    // s7_define_function(s7_, "vals", vals, 0, 0, true, nil)
    
    
    result := s7.s7_eval_c_string(s7_, "(* 13 42)")
    s7.s7_display(s7_, result, s7.s7_current_output_port(s7_))
    s7.s7_newline(s7_, s7.s7_current_output_port(s7_))

    s7.s7_define_function(s7_, "add1", add1, 1, 0, false, "(add1 int) adds 1 to int")
    s7.s7_define_variable(s7_, "my-pi", s7.s7_make_real(s7_, 3.14159265))

    result2 :=s7.s7_eval_c_string(s7_, "(* my-pi (* 5 (add1 1)))")
    s7.s7_display(s7_, result2, s7.s7_current_output_port(s7_))
    s7.s7_newline(s7_, s7.s7_current_output_port(s7_))
  repl
	str : string
	new_str : cstring
	defer delete(new_str)
	resp : s7_pointer
	for {
		buf: [256]byte
		fmt.print(">: ")
		n, err := os.read(os.stdin, buf[:])
		if err != nil {
			fmt.eprintln("Error reading: ", err)
			break
		}
		str = strings.trim_space(string(buf[:n]))
		new_str = strings.clone_to_cstring(str)

		resp = s7_eval_c_string(s7_, new_str)
		s7_display(s7_,resp,s7_current_output_port(s7_))
		s7_newline(s7_, s7_current_output_port(s7_))
	}
    
  */
   s7.s7_free(s7_)
}
```
