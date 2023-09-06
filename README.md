# DATA MODELS AND DATABASE MANAGEMENT SYSTEMS
## Topic: tracking system

### Functional Requirements
* User authorization. Roles USER, SALES, PM, ADMIN
* User Management (CRUD).
* The role system.
* Logging user actions.
* Issue CRUD (USER)
* Worklog CRUD (USER)
* Projects CRUD (SALES)
* Departments CRUD (Admin)
* Project statistics (PM)
* Issues-scope system

### Entities
1. "worklog"
    * "id" BIGINT NOT NULL, PK
    * "authorId" BIGINT NOT NULL, -> user
    * "timeSpent" BIGINT NOT NULL,
    * "issueId" BIGINT NOT NULL,
    * "createdAt" DATE,
    * "updatedAt" DATE
2. "account"
    "id" BIGINT NOT NULL, PK
    "title" TEXT NOT NULL,
    "type" VARCHAR(255),
    "key" TEXT NULL,
    "createdAt" DATE,
    "updatedAt" DATE
3. "project"
    * "id" BIGINT NOT NULL, PK
    * "key" TEXT NOT NULL,
    * "name" TEXT NOT NULL,
    * "leadId" BIGINT NULL, -> user
    * "accountId" BIGINT NULL, -> account
    * "departmentId" BIGINT NULL, -> department
    * "createdAt" DATE,
    * "updatedAt" DATE
4. "employee_role"
    * "id" BIGINT NOT NULL, PK
    * "departmentId" BIGINT NULL, -> department
    * "name" TEXT NOT NULL,
    * "createdAt" DATE,
    * "updatedAt" DATE
5. "issue"
    * "id" BIGINT NOT NULL, PK
    * "type" VARCHAR(255),
    * "versionId" BIGINT NOT NULL, -> version
    * "description" TEXT NULL,
    * "status" VARCHAR(255),
    * "createdAt" DATE,
    * "updatedAt" DATE
6. "department"
    * "id" BIGINT NOT NULL, PK
    * "leadId" BIGINT NOT NULL, -> user
    * "createdAt" DATE,
    * "updatedAt" DATE
7. "user"
    * "id" BIGINT NOT NULL, PK
    * "name" TEXT NOT NULL,
    * "key" TEXT NOT NULL,
    * "email" TEXT NOT NULL,
    * "departmentId" BIGINT NULL, -> department
    * "role" VARCHAR(255) CHECK
    * "createdAt" DATE,
    * "updatedAt" DATE
8. "version"
    * "id" BIGINT NOT NULL, PK
    * "title" TEXT NOT NULL,
    * "isArchived" BOOLEAN NOT NULL DEFAULT '0',
    * "isReleased" BOOLEAN NOT NULL DEFAULT '0',
    * "projectId" BIGINT NOT NULL, -> project
    * "startDate" DATE,
    * "releaseDate" DATE,
    * "createdAt" DATE,
    * "updatedAt" DATE
9. "user_activity"
    * "id" BIGINT NOT NULL, PK
    * "userId" BIGINT NOT NULL, -> user
    * "activityType" VARCHAR(255),
    * "createdAt" DATE,
    * "updatedAt" DATE
10. "project_sales_users"
    * "id" BIGINT NOT NULL, PK
    * "projectId" BIGINT NOT NULL -> project
    * "userId" BIGINT NOT NULL -> user
);
   
