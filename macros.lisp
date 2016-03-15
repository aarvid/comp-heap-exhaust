(in-package :comp-heap-exhaust)


(defun parse-description-and-test (args)
  (if (consp args)
      (case (length args)
        (1 (car args))
        (2 (if (eq :test (car args))
               (values nil (cadr args))
               (car args)))
        (t (let ((k (member :test args)))
             (case (length k)
               ((0 1) (car args))
               (2 (values (car args) (cadr k)))
               (t (values (nth 2 k) (cadr k)))))))
      args))

(defmacro with-duration (((duration result) form) &body body)
  (with-gensyms (start end)
    `(let* ((,start (get-internal-real-time))
            (,result ,form)
            (,end (get-internal-real-time))
            (,duration (- ,end ,start)))
       ,@body)))


(defmacro with-catching-errors ((&key description expected) &body body)
  (with-gensyms (e)
    `(handler-case (progn ,@body)
      (error (,e)
        (format t "error: ~s test: ~s expected: ~s" ,e ,description ,expected)))))


(defun test (got expected args
             &key duration)
  "shell function"
  (multiple-value-bind (desc arg-test)
      (parse-description-and-test args)
    (print got)
    (print expected)
    (print desc)
    (print arg-test)
    (print duration)))

(defmacro is (got expected &rest args)
  (with-gensyms (duration result new-args desc)
    (once-only (expected)
      `(let* ((,new-args (list ,@args))
              (,desc (parse-description-and-test ,new-args)))
         (with-catching-errors (:description ,desc :expected ,expected)
           (with-duration ((,duration ,result) ,got)
             (test ,result ,expected ,new-args
                   :duration ,duration)))))))


(defun %subtest (desc body-fn)
  "shell function"
  (print desc)
  (funcall body-fn))

(defmacro subtest (desc &body body)
  `(%subtest ,desc (lambda () ,@body)))

(defvar *package-tests* (make-hash-table))

(defmacro deftest (name &body test-forms)
  (let ((tests (gensym "TESTS"))
        (test (gensym "TEST"))
        (test-fn (gensym "TEST-FN")))
    `(progn
       (unless (nth-value 1 (gethash *package* *package-tests*))
         (setf (gethash *package* *package-tests*) '()))
       (let* ((,tests (gethash *package* *package-tests*))
              (,test (assoc ',name ,tests :test #'string=))
              (,test-fn (lambda ()
                          (subtest (princ-to-string ',name)
                            ,@test-forms))))
         (if ,test
             (rplacd ,test ,test-fn)
             (push (cons ',name ,test-fn) (gethash *package* *package-tests*)))
         ',name))))



(defmacro deftest-wrap (name &body test-forms)
  (prog1 `(deftest ,name ,@test-forms)
    ;(print (sb-kernel::dynamic-usage))
    (room)))
