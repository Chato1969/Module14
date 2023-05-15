# Exercise 2: working with data APIs

# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
# Load API key from apikey.R file
source("apikey.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "The Matrix"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
# Set movie name
movie_name <- "The Matrix"

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
# Construct HTTP request
base_uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
query <- paste0("query=", movie_name)
api_key_param <- paste0("api-key=", api_key)
request_uri <- paste0(base_uri, resource, "?", query, "&", api_key_param)

# What kind of data structure did this produce? A data frame? A list?
# Send HTTP request and extract content
response <- httr::GET(request_uri)
content <- httr::content(response, as = "text", encoding = "UTF-8")
data <- jsonlite::fromJSON(content)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
# Inspect data structure
class(data)
names(data)
str(data)

# Flatten the movie reviews content into a data structure called `reviews`
# Flatten movie reviews content
reviews <- data$results

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
# Store information from most recent review
headline <- reviews[[1]]$headline
summary <- reviews[[1]]$summary_short
link <- reviews[[1]]$link$url

# Create a list of the three pieces of information from above. 
# Print out the list.
# Create list of information and print it
review_info <- list(headline = headline, summary = summary, link = link)
print(review_info)



















