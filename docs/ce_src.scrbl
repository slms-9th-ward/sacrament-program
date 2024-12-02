#lang scribble

;;autogen-warning

; Command examples

;; program-header

@program-header{Name of Unit}

@program-header["My Unit Name"]{Another Meeting}

;; sacrament-meeting-header

@sacrament-meeting-header{Your Unit Here}

;; welcome-blurb

@welcome-blurb{Having "lorem ipsum" as your thesis topic is a rather poor decision.}

;; meeting-org

@(meeting-org #:presiding "Bishop Albert" #:conducting "Brother Big"¶              #:chorister "Sister Cee" #:pianist "Brother Dee")

@(meeting-org #:conducting "Elder Eames" #:presiding "President Faust"¶              #:chorister "Brother Gee" #:organist "Sister Aetch")

;; section

@section{Some section here}

;; event

@event{Baby Blessing}

@event{Here's an event}

;; person-event

@person-event[#:term "Loud talker"]{Mr. Bigmouth}

;; talk

@talk{}

@talk{Elder Young}

@talk[#:term "Motivational Speaker"]{Brother Brüder}

@talk[#:term "Improvisation"]{}

;; opening-prayer

@opening-prayer{}

@opening-prayer{Prayer Giver 1}

@opening-prayer[#:term "Opening prayer"]{}

@opening-prayer[#:term "Opening prayer"]{Someone praying}

;; closing-prayer

@closing-prayer{}

@closing-prayer{Prayer Giver 1}

@closing-prayer[#:term "Closing prayer"]{}

@closing-prayer[#:term "Closing prayer"]{Someone praying}

;; hymn

@hymn{}

@hymn{68}

@hymn[#:verses '(1 2 3)]{72}

@hymn[#:verses '(1 3 4) #:term "Stand and sing"]{2}

@hymn{high on a mountain top}

;; opening-hymn

@opening-hymn{}

@opening-hymn[#:verses '(1)]{72}

;; closing-hymn

@closing-hymn[#:verses '(1 2)]{100}

;; sacrament-hymn

@sacrament-hymn{174}

;; rest-hymn

@rest-hymn{}

;; announcement

@announcement["Announcement header here"]{¶Lorem ipsum dolor sit amet. Blah blah blah tell the people about this thing. To @em{emphasize} text, use the @code{em} command.¶You can have multiple paragraphs in this block. Just separate them with a blank line.¶}

;; calendar-event

@calendar-event["Ward party" #:date "2024-12-06" #:time "18:00"]{¶Please format dates like "YYYY-MM-DD" (this is called the ISO 8601 format)¶and use military time for the time. Pollen will format the rest.¶}

@calendar-event["Pickleball" #:date "Every Wednesday" #:time "18:00"]{¶Use a non ISO 8601 date for freeform dates/times.¶}

@calendar-event["Snow removal" #:date "November"]{¶We need to shovel the snow around the church.¶}
