# Mapping Garbage-Related 311 Complaints in Chicago

When a few of my colleagues volunteered to pick up trash in Humboldt Park for Earth Day, they noticed that areas around bus stops and highway ramps are often full of trash. We wanted to investigate where these kinds of issues arise the most, but found no specific complaint category for litter. I'll attempt to provide some context to this story by using a handful of garbage-related complaint categories and mapping them. 

## The Data

The data used in this project is from the [Chicago Data Portal's 311 service requests dataset](https://data.cityofchicago.org/Service-Requests/311-Service-Requests/v6vf-nfxy).

I am using the following complaint categories, derived from [frozen/distinct_311_sr_types.txt](frozen/distinct_311_sr_types.txt):
- "Fly Dumping Complaint"
- "Garbage Cart Maintenance"
- "Missed Garbage Pick-Up Complaint"
- "Yard Waste Pick-Up Request"
- "Street Cleaning Request"

Final data files in [output/](output/) are used to populate Datawrapper maps:
- [By Census Tract (total)](https://datawrapper.dwcdn.net/bZ7Vc)
- [By Census Tract (per 1,000 residents)](https://datawrapper.dwcdn.net/2k7as)
- [By Neighborhood (total)](https://datawrapper.dwcdn.net/b4sfE)
