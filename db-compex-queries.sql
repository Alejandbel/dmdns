SELECT "user"."name",
       "issue"."id"                            AS "issueId",
       "issue"."summary"                       AS "summary",
       COALESCE(SUM("worklog"."timeSpent"), 0) AS "totalTimeSpent"
FROM "issue"
         LEFT JOIN "worklog" ON "worklog"."issueId" = "issue"."id"
         INNER JOIN "user" ON "worklog"."authorId" = "user"."id"
GROUP BY "user"."name", "issue"."id", "issue"."summary";

SELECT "user"."name", "project"."name"
FROM "user"
         FULL JOIN "project" ON "user"."id" = "project"."leadId";

SELECT "user"."name", "department"."title"
FROM "user"
         CROSS JOIN "department";

-- users with same role
SELECT "u1"."id", "u1"."name" AS "firstUserName", JSON_AGG(ROW_TO_JSON("u2"))
FROM "user" "u1"
         LEFT JOIN "user" "u2" ON "u1"."roleId" = "u2"."roleId" AND "u1"."id" != "u2"."id"
GROUP BY "u1"."name", "u1"."id";


-- projects spent time
EXPLAIN
SELECT "p"."id"             AS "projectId",
       "p"."name"           AS "name",
       AVG("w"."timeSpent") AS "averageTimeSpent",
       MAX("w"."timeSpent") AS "maxTimeSpent",
       SUM("w"."timeSpent") AS "totalTimeSpent"
FROM "project" "p"
         LEFT JOIN "version" "v" ON "v"."projectId" = "p"."id"
         LEFT JOIN "issue" "i" ON "i"."versionId" = "v"."id"
         LEFT JOIN "worklog" "w" ON "w"."issueId" = "i"."id"
GROUP BY "p"."id";

-- underestimated issues
SELECT "issue"."id",
       "issue"."summary",
       "issue"."description",
       "issue"."hoursEstimated",
       SUM("worklog"."timeSpent") / 3600.0 AS "totalTimeSpent"
FROM "issue"
         INNER JOIN "worklog" ON "issue"."id" = "worklog"."issueId"
GROUP BY "issue"."id", "issue"."summary", "issue"."description", "issue"."hoursEstimated"
HAVING SUM("worklog"."timeSpent") > "issue"."hoursEstimated" * 3600;

-- full day logged
UPDATE "user_salary" "us"
SET "salary" = "salary" * 1.1
WHERE "us"."userId" IN (SELECT "user"."id"
                        FROM "user"
                                 LEFT JOIN "user_salary" "us" ON "user"."id" = "us"."userId"
                                 LEFT JOIN "worklog" ON "user"."id" = "worklog"."authorId"
                        WHERE "worklog"."createdAt"::"date" = CURRENT_DATE - INTERVAL '1 day'
                        GROUP BY "user"."id", "user"."name"
                        HAVING SUM("worklog"."timeSpent") = 8 * 60 * 60)