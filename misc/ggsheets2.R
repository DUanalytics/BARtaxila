
library(googlesheets4)

read_sheet(as_sheets_id("1BOuN7xu60VPFjlN6HU1QN2spQJcwwCiLoSMPQ9HZwmo"))

read_sheet(as_sheets_id("16nPAtCUXzy2r1gNlKV4IGiJYQwlMDef7IASWIOWQqYo"))
sheets_examples()


library(googledrive)
(deaths <- drive_get("deaths"))
