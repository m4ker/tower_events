CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "teams" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(100) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE 'users' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'email' varchar(100) NOT NULL, 'name' varchar(100) NOT NULL, 'created_at' DATETIME NOT NULL, 'updated_at' DATETIME NOT NULL);
CREATE TABLE 'team_user' ( 'team_id' INTEGER NOT NULL, 'user_id' INTEGER NOT NULL );
CREATE TABLE 'projects' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'team_id' INTEGER NOT NULL, 'name' varchar(100) NOT NULL, 'created_at' DATETIME NOT NULL, 'updated_at' DATETIME NOT NULL);
CREATE TABLE 'access' ('project_id' INTEGER NOT NULL, 'user_id' INTEGER NOT NULL);
CREATE TABLE 'todos' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' varchar(100) NOT NULL, 'description' TEXT, 'user_id' INTEGER NOT NULL, 'owner_id' INTEGER, 'deadline' DATETIME, 'status' INTEGER NOT NULL, 'created_at' DATETIME NOT NULL, 'updated_at' DATETIME NOT NULL);
CREATE TABLE 'comments' ('id' INTEGER PRIMARY KEY NOT NULL, 'todo_id' INTEGER NOT NULL, 'user_id' INTEGER NOT NULL, 'content' TEXT NOT NULL, 'created_at' DATETIME NOT NULL, 'updated_at' DATETIME NOT NULL);
CREATE TABLE 'events' (
'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
'team_id' INTEGER NOT NULL, 'project_id' INTEGER NOT NULL, 
'user_id' INTEGER NOT NULL, 'username' varchar(100) NOT NULL, 
'action' varchar(40) NOT NULL, 'object' varchar(40), 
'object_id' INTEGER,
 'title' varchar(100), 
'content' TEXT, 
'data' TEXT, 
'created_at' DATETIME NOT NULL, 
'updated_at' DATETIME NOT NULL);

