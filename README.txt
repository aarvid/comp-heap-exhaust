Test code to show problem with dynamic memory, macros, and compile.

I have found a situation where compiling exhausts memory but loading does not.

I originally found this using with deftest of https://github.com/fukamachi/prove

I created a test project called prove-fail https://github.com/aarvid/prove-fail
to demonstrate the error.

This projects eliminates prove as a dependency but still demonstrates the problem.

The code emulates what prove does.


To generate the test code (deftests.lisp):
(ql:quickload :che-gen-code)
(che-gen-code::gen-test-file)


To exhaust dynamic memory do either of the three below:


(ql:quickload :comp-heap-exhaust :verbose t)

or

(asdf:load-system :comp-heap-exhaust :verbose t)

or

(ql:quickload :alexandria)
(load "package.lisp")
(load "macros.lisp")
(compile-file "deftests.lisp" :verbose t)


To "load" the file do the following:
(ql:quickload :alexandria)
(load "package.lisp")
(load "macros.lisp")
(load "deftests.lisp" :verbose t)

"Load" should work fine.
