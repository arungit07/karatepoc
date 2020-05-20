

# This is POC for karate framework done with maven karate archetype. Automation is done with gorestapi user modeule:  https://gorest.co.in/public-data/users.html
# Clone the repo and run the test with maven
# Now configured to run with Junit5 parallel runner
# Reports by maven cucumber reporting dependency other than the other default ones. Now configured to run with parallel runner
#Types of methods covered: GET, POST,PUT and DELETE


Project details

User module of gorest have functionalities like user listing in table, user creation, user update, user view and user delete. In this POC
seperate feaure files have been created for each of the above functioanlities. The test cases for each functionalities are covered as feature scenarios.
A module level Junit5runner for running features of a module , a test suite Junit runner for runnining all features irrespective of the modules and a parallel runner
for parallel execution have been implemented.
