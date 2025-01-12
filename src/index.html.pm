#lang pollen

@; This is called a comment. You won't see it in the final output.
@; Any line starting with "@;" will be ignored by Pollen.

@; For e.g. Fast and Testimony meeting, you can simply remove the ";"
@; from the fast-and-testimony-header line and add one to the
@; sacrament-meeting-header line, and then reverse it for the next week.

@sacrament-meeting-header{Salt Lake Married Student 9th Ward}
@;fast-and-testimony-header{Salt Lake Married Student 9th Ward}

@;banner{christmas_picture.png}

@welcome-blurb{Visitors and members alike, welcome to the Church of Jesus Christ of Latter-day Saints!}

@; Don't forget: keywords ("#:pianist", "#:organist" etc.) are
@; case sensitive!

@(meeting-org
    #:conducting "Brother Griffin"
    #:presiding "Bishop Humpherys"
    #:chorister "Sister Evans"
    #:organist "Brother Wiersdorf"
    )  @; make sure the close paren stays!

@section{Program}

@opening-hymn{5}

@opening-prayer{Sister Tullis}

@event{Ward/Stake Business}

@sacrament-hymn{184}

@event{Administration of the Sacrament}

@talk{Sister Willey}

@talk{Brother Willey}

@;rest-hymn{68}

@talk{Sister Hale}

@talk{Brother Hale}

@closing-hymn{105}

@closing-prayer{Brother Tullis }

@section{Announcements}

@announcement["Ward Slack workspace"]{
Our ward uses a Slack workspace to send out announcements about activites, as well as to coordinate service. Please join with @link["https://join.slack.com/t/saltlakemarri-0vv2943/shared_invite/zt-22jlkviya-R3AcUkNR8K3O3ewDgohaOQ"]{this invite link}.
}

@announcement["New member form"]{
If you are new to the ward, please help us move your records in by filling out @link["https://forms.gle/bVHiqHTurYz2GYcs5"]{this short form}.
}

@announcement["Picture for the ward bulletin"]{
We would love to have a picture of your family for our ward bulletin! Please either bring us a picture yourself, or upload one to @link["https://forms.gle/zDnMhWEGNxgcGupN9"]{this form} and we'll print it for you.
}


@section{Upcoming Events}

@calendar-event["Ward activity" #:date "2025-01-10" #:time "19:00" #:hours 2 #:id "jan-2025-ward-activity"]{Fun activities and games with refreshments.}

@calendar-event["Ward temple night" #:date "January 15 and 17th" #:time "19:00"]{
Ward temple nights are on the 3rd Wednesday and Friday of every month at 7:00 PM at the Bountiful temple. Sign up to make an appointment at @link["https://www.churchofjesuschrist.org/temples/schedule/appointment?lang=eng"]{this link}.
}

@;calendar-event["Ward activity" #:date "Friday January 10th"]{Fun Activities and Games with Refreshments}

@; Please don't remove this line, as it's to help you navigate back to
@; editing this program.
@centerdiv{@small{@link["https://github.com/slms-9th-ward/sacrament-program"]{Edit this program} ◊ @link["/sacrament-program/command_examples.html"]{Program command examples}}}
