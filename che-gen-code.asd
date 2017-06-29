
;; Copyright © 2014-2015 Andrew Arvid Peterson <andy.arvid@gmail.com>
;; see LICENSE.txt (BSD-2 License)

;;;; che-gen-code.asd

(asdf:defsystem "che-gen-code"
  :serial t
  :description "Generates test file for comp-heap-exhaust"
  :author "Andy Peterson <andy.arvid@gmail.com>"
  :license "BSD-2"
  :components ((:file "gen-code")))
