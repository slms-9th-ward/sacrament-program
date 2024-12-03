#lang racket

(define (process-line line-text sections)
  (let* ([line-text (string-replace line-text "¶" "\n")]
         [esc-str (string-replace line-text "\"" "\\\"")])
    (cond
      [(regexp-match "^@" line-text)
       (format "@code-and-render[\"~a\"]{~a}\n" esc-str line-text)]
      [(regexp-match "^;;autogen-warning" line-text)
       "@;{WARNING! This file is auto-generated. Please edit ce_src.scrbl and run documentor.rkt.}\n"]
      [(regexp-match "^;;autogen-toc" line-text)
       (format "@make-toc['~a]" sections)]
      [(regexp-match "^;;" line-text)
       (format "@section[#:id \"~a\"]{@pre{~a}}\n" (string-trim (string-replace esc-str ";" "")) (string-replace esc-str ";" ""))]
      [(regexp-match "^;" line-text)
       (format "@title{~a}\n" (string-replace esc-str ";" ""))]
      [else (string-replace line-text "#lang scribble" "#lang pollen")])))

(define (process-file infile outfile)
  (with-output-to-file outfile
    #:exists 'replace
    (λ ()
      (let ([sections (for/list ([l (file->lines infile)]
                                 #:when (regexp-match "^;; " l))
                        (string-replace l ";; " ""))])
        (for ([line (file->lines infile)])
          (displayln (process-line line sections)))))))

;; run processor

(process-file "ce_src.scrbl" "../src/command_examples.html.pm")
