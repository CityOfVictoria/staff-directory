# Staff Directory

A searchable staff directory for your organization.

## Data
Your staff data should be available to staff directory as json in this format:
```json [
    {
        "id": 1,
        "lastName": "Alan",
        "firstName": "Turing",
        "department": "Engineering and Public Works",
        "division": "Transportation",
        "section": "Engineering",
        "description": "Planner",
        "local": "1101",
        "location": "1st Floor - City Hall",
        "photo": "alan-turing.jpg",
        "mobile": "2501234567",
        "email": "alan-turning@victoria.ca",
        "desc": "Planner",
        "externalphone": "2501234567",
        "type": "person"
    },
    ...
]
```
You can expose it as an exported file or a service endpoint; ajax doesn't care.

## Dev Environment

### Prerequisites: Node.js + npm + jspm
1. Install https://nodejs.org/en/
1. Install tools in a node command window:
  ```
  install
  ```
  
### Update dependencies
In a node command window:
  ```
  update
  ```
  
### Build
  
#### Build for development
In a node command window:
```
gulp dev
```
build will output into ./dev

you can also watch using 
```
gulp watch
```

#### Build for deployment
In a node command window:
```
gulp dist
```
and it will output into ./dist

### Try

#### Run a server for dev
```
npm run web
```
then go to 
http://127.0.0.1:9080