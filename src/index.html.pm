#lang pollen

@; This is called a comment. You won't see it in the final output.
@; Any line starting with "@;" will be ignored by Pollen.

@; For e.g. Fast and Testimony meeting, you can simply remove the ";"
@; from the fast-and-testimony-header line and add one to the
@; sacrament-meeting-header line, and then reverse it for the next week.

@sacrament-meeting-header{Salt Lake Married Student 9th Ward}
@;fast-and-testimony-header{Salt Lake Married Student 9th Ward}

@welcome-blurb{Visitors and members alike, welcome to the Church of Jesus Christ of Latter-day Saints!}

@; Don't forget: keywords ("#:pianist", "#:organist" etc.) are
@; case sensitive!

@(meeting-org
    #:conducting "Brother Jensen"
    #:presiding "Bishop Humpherys"
    #:chorister "Sister Evans"
    #:pianist "Brother Henson"
    )  @; make sure the close paren stays!

@section{Program}

@opening-hymn{207}

@opening-prayer{Brother Jaszkowiak}

@event{Ward & Stake Business}

@sacrament-hymn{193}

@event{Administration of the Sacrament}

@talk{David and Jessica Pearson}

@talk{Visiting High Councilor}

@closing-hymn{204}

@closing-prayer{Sister Jaszkowiak}

@section{Announcements}

@announcement["Ward Slack workspace"]{
Our ward uses a Slack workspace to send out announcements about activites, as well as to coordinate service. Please join with @link["https://join.slack.com/t/saltlakemarri-0vv2943/shared_invite/zt-22jlkviya-R3AcUkNR8K3O3ewDgohaOQ"]{this invite link}.
}

@announcement["New member form"]{
If you are new to the ward, please help us move your records in by filling out @link["https://forms.gle/bVHiqHTurYz2GYcs5"]{this short form}.
}

@announcement["Receipts"]{
If you have receipts to submit, you can do that over the Tools app. If you have any questions, please contact a bishopric member.
}

@announcement["Christmas program choir"]{
The 9th and 14th wards are combined for Christmas. Practices for a choir happen after church each Sunday in our chapel.

There is no minimum experience level to sing in the choir—anyone who wants to come is welcome!

The music for the choir is @italic{Come Thou Long Expected Jesus} and you can download the music @link["https://drive.google.com/file/d/1v4B_o7pI0RUpML3S_TQHDBG7LIun9VtT"]{here}.
}

@announcement["Picture for the ward bulletin"]{
We would love to have a picture of your family for our ward bulletin! Please either bring us a picture yourself, or upload one to @link["https://forms.gle/zDnMhWEGNxgcGupN9"]{this form} and we'll print it for you.
}

@calendar-event["Christmas Sacrament Meeting" #:date "2024-12-22" #:time "09:00" #:id "christmas-sunday-service" #:hours 1]{
We will be combined with 14th ward in the East chapel for a special Christmas program. There will be light refreshments after the meeting.

Please take a flyer in the lobby and invite your friends!}

@section{Upcoming Events}

@calendar-event["Ward temple night" #:date "3rd Wednesday and Friday each month" #:time "19:00"]{
Ward temple nights are this week, they're on the 3rd Wednesday and Friday of every month at 7:00 PM at the Bountiful temple. Sign up to make an appointment at @link["https://www.churchofjesuschrist.org/temples/schedule/appointment?lang=eng"]{this link}.
}

@calendar-event["Ward activity" #:date "2025-1-10" 
]{
The ward activity will be the second week of January instead of the first.
}

@; Please don't remove this line, as it's to help you navigate back to
@; editing this program.
@centerdiv{@small{@link["https://github.com/slms-9th-ward/sacrament-program"]{Edit this program} ◊ @link["/sacrament-program/command_examples.html"]{Program command examples}}}
