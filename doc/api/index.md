FORMAT: 1A
HOST: http://api.example.com

# Tebukuro

## Group Event

イベント

## Event [/events/{event_id}]

イベントの項目:

+ name - イベントの名称
+ description - イベントの説明
+ quota - イベントの定員
+ participants - 参加者の配列.

+ Parameters
    + event_id: 1 (required, number) - ID

### View a events Detail [GET]

+ Response 200 (application/json)
    + Attributes (Event)

## Data Structures

### Event

+ id: 1 (number, required) - ID
+ name: event example (string, required) - イベントの名称
+ description: description example (string, optional) - イベントの説明
+ quota: 3 (number, required) - イベントの定員
+ participants (array[Participant]) - 参加者の配列.

### Participant

+ id: 1 (number, required) - ID
+ event_id: 1 (number, required) - ID of Event
+ name: username (number, required) - 参加者の名前
+ on_waiting_list: false (boolean, required) - on_waiting_list
