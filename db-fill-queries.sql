INSERT INTO "user_activity_type" ("id", "title")
VALUES (1, 'Login'),
       (2, 'Logout'),
       (3, 'Task Completed');

INSERT INTO "department" ("id", "title")
VALUES (1, 'HR'),
       (2, 'Engineering'),
       (3, 'Sales'),
       (4, 'Management');

INSERT INTO "issue_type" ("id", "title")
VALUES (1, 'Bug'),
       (2, 'Feature'),
       (3, 'Task');

INSERT INTO "issue_status" ("id", "title")
VALUES (1, 'Open'),
       (2, 'In Progress'),
       (3, 'Resolved');

INSERT INTO "account" ("id", "title", "key")
VALUES (1, 'Company A', 'A123'),
       (2, 'Company B', 'B456');

INSERT INTO "employee_role" ("id", "departmentId", "title")
VALUES (1, 2, 'Software Engineer'),
       (2, 1, 'HR Manager'),
       (3, 3, 'Sales Representative'),
       (4, 4, 'Admin');

INSERT INTO "user" ("id", "name", "key", "email", "roleId", "startWorksAt", "endWorksAt", "password")
VALUES (1, 'John Doe', 'johndoe', 'johndoe@example.com', 1, NULL, NULL, 'password123'),
       (2, 'Jane Smith', 'janesmith', 'janesmith@example.com', 2, NULL, NULL, 'password456'),
       (3, 'Admin', 'admin', 'admin@admin.com', 4, NULL, NULL, 'password456');

INSERT INTO "project" ("id", "key", "name", "leadId", "accountId", "departmentId")
VALUES (1, 'PROJ123', 'Project A', 1, 1, 2),
       (2, 'PROJ456', 'Project B', NULL, 2, 3);

INSERT INTO "version" ("id", "title", "isArchived", "isReleased", "projectId", "startDate", "releaseDate")
VALUES (1, 'Version 1.0', FALSE, TRUE, 1, CURRENT_TIMESTAMP, NULL),
       (2, 'Version 2.0', FALSE, FALSE, 1, CURRENT_TIMESTAMP, NULL);

INSERT INTO "user_activity" ("id", "userId", "activityTypeId")
VALUES (1, 1, 1),
       (2, 2, 2);

INSERT INTO "project_sales_users" ("id", "projectId", "userId")
VALUES (1, 1, 2),
       (2, 2, 1);

INSERT INTO "issue" ("id", "typeId", "key", "summary", "versionId", "hoursEstimated", "assigneeId", "dueDate",
                     "description", "statusId")
VALUES (1, 1, 'BUG-001', 'Critical bug in the system', 1, 8.5, 1, NULL,
        'This is a critical bug that needs immediate attention.', 1),
       (2, 2, 'FEATURE-001', 'New feature request', 2, 16.0, NULL, NULL,
        'We need to implement this new feature for our users.', 1);

INSERT INTO "worklog" ("id", "authorId", "timeSpent", "issueId")
VALUES (1, 1, 3600, 1),
       (2, 2, 1800, 2),
       (3, 1, 9000, 1),
       (4, 2, 7200, 2);

INSERT INTO "user_salary" ("id", "userId", "salary", "period")
VALUES (1, 1, 400, make_date(2023, 6, 1)),
       (2, 2, 500, make_date(2023, 6, 1)),
       (3, 1, 400, make_date(2023, 7, 1)),
       (4, 2, 600, make_date(2023, 7, 1));