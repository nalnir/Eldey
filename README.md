# eldey

A Weather Forecast App with a cute twist.

## Getting Started

The Project has MIT license. 

Project uses free api from Icelandic Meteorological Office.
More can be found in [API documentation](https://docs.apis.is/#endpoint-weather)

Why this API?
Yes you can use [Open Weather API](https://openweathermap.org/) or any other that has more options
however anyone can check weather at any place with a simple google search.
Why would you need a weather app for that?
Unless...
There is more to it. Let me explain.

Icelandic weather is very unique. It's unpredictable. Like weather usually is, but more unpredictable than usual.
I've met some tourists in Iceland that underestimated the weather and that resulted in an unpleasant trip that could
otherwise be super awesome. Cause Icelandic nature is awesome!
So what am I trying to say? Why not make a suggestions based on a weather?
Such as:

    - Clothing suggestions

    - Entertainment suggestions

    - Travel suggestions

Eldey can have some potential. Maybe we should take it there...

Dependencies used:

    - http: for API data fetching

    - geolocator: getting current GPS location of the device

    - path_provider: for storing and retrieving data in a local memory

    - rive: for animations

    - flutter_localizations: for multiple language support

    - intl: for multiple language support

    - flutter_launcher_icons: for App Icon

Additional Info:
Eldey supports english and icelandic languages based on your device localization.

To see Eldey chaning halo colors based on temperature there is a little play feature:

    - One tap on Air temperature will decrease the temperature by one point

    - Double tap on Air temperature will increace the temperature by one point

To see Eldey changing from sun to moon and vice versa select a different time

Fun fact: 
Did you know there are 284 stations scattered in Iceland that collect weather data? Bet you didn't!
If you did, than you are a weather god or something...or just really bored and need some more fact cause you already
know so much.
