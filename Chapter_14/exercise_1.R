# Exercise 1: reading and querying a web API

# Load the httr and jsonlite libraries for accessing data
# You can also load `dplyr` if you wish to use it
# Load libraries
library(httr)
library(jsonlite)
library(dplyr)

# Create a variable base_uri that stores the base URI (as a string) for the 
# Github API (https://api.github.com)
# Set base URI for Github API
base_uri <- "https://api.github.com"

# Under the "Repositories" category of the API documentation, find the endpoint 
# that will list _repos in an organization_. Then create a variable named
# `org_resource` that stores the endpoint for the `programming-for-data-science`
# organization repos (this is the _path_ to the resource of interest).
# Set endpoint for programming-for-data-science organization repos
org_resource <- "/orgs/programming-for-data-science/repos"

# Send a GET request to this endpoint (the `base_uri` followed by the 
# `org_resource` path). Print the response to show that your request worked. 
# (The listed URI will also allow you to inspect the JSON in the browser easily).
# Send GET request to endpoint and print response
response <- GET(paste0(base_uri, org_resource))
print(response)

# Extract the content of the response using the `content()` function, saving it
# in a variable.
# Extract content of response and convert from JSON to data frame
content <- content(response, as = "text", encoding = "UTF-8")


# Convert the content variable from a JSON string into a data frame.
data <- fromJSON(content)

# How many (public) repositories does the organization have?
# Compute number of public repositories in organization
num_repos <- nrow(data)

# Now a second query:
# Create a variable `search_endpoint` that stores the endpoint used to search 
# for repositories. (Hint: look for a "Search" endpoint in the documentation).
# Set endpoint for searching repositories
search_endpoint <- "/search/repositories"

# Search queries require a query parameter (for what to search for). Create a 
# `query_params` list variable that specifies an appropriate key and value for 
# the search term (you can search for anything you want!)
# Set query parameters for search
query_params <- list(q = "data science")

# Send a GET request to the `search_endpoint`--including your params list as the
# `query`. Print the response to show that your request worked.
# Send GET request to search endpoint with query parameters and print response
response <- GET(paste0(base_uri, search_endpoint), query = query_params)
print(response)

# Extract the content of the response and convert it from a JSON string into a
# data frame. 
# Extract content of response and convert from JSON to data frame
content <- content(response, as = "text", encoding = "UTF-8")
data <- fromJSON(content)

# How many search repos did your search find? (Hint: check the list names to 
# find an appropriate value).
# Compute number of search results
num_results <- data$total_count

# What are the full names of the top 5 repos in the search results?
# Get full names of top 5 repos in search results
top_5_repos <- data$items %>% head(5) %>% select(full_name)


























