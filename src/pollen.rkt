#lang racket/base

(require racket/list pollen/decode txexpr gregor pollen/tag pollen/unstable/typography)
(require "hymn_names.rkt")
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define command-char #\@))

(define (program-header unit-name [title "Sacrament Meeting Program"])
  `(div (h1 ((class "header")) ,title)
        (h2 ((class "header")) ,unit-name)))

(define (sacrament-meeting-header unit-name)
  (program-header unit-name "Sacrament Meeting Program"))

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

(define (opening-hymn name-or-number #:term [term "Opening Hymn"])
  (hymn name-or-number #:term term))
(define (closing-hymn name-or-number #:term [term "Closing Hymn"])
  (hymn name-or-number #:term term))
(define (rest-hymn name-or-number #:term [term "Rest Hymn"])
  (hymn name-or-number #:term term))
(define (sacrament-hymn name-or-number #:term [term "Sacrament Hymn"])
  (hymn name-or-number #:term term))

(define (musical-number name #:term [term "Musical Number"] #:performed-by [performed-by " performed by "] . performer)
  `(div ((class "program-event musical-number"))
        (h5 ,term)
        (p
         (span ((class "musical-number-name")) ,name) ,performed-by
         (span ((class "musical-number-performer")) ,@performer))))

(define (render-hymn number name [term "Hymn"])
  `(div ((class "program-event hymn"))
        (h5 ,term)
        (span ((class "hymn-number")) ,(number->string number))
        (span ((class "hymn-name")) ,name)))

(define (make-hymn-from-name name term)
  (let ([num-name (findf (λ (x) (equal? (string-locale-downcase (cdr x))
                                        (string-locale-downcase name))) hymn-number-name)])
    (render-hymn (car num-name) (cdr num-name) term)))
(define (make-hymn-from-number num term)
  (let ([name (assoc num hymn-number-name)])
    (render-hymn num (cdr name) term)))

(define (hymn name-or-number #:term [term "Hymn"])
  (let ([m (regexp-match "^([0-9]+)$" name-or-number)])
    (if m
        (make-hymn-from-number (string->number (cadr m)) term)
        (make-hymn-from-name name-or-number term))))

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

