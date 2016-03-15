(in-package :cl-user)

(defpackage che-gen-code
  (:use :cl))




(in-package :che-gen-code)

(defparameter *test-file*
  (merge-pathnames (make-pathname :name "deftests" :type "lisp")
                   (asdf:system-source-directory :comp-heap-exhaust)))
(defun test (stream n)
  (format stream
          "(deftest-wrap test-~D~%  (is (1+ ~D) ~D))~%"
          n n (1+ n)))

(defun gen-test-file (&optional (number-of-tests 2000))
  (with-open-file (out *test-file*
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (format out "(in-package :comp-heap-exhaust)~%~%")
    (dotimes (i number-of-tests number-of-tests)
      (test out i))))
  
