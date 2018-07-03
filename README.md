# PKOpenWeatherMapApi
Swift api for OpenWeatherMap

## Development summary:
My plan was creating a framework to cover the OpenWeatherMap's api. Once it's done, this api will provide a clean, well-structured weather responses. Unfortunately the API itself is so bad I need to give up after the current weather calls, because I don't want to waste my time with such a bad system.

## My problems with the API:
- there are only poor documentations
- - there isn't any list of all of the possible keys for the models
- - you can't decide which fields are optional or required
- Very incosistent behaviours
- - different keys for the same properties when you use 2 different calls (like: "lat" and "Lat" as latitude or "cnt" and "count" as count)
- -  (my personal favorite) different types for the same properties when you use 2 different calls (eg: response code is sometimes a string sometimes it's an integer)
- - inconsistent response structures: the responses contain a code which should be the response code (like 200 is a success call etc), but in some responses this code field is missing (have fun deciding was it successful or not)

So...after hours of headache, I gave up... If you would like to create a beautiful weather app, I would recommend to choose another data provider and definetly not https://openweathermap.org/ at least until they don't improve the quality of their service.

