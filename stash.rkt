#lang racket

;; stash.rkt
;; A simple application to keep track of your bookmarks, notes, etc.
;;
;; @author Nathan Campos <nathanpc@dreamintech.net>

(require racket/file)

; Open stash.
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

; Get the title and description of the stash.
(define get-headers
  (lambda (file-contents)
	; Parse headers.
	(define raw-header (list-ref
						(regexp-match #px"(?-s:^.+(\n)+.+)" file-contents)
						0))
	(define headers (string-split raw-header #px"\n+"))

	; Remove the crap from the title.
	(define title (list-ref
				   (regexp-match #px"^[=]+ (.+) [=]+$" (list-ref headers 0))
				   1))

	; Create the return list.
	(hash 'title title
		  'description (list-ref headers 1))))

; Get the items in the stash.
(define get-items
  (lambda (file-contents)
	; Parse the items and clean the raw regexp match list.
	(define items (filter (lambda (item)
							(not (equal? item "")))
						  (list-tail (string-split file-contents #px"\n---\n") 1)))

	; Parse each item and update the list.
	(set! items
		  (map (lambda (body)
				 (define lines (string-split body #px"\n+"))
				 (hash 'title (list-ref lines 0)
					   'href  (list-ref lines 1)
					   'description (list-ref lines 2)))
			   items))
	items))

(define file-contents (open-file "/home/nathanpc/Stashes/FM Stuff.stash"))
(define header (get-headers file-contents))
(define items (get-items file-contents))

; Print headers.
(printf "~a~n~a~n~n"
		(hash-ref header 'title)
		(hash-ref header 'description))

; Print items.
(for-each (lambda (item)
	   (printf "~a~n~a~n~a~n---~n"
			   (hash-ref item 'title)
			   (hash-ref item 'href)
			   (hash-ref item 'description)))
	 items)