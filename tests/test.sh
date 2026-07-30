#!/bin/bash

echo "Running SQL Assignment Test..."

rm -f CollegeDB.db

sqlite3 CollegeDB.db < starter/solution.sql

TABLE_EXISTS=$(sqlite3 CollegeDB.db "
SELECT count(*)
FROM sqlite_master
WHERE type='table'
AND name='Department';
")

if [ "$TABLE_EXISTS" -eq 1 ]
then
    echo "✓ Department table created."
else
    echo "✗ Department table not created."
    exit 1
fi

COLUMN_COUNT=$(sqlite3 CollegeDB.db "
PRAGMA table_info(Department);
" | wc -l)

if [ "$COLUMN_COUNT" -eq 3 ]
then
    echo "✓ Correct number of columns."
else
    echo "✗ Incorrect number of columns."
    exit 1
fi

PK=$(sqlite3 CollegeDB.db "
PRAGMA table_info(Department);
" | awk -F'|' '$2=="DepartmentID"{print $6}')

if [ "$PK" -eq 1 ]
then
    echo "✓ DepartmentID is Primary Key."
else
    echo "✗ DepartmentID is NOT Primary Key."
    exit 1
fi

echo "All tests passed."

exit 0
