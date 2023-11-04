CREATE OR REPLACE VIEW "v_salary_change_date"
AS
SELECT "subquery"."userId", MAX("subquery"."period") AS "lastSalaryChangeDate"
FROM (SELECT "us"."period",
             "us"."salary",
             "us"."userId",
             LAG("us"."salary") OVER (PARTITION BY "userId" ORDER BY "us"."createdAt") AS "previous_salary"
      FROM "user_salary" AS "us") "subquery"
WHERE "subquery"."salary" != "previous_salary"
   OR "previous_salary" IS NULL
GROUP BY "subquery"."userId";

CREATE OR REPLACE VIEW "v_issue_total_time" AS
SELECT "issue"."id"                            AS "issueId",
       COALESCE(SUM("worklog"."timeSpent"), 0) AS "totalTimeSpent"
FROM "issue"
         LEFT JOIN "worklog" ON "worklog"."issueId" = "issue"."id"
         INNER JOIN "user" ON "worklog"."authorId" = "user"."id"
GROUP BY "issue"."id";