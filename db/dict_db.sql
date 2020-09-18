BEGIN TRANSACTION;
CREATE TABLE `words` (
	`id`	INTEGER,
	`name`	TEXT,
	PRIMARY KEY(id)
);
INSERT INTO `words` VALUES (1,'Wongela');
INSERT INTO `words` VALUES (2,'Wuletaw');
INSERT INTO `words` VALUES (3,'Wonte');
COMMIT;
