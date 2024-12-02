#lang racket

(define (process-line line-text)
  (let* ([line-text (string-replace line-text "¶" "\n\n")]
         [esc-str (string-replace line-text "\"" "\\\"")])
    (cond
      [(regexp-match "^@" line-text)
       (format "@code-and-render[\"~a\"]{~a}\n" esc-str line-text)]
      [(regexp-match "^;;autogen-warning" line-text)
       "@;{WARNING! This file is auto-generated. Please edit ce_src.scrbl and run documentor.rkt.}\n"]
      [(regexp-match "^;;" line-text)
       (format "@section{@pre{~a}}\n" (string-replace esc-str ";" ""))]
      [(regexp-match "^;" line-text)
       (format "@title{~a}\n" (string-replace esc-str ";" ""))]
      [else (string-replace line-text "#lang scribble" "#lang pollen")])))

(define (process-file infile outfile)
  (with-output-to-file outfile
    #:exists 'replace
    (λ ()
      (for ([line (file->lines infile)])
        (displayln (process-line line))))))

;; run processor

(process-file "ce_src.scrbl" "../src/command_examples.html.pm")
