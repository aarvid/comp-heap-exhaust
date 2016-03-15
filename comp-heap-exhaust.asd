
;; Copyright © 2014-2015 Andrew Arvid Peterson <andy.arvid@gmail.com>
;; see LICENSE.txt (BSD-2 License)

;;;; comp-heap-exhaust.asd

(asdf:defsystem #:comp-heap-exhaust
  :serial t
  :description "Demonstrates bug in compile of SBCL"
  :author "Andy Peterson <andy.arvid@gmail.com>"
  :license "BSD-2"
  :depends-on (:alexandria)
  :components ((:file "package")
               (:file "macros")
               (:file "deftests")))
