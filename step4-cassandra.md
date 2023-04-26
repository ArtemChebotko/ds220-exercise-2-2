<!-- TOP -->
<div class="top">
  <img class="scenario-academy-logo" src="https://datastax-academy.github.io/katapod-shared-assets/images/ds-academy-2023.svg" />
  <div class="scenario-title-section">
    <span class="scenario-title">Exercise 2.2: Clustering Columns</span>
    <span class="scenario-subtitle">ℹ️ For technical support, please contact us via <a href="mailto:academy@datastax.com">email</a>.</span>
  </div>
</div>


<!-- NAVIGATION -->
<div id="navigation-top" class="navigation-top">
 <a href='command:katapod.loadPage?[{"step":"step3-cassandra"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count"> Step 4 of 4</span>
 <a href='command:katapod.loadPage?[{"step":"finish-cassandra"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Create, populate, and query a "good" table</div>

✅ Create a correct table to facilitate querying for videos by tag within a given year range returning the results in descending order by year:
```
CREATE TABLE videos_by_tag_year ( 
  tag text,
  added_year int,
  video_id timeuuid,
  added_date timestamp,
  description text,
  title text,
  user_id uuid,
  PRIMARY KEY ((tag), added_year, video_id)
) WITH CLUSTERING ORDER BY (added_year desc, video_id asc);
```

✅ Execute the following `COPY` command to import `videos_by_tag_year.csv` file:
```
COPY videos_by_tag_year (tag, added_year, video_id, added_date, description, title, user_id) 
FROM 'assets/videos_by_tag_year.csv' WITH HEADER=true;
```

✅ Check the number of rows in the `videos_by_tag_year` table:
```
SELECT COUNT(*)
FROM videos_by_tag_year;
```

NOTE: The number of rows should match the number of rows imported by the `COPY` command. If not, you had upserts again and will need to adjust your `PRIMARY KEY`. Ask your instructor for help if necessary.

✅ Try running queries on the `videos_by_tag_year` table to query on a specific tag and added year.:
```
SELECT * FROM videos_by_tag_year WHERE tag = 'trailer' AND added_year = 2015;
SELECT * FROM videos_by_tag_year WHERE tag = 'cql' AND added_year = 2014;
SELECT * FROM videos_by_tag_year WHERE tag = 'spark' AND added_year = 2014;
```

✅ Try querying for all videos with tag `cql` added before the year `2015`. Notice you can do range queries on clustering columns.
```
SELECT * FROM videos_by_tag_year WHERE tag = 'cql' AND added_year < 2015;
```

✅ Try querying for all videos added before `2015`. The query will fail. What error message does cqlsh report? Why did the query fail whereas the previous query worked?
```
SELECT * FROM videos_by_tag_year WHERE added_year < 2015;
```

This fails because the partition column `tag`
was not queried, which would mean all of the
partitions in the table would have to be filtered to get the results for the query.


<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step3-cassandra"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"finish-cassandra"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
