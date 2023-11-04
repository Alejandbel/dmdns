SELECT "user"."name", "employee_role"."title"
FROM "user"
         INNER JOIN "employee_role" ON "user"."roleId" = "employee_role"."id";

SELECT "project"."name", "department"."title"
FROM "project"
         INNER JOIN "department" ON "project"."departmentId" = "department"."id";

SELECT "issue"."key", "issue_status"."title"
FROM "issue"
         INNER JOIN "issue_status" ON "issue"."statusId" = "issue_status"."id";

SELECT "issue"."key", SUM("worklog"."timeSpent") AS "totalTimeSpent"
FROM "issue"
         LEFT JOIN "worklog" ON "issue"."id" = "worklog"."issueId"
GROUP BY "issue"."key";

SELECT "issue"."key", "issue"."hoursEstimated", SUM("worklog"."timeSpent") AS "totalTimeSpent"
FROM "issue"
         LEFT JOIN "worklog" ON "issue"."id" = "worklog"."issueId"
GROUP BY "issue"."key", "issue"."hoursEstimated"
HAVING "issue"."hoursEstimated" * 3600 < SUM("worklog"."timeSpent");

SELECT "user"."name"
FROM "user"
         INNER JOIN "worklog" ON "user"."id" = "worklog"."authorId";

SELECT "user"."name"
FROM "user"
         INNER JOIN "worklog" ON "user"."id" = "worklog"."authorId";

SELECT "user"."name"
FROM "user"
         INNER JOIN "project_sales_users" ON "user"."id" = "project_sales_users"."userId"
         INNER JOIN "project" ON "project_sales_users"."projectId" = "project"."id"
WHERE "project"."departmentId" = 3;

