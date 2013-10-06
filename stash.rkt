#lang racket

;; stash.rkt
;; A simple application to keep track of your bookmarks, notes, etc.
;;
;; @author Nathan Campos <nathanpc@dreamintech.net>

(require racket/file)

(define open-file
  (lambda (filename)
	(define file "")

	; Check if the file exists.
	(cond
	 [(file-exists? filename) ; File exists.
	  ; Read the contents of the file and return them.
	  (set! file (file->string filename
								 #:mode 'text))]
	 [else ; File could not be found.
	  ((printf "File \"~a\" doesn't exist~n" filename)
	   (exit))])

	file))

(define file-contents (open-file "/home/nathanpc/Stashes/FM Stuff.stash"))
(displayln file-contents)