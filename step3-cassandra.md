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
 <a href='command:katapod.loadPage?[{"step":"step2-cassandra"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count"> Step 3 of 4</span>
 <a href='command:katapod.loadPage?[{"step":"step4-cassandra"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Create, populate, and query a "bad" table</div>

In order to demonstrate a little bit more about clustering columns, we are first going to show you upserts.

✅ To become an upsert ninja, create the following (bad) table with the (crummy) primary key:
```
CREATE TABLE bad_videos_by_tag_year (
  tag text,
  added_year int,
  added_date timestamp,
  title text,
  description text,
  user_id uuid,
  video_id timeuuid,
  PRIMARY KEY ((video_id))
);
```

✅ As an aside, use `DESCRIBE TABLE` to view the structure of your `bad_videos_by_tag_year` table:
```
DESCRIBE bad_videos_by_tag_year ;
```

NOTE: Notice the column order differs from the `CREATE TABLE` statement. Cassandra orders columns by partition key, clustering columns (shown later), and then alphabetical order of the remaining columns.


✅ Execute the following `COPY` command to import `videos_by_tag_year.csv` file:
```
COPY bad_videos_by_tag_year (tag, added_year, video_id, added_date, description, title, user_id) 
FROM 'assets/videos_by_tag_year.csv' WITH HEADER=true;
```

NOTE: We must explicitly list the column names because this table schema no longer matches the CSV structure.

✅ Now `COUNT()` the number of rows in the `bad_videos_by_tag_year`:
```
SELECT COUNT(*)
FROM bad_videos_by_tag_year;
```

Notice the number of rows in the `bad_videos_by_tag_year` does not match the number of rows imported from `videos_by_tag_year.csv`. Since `videos_by_tag_year.csv` duplicates `video_id` for each unique `tag` and `year` per video, Cassandra upserted several records during the `COPY`. `video_id` is not a proper partition key for this scenario.


✅ Drop the bad table:
```
DROP TABLE bad_videos_by_tag_year;
```

Your mission is to restructure your table and allow users to query on `tag` and possible `added_year` ranges while avoiding upserts on import. You must also return your results in descending order of year.

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step2-cassandra"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"step4-cassandra"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
