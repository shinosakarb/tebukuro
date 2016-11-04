## <a name="resource-event">Event</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when event was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of event | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of event | `"example"` |
| **updated_at** | *date-time* | when event was updated | `"2015-01-01T12:00:00Z"` |

### Event Create

Create a new event.

```
POST /events
```


#### Curl Example

```bash
$ curl -n -X POST /events \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Event Delete

Delete an existing event.

```
DELETE /events/{event_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X DELETE /events/$EVENT_ID_OR_NAME \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Event Info

Info for existing event.

```
GET /events/{event_id_or_name}
```


#### Curl Example

```bash
$ curl -n /events/$EVENT_ID_OR_NAME
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Event List

List existing events.

```
GET /events
```


#### Curl Example

```bash
$ curl -n /events
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "example",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### Event Update

Update an existing event.

```
PATCH /events/{event_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X PATCH /events/$EVENT_ID_OR_NAME \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


