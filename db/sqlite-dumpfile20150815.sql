BEGIN TRANSACTION;
CREATE TABLE "schema_migrations" ("version" text NOT NULL);
INSERT INTO "schema_migrations" VALUES('20150811125239');
INSERT INTO "schema_migrations" VALUES('20150811130945');
INSERT INTO "schema_migrations" VALUES('20150811130953');
INSERT INTO "schema_migrations" VALUES('20150823101843');
CREATE TABLE "users" ("id" SERIAL PRIMARY KEY NOT NULL, "name" text, "image" text, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "users" VALUES(1,'Karl','maya/10.jpg','2015-08-11 13:31:26.904145','2015-08-23 22:58:48.595278');
INSERT INTO "users" VALUES(2,'Marion','maya/13.jpg','2015-08-11 13:31:27.010622','2015-08-23 22:58:48.615075');
INSERT INTO "users" VALUES(5,'Borja','maya/5.jpg','2015-08-11 16:33:51.024480','2015-08-23 22:58:48.632666');
INSERT INTO "users" VALUES(7,'Mango','maya/3.jpg','2015-08-11 16:35:17.204950','2015-08-23 22:58:48.655980');
INSERT INTO "users" VALUES(9,'Bustoja','maya/1.jpg','2015-08-11 16:43:01.999264','2015-08-23 22:58:48.672127');
INSERT INTO "users" VALUES(10,'Levtanim','maya/15.jpg','2015-08-11 16:43:43.653152','2015-08-23 22:58:48.688941');
INSERT INTO "users" VALUES(11,'Lupinada','maya/2.jpg','2015-08-11 16:44:19.394618','2015-08-23 22:58:48.712151');
INSERT INTO "users" VALUES(12,'Jupijada','maya/6.jpg','2015-08-11 16:45:00.542995','2015-08-23 22:58:48.740625');
CREATE TABLE "searches" ("id" SERIAL PRIMARY KEY NOT NULL, "description" text, "user_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL);
INSERT INTO "searches" VALUES(1,'Hello I''m searching for food',1,'2015-08-11 13:31:26.990153','2015-08-11 13:31:26.990153');
INSERT INTO "searches" VALUES(2,'I llok for art',2,'2015-08-11 13:31:27.027553','2015-08-11 13:31:27.027553');
CREATE TABLE "offers" ("id" SERIAL PRIMARY KEY NOT NULL, "description" text, "user_id" integer, "created_at" timestamp NOT NULL, "updated_at" timestamp NOT NULL, "image" text);
INSERT INTO "offers" VALUES(1,'Helping you with your bicycle',1,'2015-08-11 13:31:26.943308','2015-08-23 22:48:34.435634','geo/8.jpg');
INSERT INTO "offers" VALUES(2,'I offer you tea',1,'2015-08-11 13:31:26.962206','2015-08-23 22:48:56.243926','geo/3.jpg');
INSERT INTO "offers" VALUES(3,'I have two tickets for Madonna',2,'2015-08-11 18:31:26.962206','2015-08-23 22:49:44.196198','geo/6.jpg');
INSERT INTO "offers" VALUES(4,'Hello I offer random',1,'2015-08-23 10:34:44.960409','2015-08-23 22:50:14.212374','geo/1.jpg');
INSERT INTO "offers" VALUES(9,'Helesana wikonaka',1,'2015-08-23 10:46:01.216474','2015-08-23 22:50:27.780502','geo/6.jpg');
DELETE FROM sqlite_sequence;
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
COMMIT;
