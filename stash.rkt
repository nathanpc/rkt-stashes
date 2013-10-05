#lang racket

;; stash.rkt
;; A simple application to keep track of your bookmarks, notes, etc.
;;
;; @author Nathan Campos <nathanpc@dreamintech.net>

(require racket/file)

(define open-file
  (lambda (filename)
	(define file (file->string filename
							   #:mode 'text))
	file))

(define file-contents (open-file "/home/nathanpc/Stashes/FM Stuff.stash"))
(display file-contents)