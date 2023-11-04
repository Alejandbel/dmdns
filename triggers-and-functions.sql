CREATE OR REPLACE FUNCTION "get_user_last_salary_change_date"("user_id" BIGINT)
    RETURNS TIMESTAMP AS
$$
SELECT MAX("subquery"."period")
FROM (SELECT "us"."period",
             "us"."salary",
             LAG("us"."salary") OVER (ORDER BY "us"."createdAt") AS "previous_salary"
      FROM "user_salary" AS "us"
      WHERE "us"."userId" = "user_id") "subquery"
WHERE "subquery"."salary" != "previous_salary"
   OR "previous_salary" IS NULL;
$$ LANGUAGE "sql";


CREATE OR REPLACE FUNCTION "update_next_user_salary"() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE "user_salary" "us"
    SET "salary" = "new"."salary"
    WHERE "us"."period" > "new"."period"
      AND "us"."userId" = "new"."userId";

    RETURN "new";
END
$$ LANGUAGE "plpgsql";

CREATE OR REPLACE TRIGGER "update_next_user_salary_trigger"
    AFTER UPDATE OF "salary"
    ON "user_salary"
    FOR EACH ROW
    WHEN (PG_TRIGGER_DEPTH() < 1)
EXECUTE FUNCTION "update_next_user_salary"();


CREATE OR REPLACE FUNCTION "log_user_worklog_deleted_action"() RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO "user_activity" ("userId", "activityTypeId")
    VALUES ("old"."userId",
            (SELECT "activityTypeId" FROM "user_activity_type" "type" WHERE "type"."title" = 'Worklog deleted'));
    RETURN "old";
END
$$ LANGUAGE "plpgsql";

CREATE OR REPLACE TRIGGER "log_user_worklog_deleted_action_trigger"
    AFTER DELETE
    ON "worklog"
    FOR EACH ROW
EXECUTE FUNCTION "log_user_worklog_deleted_action"();


CREATE OR REPLACE FUNCTION "log_user_worklog_updated_action"() RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO "user_activity" ("userId", "activityTypeId")
    VALUES ("old"."userId",
            (SELECT "activityTypeId" FROM "user_activity_type" "type" WHERE "type"."title" = 'Worklog updated'));
    RETURN "old";
END
$$ LANGUAGE "plpgsql";

CREATE OR REPLACE TRIGGER "log_user_worklog_deleted_action_trigger"
    AFTER UPDATE
    ON "worklog"
    FOR EACH ROW
EXECUTE FUNCTION "log_user_worklog_updated_action"();


CREATE OR REPLACE FUNCTION "log_user_worklog_created_action"() RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO "user_activity" ("userId", "activityTypeId")
    VALUES ("old"."userId",
            (SELECT "activityTypeId" FROM "user_activity_type" "type" WHERE "type"."title" = 'Worklog created'));
    RETURN "old";
END
$$ LANGUAGE "plpgsql";

CREATE OR REPLACE TRIGGER "log_user_worklog_deleted_action_trigger"
    AFTER UPDATE
    ON "worklog"
    FOR EACH ROW
EXECUTE FUNCTION "log_user_worklog_created_action"();
