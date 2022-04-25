SELECT
    *
WHERE
    sr_type LIKE "Fly Dumping Complaint"
    OR sr_type LIKE "Garbage Cart Maintenance"
    OR sr_type LIKE "Missed Garbage Pick-Up Complaint"
    OR sr_type LIKE "Yard Waste Pick-Up Request"
    OR sr_type LIKE "Street Cleaning Request"
LIMIT
    10000000000