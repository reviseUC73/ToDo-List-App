# ToDo List App

A Flutter-based ToDo List application with a passcode-protected login screen. The app provides task management features and a clean, customizable user interface.
* **Note Password is 123456**
## Features

* **Passcode Screen**: Users must enter a passcode to access the app.
* **Task Management**: Organize tasks under TODO, DOING, and DONE tabs.
* **API Integration**: Fetch tasks from a remote server with pagination.
* **Readable Dates**: Tasks are grouped by human-readable dates (e.g., Today, Tomorrow).
* **Customizable UI**: Clean design with randomized icons and colors for tasks.
* **Testing**: Includes unit and integration tests for reliability.

## Requirements

1. **Flutter SDK**: Version 3.9.0 or higher.
2. **Dart**: Version 3.0.0 or higher.
3. **Device/Emulator**: A physical device or an emulator to run the app.

## How to Run the Project

1. Clone the repository:

   `git clone https://github.com/your-repository/todo-list-app.git
   cd todo-list-app`
2. Install the dependencies:

   `flutter pub get`
3. Run the application on your device or emulator:

   `flutter run`

## Testing Instructions

#### Unit Tests

* Run unit tests for validating business logic:

  `flutter test/unit_test`

#### Integration Tests

* Run integration tests to verify the app's flow:

  ` flutter test test/integration_test`

## Dependencies
	- intl: For human-readable date formatting (e.g., “Today”, “Tomorrow”).
	- http: For REST API calls to fetch tasks.
	- provider: For state management (e.g., TaskViewModel).
	- flutter_slidable: This is for swipe-to-delete functionality in task lists.

## API Information

##### Base URL: `https://todo-list-api-mfchjooefq-as.a.run.app/todo-list`

##### Query Parameters:

* **offset**: Starting index for tasks (pagination).
* **limit**: Number of tasks to fetch per request.
* **sortBy**: Field to sort tasks (e.g., `createdAt`).
* **isAsc**: Sort order (true = ascending, false = descending).
* **status**: Task status (TODO, DOING, DONE).

##### Example Request:

`GET https://todo-list-api-mfchjooefq-as.a.run.app/todo-list?offset=0&limit=10&sortBy=createdAt&isAsc=true&status=TODO`

## Folder Structure
![image](https://github.com/user-attachments/assets/36dc6e17-613d-4f3b-a377-a03728c503e4)


---

## Preview Project

- ![image](https://github.com/user-attachments/assets/1824ec83-ef3d-49eb-9e2e-cd5c022d460c)
- ![image](https://github.com/user-attachments/assets/7fe60dc7-d1ca-45b1-a93d-8f46e391eb0e)
- ![image](https://github.com/user-attachments/assets/c27c1571-b00b-40c1-b48c-4347b108b57f)
- ![image](https://github.com/user-attachments/assets/4928f46f-cbb1-46d6-b500-ccba75d10036)


## Contributing

Contributions are welcome! Fork the repository, make changes, and submit a pull request. Feature suggestions and bug reports are also appreciated.

## License

This project is licensed under the MIT License.
