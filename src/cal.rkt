#lang racket

(provide fmt-event fmt-event-base64)

(require gregor gregor/time)
(require net/base64)

(define (fmt-event-base64 id start-date start-time num-hours title description)
  (base64-encode
   (string->bytes/utf-8
    (fmt-event id start-date start-time num-hours title description))))

(define (fmt-event id start-date start-time num-hours title description)
  (let ([start-time (fmt-date-time start-date start-time)]
        [end-time (fmt-date-time start-date (+hours start-time (inexact->exact num-hours)))])
    (fmt-event-raw id start-time end-time title description)))

;; take some info an make an iCalendar event
(define (fmt-event-raw id start-timestamp end-timestamp title description)
  (format "BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
BEGIN:VTIMEZONE
TZID:America/Denver
BEGIN:DAYLIGHT
TZOFFSETFROM:-0700
DTSTART:20070311T020000
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=2SU
TZNAME:MDT
TZOFFSETTO:-0600
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:-0600
DTSTART:20071104T020000
RRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=1SU
TZNAME:MST
TZOFFSETTO:-0700
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTEND;TZID=America/Denver:20241227T190000
UID:~a
DTSTART;TZID=America/Denver:~a
DTEND;TZID=America/Denver:~a
SUMMARY:~a
DESCRIPTION:~a
END:VEVENT
END:VCALENDAR"
          id start-timestamp end-timestamp title description))

(define (fmt-date-time the-date the-time)
  (fmt-dt-ical (->year the-date) (->month the-date) (->day the-date)
               (->hours the-time) (->minutes the-time) (->seconds the-time)))

(define (fmt-dt-ical y m d h i [s 0])
  (date->icalfmt (mst/mdt->utc y m d h i s)))

(define (date->icalfmt m)
  (~t m "yyyyMMdd'T'HHmmss'Z'"))

(define (mst/mdt->utc y m d h i [s 0])
  #;(->datetime/utc (moment y m d h i s #:tz "America/Denver"))
  (moment y m d h i s #:tz "America/Denver"))
