# Automation Exercise API Tests

API automation project built with Karate, Java, Gradle and JUnit 5.

## Tech Stack

* Java 11
* Karate
* JUnit 5
* Gradle
* Gherkin
* GitHub Actions
* Masterthought Cucumber Reporting

## Project Structure

```text
src/test/
├── java/
│   ├── data/
│   │   └── DataGenerator.java
│   └── ManagementTest.java
└── resources/
    ├── karate-config.js
    ├── auth/
    ├── brands/
    ├── products/
    ├── searchproducts/
    ├── users/
    └── utils/
        ├── user_account_snippets.feature
        └── user_update_data.json
```

## API Coverage

The suite covers:

* Products list
* Brands list
* Product search
* Login validation
* Account creation
* Account update
* Account details
* Account deletion
* Unsupported HTTP methods
* Missing parameters
* Invalid credentials

## Test Design

The project includes:

* Positive and negative scenarios
* E2E user lifecycle
* Dynamic test data generation
* Reusable Karate scenarios
* External JSON test data
* Response body validation
* Schema validation
* Collection validation
* Duplicate ID validation
* JSONPath validations
* Tag-based execution
* Parallel execution

## E2E User Flow

```text
Create User
→ Get User Details
→ Update User
→ Verify Updated Data
→ Delete User
→ Verify Deleted User Cannot Login
```

Reusable user operations are stored in:

```text
utils/user_account_snippets.feature
```

## Dynamic Test Data

Unique user emails are generated through `DataGenerator.java` to avoid conflicts between executions.

Example:

```text
qa.automation.<timestamp>@test.com
```

Update values are stored externally in:

```text
utils/user_update_data.json
```

This keeps test data separated from test logic.

## API Response Behavior

Some Automation Exercise APIs return HTTP `200` even when the business response represents an error.

Example:

```json
{
  "responseCode": 404,
  "message": "User not found!"
}
```

For that reason, tests validate both:

```gherkin
Then status 200
And match response.responseCode == 404
```

## Environment Stability

The public Automation Exercise environment may intermittently return:

```text
503 Service Unavailable
```

with:

```text
This website is under heavy load (queue full)
```

These responses are treated as environment availability failures and are not accepted as valid functional results.

Some requests may also have high response times when the public server is under load.

## Test Data Considerations

Missing and empty parameters are tested differently because the API may return different responses for:

```text
email missing
```

versus:

```text
email=
```

The User Detail endpoint also does not return every field accepted by the Create or Update Account APIs. For example, `mobile_number` can be sent but may not be returned in the user-detail response.

## Running the Tests

Windows:

```bash
gradlew clean test
```

Linux/macOS:

```bash
./gradlew clean test
```

Run by tag:

```bash
./gradlew test -Dkarate.options="--tags @smoke"
```

Other available tags include:

```text
@negative
@regression
@e2e
@products
@brands
@search
@auth
@users
```

## Reporting

Karate reports:

```text
build/karate-reports/
```

Cucumber HTML reports:

```text
build/cucumber-html-reports/
```

## CI

GitHub Actions runs the automated tests on push and pull requests.

The pipeline:

```text
Checkout
→ Setup Java
→ Setup Gradle
→ Run Tests
→ Generate Reports
→ Upload Reports
```

Reports are uploaded even when tests fail to support troubleshooting.
