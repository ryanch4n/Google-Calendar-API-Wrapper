**Google Calendar API Wrapper**

Written by: Jeff Kaleshi

This program allows you to get content from Google calendar's API such as event start times, end times and the event title.

**Setup**

```
1. Clone the repository
2. Follow [instructions](https://developers.google.com/google-apps/calendar/quickstart/ruby) on how to download calendar 'client_secret.json'.
3. Move client_secret.json into secrets folder.
4. Run setup.rb
5. Now you can add it to you can add it to your project!
```

**Use**

The program creates a Calendar class you must instantiate it to use it.

```
include Calendar
calendar = Calendar.new('calendar id goes here')
```

To get events for the calendar

```
calendar.getEvents()
```

To access calender summaries

```
calendar.event_summaries => []
```

To access calender start times

```
calendar.event_start_times => []
```

To access calender end times

```
calendar.event_end_times => []
```

To access calender start dates

```
calendar.event_start_dates => []
```

