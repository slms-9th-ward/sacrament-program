#lang pollen

@;{WARNING! This file is auto-generated. Please edit ce_src.scrbl and run documentor.rkt.}


@title{ Command examples}


@section{@pre{ program-header}}


@code-and-render["@program-header{Name of Unit}"]{@program-header{Name of Unit}}


@code-and-render["@program-header[\"My Unit Name\"]{Another Meeting}"]{@program-header["My Unit Name"]{Another Meeting}}


@section{@pre{ sacrament-meeting-header}}


@code-and-render["@sacrament-meeting-header{Your Unit Here}"]{@sacrament-meeting-header{Your Unit Here}}


@section{@pre{ welcome-blurb}}


@code-and-render["@welcome-blurb{Having \"lorem ipsum\" as your thesis topic is a rather poor decision.}"]{@welcome-blurb{Having "lorem ipsum" as your thesis topic is a rather poor decision.}}


@section{@pre{ meeting-org}}


@code-and-render["@(meeting-org #:presiding \"Bishop Albert\" #:conducting \"Brother Big\" #:chorister \"Sister Cee\" #:pianist \"Brother Dee\")"]{@(meeting-org #:presiding "Bishop Albert" #:conducting "Brother Big" #:chorister "Sister Cee" #:pianist "Brother Dee")}


@code-and-render["@(meeting-org #:conducting \"Elder Eames\" #:presiding \"President Faust\" #:chorister \"Brother Gee\" #:organist \"Sister Aetch\")"]{@(meeting-org #:conducting "Elder Eames" #:presiding "President Faust" #:chorister "Brother Gee" #:organist "Sister Aetch")}


@section{@pre{ section}}


@code-and-render["@section{Some section here}"]{@section{Some section here}}


@section{@pre{ event}}


@code-and-render["@event{Baby Blessing}"]{@event{Baby Blessing}}


@code-and-render["@event{Here's an event}"]{@event{Here's an event}}


@section{@pre{ person-event}}


@code-and-render["@person-event[#:term \"Loud talker\"]{Mr. Bigmouth}"]{@person-event[#:term "Loud talker"]{Mr. Bigmouth}}


@section{@pre{ talk}}


@code-and-render["@talk{}"]{@talk{}}


@code-and-render["@talk{Elder Young}"]{@talk{Elder Young}}


@code-and-render["@talk[#:term \"Motivational Speaker\"]{Brother Brüder}"]{@talk[#:term "Motivational Speaker"]{Brother Brüder}}


@code-and-render["@talk[#:term \"Improvisation\"]{}"]{@talk[#:term "Improvisation"]{}}


@section{@pre{ opening-prayer}}


@code-and-render["@opening-prayer{}"]{@opening-prayer{}}


@code-and-render["@opening-prayer{Prayer Giver 1}"]{@opening-prayer{Prayer Giver 1}}


@code-and-render["@opening-prayer[#:term \"Opening prayer\"]{}"]{@opening-prayer[#:term "Opening prayer"]{}}


@code-and-render["@opening-prayer[#:term \"Opening prayer\"]{Someone praying}"]{@opening-prayer[#:term "Opening prayer"]{Someone praying}}


@section{@pre{ closing-prayer}}


@code-and-render["@closing-prayer{}"]{@closing-prayer{}}


@code-and-render["@closing-prayer{Prayer Giver 1}"]{@closing-prayer{Prayer Giver 1}}


@code-and-render["@closing-prayer[#:term \"Closing prayer\"]{}"]{@closing-prayer[#:term "Closing prayer"]{}}


@code-and-render["@closing-prayer[#:term \"Closing prayer\"]{Someone praying}"]{@closing-prayer[#:term "Closing prayer"]{Someone praying}}


@section{@pre{ hymn}}


@code-and-render["@hymn{}"]{@hymn{}}


@code-and-render["@hymn{68}"]{@hymn{68}}


@code-and-render["@hymn[#:verses '(1 2 3)]{72}"]{@hymn[#:verses '(1 2 3)]{72}}


@code-and-render["@hymn[#:verses '(1 3 4) #:term \"Stand and sing\"]{2}"]{@hymn[#:verses '(1 3 4) #:term "Stand and sing"]{2}}


@code-and-render["@hymn{high on a mountain top}"]{@hymn{high on a mountain top}}


@section{@pre{ opening-hymn}}


@code-and-render["@opening-hymn{}"]{@opening-hymn{}}


@code-and-render["@opening-hymn[#:verses '(1)]{72}"]{@opening-hymn[#:verses '(1)]{72}}


@section{@pre{ closing-hymn}}


@code-and-render["@closing-hymn[#:verses '(1 2)]{100}"]{@closing-hymn[#:verses '(1 2)]{100}}


@section{@pre{ sacrament-hymn}}


@code-and-render["@sacrament-hymn{174}"]{@sacrament-hymn{174}}


@section{@pre{ rest-hymn}}


@code-and-render["@rest-hymn{}"]{@rest-hymn{}}


@section{@pre{ announcement}}


@code-and-render["@announcement[\"Announcement header here\"]{Lorem ipsum dolor sit amet. Blah blah blah tell the people about this thing. To @em{emphasize} text, use the @code{em} command.

You can have multiple paragraphs in this block. Just separate them with a blank line.}"]{@announcement["Announcement header here"]{Lorem ipsum dolor sit amet. Blah blah blah tell the people about this thing. To @em{emphasize} text, use the @code{em} command.

You can have multiple paragraphs in this block. Just separate them with a blank line.}}


@section{@pre{ calendar-event}}


@code-and-render["@calendar-event[\"Ward party\" #:date \"2024-12-06\" #:time \"18:00\"]{Please use the ISO 8601 format for the date and military time for the time. Pollen will format the rest.}"]{@calendar-event["Ward party" #:date "2024-12-06" #:time "18:00"]{Please use the ISO 8601 format for the date and military time for the time. Pollen will format the rest.}}


@code-and-render["@calendar-event[\"Pickleball\" #:date \"Every Wednesday\" #:time \"18:00\"]{Use a non ISO 8601 date for freeform dates/times.}"]{@calendar-event["Pickleball" #:date "Every Wednesday" #:time "18:00"]{Use a non ISO 8601 date for freeform dates/times.}}


@code-and-render["@calendar-event[\"Snow removal\" #:date \"November\"]{We need to shovel the snow around the church.}"]{@calendar-event["Snow removal" #:date "November"]{We need to shovel the snow around the church.}}

