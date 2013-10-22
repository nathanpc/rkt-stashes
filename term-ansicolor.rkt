#lang racket
;; Colorize the terminal output.
;; Based in http://rosettacode.org/wiki/Terminal_control/Coloured_text#Racket

(provide term-foreground term-background term-reset colorize)

(define color-map '([black 0] [red 1] [green 2] [yellow 3]
                    [blue 4] [magenta 5] [cyan 6] [white 7]))

;; Sets the foreground color.
(define foreground
  (lambda (color)
    (printf "\033[3~am" (cadr (assq color color-map)))))

;; Sets the background color.
(define background
  (lambda (color)
    (printf "\033[4~am" (cadr (assq color color-map)))))

;; Resets everything.
(define reset
  (lambda ()
    (display "\033[0m")))

;; Colorizes a string.
(define colorize
  (lambda (fg str #:bg [bg #f])
	(foreground fg)
	(cond (bg)
		(background bg))
	(display str)
	(reset)))

;; Public alias for (foreground)
(define term-foreground
  (lambda (color)
	(foreground color)))

;; Public alias for (background)
(define term-background
  (lambda (color)
	(background color)))

;; Public alias for (reset)
(define term-reset
  (lambda ()
	(reset)))