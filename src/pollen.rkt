#lang racket

(require racket/list pollen/core pollen/decode txexpr gregor pollen/tag pollen/unstable/typography
         syntax/parse/define)
(require "hymn_names.rkt")
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define command-char #\@))

(define (title . text)
  `(div (h1 ((class "header title")) ,@text)))

(define (program-header unit-name [title "Sacrament Meeting Program"])
  `(div (h1 ((class "header")) ,title)
        (h2 ((class "header")) ,unit-name)))

(define (sacrament-meeting-header unit-name)
  (program-header unit-name "Sacrament Meeting Program"))

(define (welcome-blurb . text)
  `(div ((class "welcome-blurb")) ,@text))

(define (meeting-org #:presiding [presiding #f]
                     #:conducting [conducting #f]
                     #:chorister [chorister #f]
                     #:pianist [pianist #f]
                     #:organist [organist #f])
  `(div ((class "meeting-org"))
        (div ((class "leadership"))
             ,(when presiding
                `(div (h5 "Presiding")
                      ,presiding))
             ,(when conducting
                `(div (h5 "Conducting")
                      ,conducting)))
        (div ((class "music"))
             ,(when chorister
                `(div (h5 "Chorister")
                      ,chorister))
             ,(when pianist
                `(div (h5 "Pianist")
                      ,pianist))
             ,(when organist
                `(div (h5 "Organist")
                      ,organist)))))

(define section (default-tag-function 'h3))

(define event (default-tag-function 'h4))

;; events with a person attached to them
(define (person-event name #:term term)
  `(div ((class "program-event prayer"))
        (h5 ,term)
        ,name))

(define (opening-prayer [name "By invitation"] #:term [term "Invocation"])
  (person-event name #:term term))
(define (closing-prayer [name "By invitation"] #:term [term "Benediction"])
  (person-event name #:term term))
(define (talk [name "By invitation"] #:term [term "Speaker"])
  (person-event name #:term term))

(define (make-hymn-shortcut default-term)
  (λ ([name-or-number ""] #:term [term default-term] #:verses [verses #f] #:verse [verse #f])
    (hymn name-or-number #:term term #:verses (or verses verse))))

(define opening-hymn (make-hymn-shortcut "Opening Hymn"))
(define closing-hymn (make-hymn-shortcut "Closing Hymn"))
(define rest-hymn (make-hymn-shortcut "Rest Hymn"))
(define sacrament-hymn (make-hymn-shortcut "Sacrament Hymn"))

(define (musical-number name #:term [term "Musical Number"] #:performed-by [performed-by " performed by "] . performer)
  `(div ((class "program-event musical-number"))
        (h5 ,term)
        (p
         (span ((class "musical-number-name")) ,name) ,performed-by
         (span ((class "musical-number-performer")) ,@performer))))

(define (format-verses verse-list)
  (case (length verse-list)
    [(0) (error "verse list for hymn may not be empty")]
    [(1) (format "Verse ~a" (car verse-list))]
    [(2) (format "Verses ~a and ~a" (car verse-list) (cadr verse-list))]
    [else (format "Verses ~a, and ~a" (string-join
                                       (map (λ (x) (format "~a" x))
                                            (drop-right verse-list 1))
                                       ", ") (last verse-list))]))

(define (render-hymn number name [term "Hymn"] [verses #f])
  (let* ([hymn-info (if (number? number) (hymn-data number) (make-hasheq))]
         [url (hash-ref hymn-info 'playerlink #f)]
         [pdf-url (hash-ref hymn-info 'pdf #f)])
    `(div ((class "program-event hymn"))
          (h5 ,term)
          (span ((class "hymn-number")) ,(if (number? number) (number->string number) number))
          (span ((class "hymn-name")) ,name)
          ,(when (or url pdf-url)
             `(span ((class "hymn-links"))
                    ,(when url `(span ((class "hymn-link")) ,(link url "open music")))
                    ,(when (and url pdf-url) '(span ((class "hymn-link-sep")) "◊"))
                    ,(when pdf-url `(span ((class "hymn-pdf-link")) ,(link pdf-url "open as PDF")))))
          ,(when verses `(span ((class "hymn-verses")) ,(format-verses verses))))))

(define (make-hymn-from-name name term verses)
  (let ([num-name (findf (λ (x) (equal? (string-locale-downcase (cdr x))
                                        (string-locale-downcase name))) hymn-number-name)])
    (render-hymn (car num-name) (cdr num-name) term verses)))

(define (make-hymn-from-number num term verses)
  (let ([name (assoc num hymn-number-name)])
    (render-hymn num (cdr name) term verses)))

#;(define (make-hymn-url full-name)
  (let ([slug (string-join
               (filter (λ (c) (regexp-match "[a-z]" c))
                       (string->list (string-downcase full-name)))
               "-")])
    (format "https://www.churchofjesuschrist.org/media/music/songs/~a" slug)))

(define (hymn [name-or-number ""] #:term [term "Hymn"] #:verses [verses #f] #:verse [verse #f])
  (if (equal? name-or-number "")
      (render-hymn "By announcement" "" term (or verses verse))
      (let ([m (regexp-match "^([0-9]+)$" name-or-number)])
        (if m
            (make-hymn-from-number (string->number (cadr m)) term (or verses verse))
            (make-hymn-from-name name-or-number term (or verses verse))))))

(define (announcement header . body-text)
  `(div ((class "announcement"))
        (div ((class "announcement-header")) ,header)
        (div ((class "announcement-description"))
             ,@body-text)))

(define (try-dt-parse f str)
  (with-handlers ([exn:gregor:parse? (λ (_) #f)])
    (f str)))

(define (calendar-event title #:date the-date #:time [the-time ""] . description)
  (let* ([parsed-date (try-dt-parse iso8601->date the-date)]
         [parsed-time (try-dt-parse iso8601->time the-time)]
         [full-string (cond [(and parsed-date parsed-time)
                             (string-append (~t parsed-date "EEEE, MMMM d, y")
                                            " at "
                                            (~t parsed-time "h:mm a"))]
                            [parsed-date
                             (string-append
                              (~t parsed-date "EEEE, MMMM d, y")
                              (if (not (equal? the-time "")) (format " at ~a" the-time) ""))]
                            [parsed-time
                             (string-append
                              the-date " at " (~t parsed-time "h:mm a"))]
                            [else
                             (format "~a ~a" the-date the-time)])])
    `(div ((class "calendar-event"))
          (div ((class "event-metadata"))
               (span ((class "event-title")) ,title)
               (span ((class "event-datetime")) ,full-string))
          (div ((class "event-description"))
          ,@description))))

(define (link url text) `(a ((href ,url)) ,text))

(define (root . elements)
  (txexpr 'root empty
          (decode-elements elements
                           #:txexpr-elements-proc decode-paragraphs
                           #:exclude-tags '(code pre codeblock)
                           #:string-proc (compose1
                                          #;make-quotes-hangable
                                          smart-quotes
                                          smart-dashes
                                          smart-ellipses))))

;; snarfed from https://docs.racket-lang.org/pollen-tfl/_pollen_rkt_.html#%28def._%28%28lib._pollen-tfl%2Fpollen..rkt%29._make-quotes-hangable%29%29
#;(define (make-quotes-hangable str)
  (define substrs (regexp-match* #px"\\s?[“‘]" str #:gap-select? #t))
  (if (= (length substrs) 1)
      (car substrs)
      (cons 'quo (append-map (λ (str)
                               (let ([strlen (string-length str)])
                                 (if (> strlen 0)
                                     (case (substring str (sub1 strlen) strlen)
                                       [("‘") (list '(squo-push) `(squo-pull ,str))]
                                       [("“") (list '(dquo-push) `(dquo-pull ,str))]
                                       [else (list str)])
                                     (list str)))) substrs))))

(define (code-and-render code-literal rendered-as)
  `(div ((class "code-example"))
        (div ((class "code-example-code"))
             (pre ,code-literal))
        (div ((class "code-example-example"))
             ,rendered-as)))

(define (details summary . body)
  `(details ()
            (summary () ,summary)
            ,@body))

(define (make-toc elements)
  `(div ((class "toc"))
        (h4 () "Contents")
    (nav ((class "toc"))
       (ul ()
           ,@(map (λ (x) `(li () ,(link (format "#~a" x) `(pre ,(format "~a" x))))) elements)))))

(define centerdiv (default-tag-function 'div #:style "text-align:center"))

#;(define (make-toc-file filename)
  (let ([h3s 42 #;(select* 'h3 filename)])
    (eprintf "h3s: ~a\n" (path->complete-path filename) #;(select-from-doc 'foo (path->complete-path filename)))
    `(div 42)))

#;(define (side-by-side . text)
  (eprintf "text: ~a\n" text)
  `(div ((class "code-example"))
        ,@text))

;; Private functions/macros for documentation

#;(define-syntax (docs-example stx)
  (syntax-parse stx
    [(_ cmd)
     (eprintf "cmd: ~a" (syntax->datum #'cmd))
     #`(code-and-render
        #,(format "~a" (syntax->datum #'cmd))
        #,(read (open-input-string (syntax->datum #'cmd))))]))

