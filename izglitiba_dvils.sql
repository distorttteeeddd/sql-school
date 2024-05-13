-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               8.0.30 - MySQL Community Server - GPL
-- Операционная система:         Win64
-- HeidiSQL Версия:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дамп структуры базы данных izglitibas_programmas
DROP DATABASE IF EXISTS `izglitibas_programmas`;
CREATE DATABASE IF NOT EXISTS `izglitibas_programmas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `izglitibas_programmas`;

-- Дамп структуры для таблица izglitibas_programmas.audzekni
CREATE TABLE IF NOT EXISTS `audzekni` (
  `personas_kods` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `vards` varchar(30) DEFAULT NULL,
  `uzvards` varchar(30) DEFAULT NULL,
  `talrunis` int DEFAULT NULL,
  `adrese` varchar(200) DEFAULT NULL,
  `dzimsanas_diena` date DEFAULT NULL,
  `grupasID` int DEFAULT NULL,
  PRIMARY KEY (`personas_kods`),
  KEY `FK1` (`grupasID`),
  CONSTRAINT `FK1` FOREIGN KEY (`grupasID`) REFERENCES `grupas` (`grupasID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.audzekni: ~5 rows (приблизительно)
INSERT INTO `audzekni` (`personas_kods`, `vards`, `uzvards`, `talrunis`, `adrese`, `dzimsanas_diena`, `grupasID`) VALUES
	('111111-11111', 'Jānis', 'Pēteris', 26345683, 'LV-1010 Rīga, Brīvības iela 34-5', '2000-01-01', 22),
	('222222-22222', 'Anna', 'Bērziņa', 26345684, 'LV-1010 Rīga, Lāčplēša iela 12', '2001-02-02', 22),
	('333333-33333', 'Kārlis', 'Ozoliņš', 26345685, 'LV-1010 Rīga, Avotu iela 56', '2002-03-03', 22),
	('444444-44444', 'Dace', 'Liepiņa', 26345686, 'LV-1010 Rīga, Krišjāņa Barona iela 14', '2003-04-04', 24),
	('555555-55555', 'Ilze', 'Ziediņa', 26345687, 'LV-1010 Rīga, Elizabetes iela 10', '2004-05-05', 24);

-- Дамп структуры для таблица izglitibas_programmas.diploma_vertejumi
CREATE TABLE IF NOT EXISTS `diploma_vertejumi` (
  `vertejumaID` int NOT NULL,
  `vertejums` varchar(3) DEFAULT NULL,
  `audzeknuPK` varchar(12) DEFAULT NULL,
  `prieksmetID` int DEFAULT NULL,
  PRIMARY KEY (`vertejumaID`),
  KEY `FK_diploma_vertejumi_audzekni` (`audzeknuPK`),
  KEY `FK_diploma_vertejumi_prieksmeti` (`prieksmetID`),
  CONSTRAINT `FK_diploma_vertejumi_audzekni` FOREIGN KEY (`audzeknuPK`) REFERENCES `audzekni` (`personas_kods`),
  CONSTRAINT `FK_diploma_vertejumi_prieksmeti` FOREIGN KEY (`prieksmetID`) REFERENCES `prieksmeti` (`priekšmetuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.diploma_vertejumi: ~25 rows (приблизительно)
INSERT INTO `diploma_vertejumi` (`vertejumaID`, `vertejums`, `audzeknuPK`, `prieksmetID`) VALUES
	(1, '5', '111111-11111', 101),
	(2, '6', '111111-11111', 202),
	(3, '7', '111111-11111', 303),
	(4, '8', '111111-11111', 404),
	(5, '9', '111111-11111', 505),
	(6, '4', '222222-22222', 101),
	(7, 'n/v', '222222-22222', 202),
	(8, '6', '222222-22222', 303),
	(9, '8', '222222-22222', 404),
	(10, '9', '222222-22222', 505),
	(11, '6', '333333-33333', 101),
	(12, '8', '333333-33333', 202),
	(13, '7', '333333-33333', 303),
	(14, 'n/v', '333333-33333', 404),
	(15, '8', '333333-33333', 505),
	(16, '8', '444444-44444', 101),
	(17, '9', '444444-44444', 202),
	(18, '7', '444444-44444', 303),
	(19, '6', '444444-44444', 404),
	(20, '5', '444444-44444', 505),
	(21, '7', '555555-55555', 101),
	(22, 'n/v', '555555-55555', 202),
	(23, '9', '555555-55555', 303),
	(24, '8', '555555-55555', 404),
	(25, '5', '555555-55555', 505);

-- Дамп структуры для таблица izglitibas_programmas.grupas
CREATE TABLE IF NOT EXISTS `grupas` (
  `grupasID` int NOT NULL,
  `nosaukums` varchar(50) DEFAULT NULL,
  `izglitib_programmaID` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `audzinatajsID` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`grupasID`),
  KEY `FK_grupas_pedagogi` (`audzinatajsID`),
  KEY `FK_grupas_izglitibas_programmas` (`izglitib_programmaID`) USING BTREE,
  CONSTRAINT `FK_grupas_izglitibas_programmas` FOREIGN KEY (`izglitib_programmaID`) REFERENCES `izglitibas_programmas` (`programmas_kods`),
  CONSTRAINT `FK_grupas_pedagogi` FOREIGN KEY (`audzinatajsID`) REFERENCES `pedagogi` (`personas_kods`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.grupas: ~2 rows (приблизительно)
INSERT INTO `grupas` (`grupasID`, `nosaukums`, `izglitib_programmaID`, `audzinatajsID`) VALUES
	(22, 'DP2-2', '33 484 01 1', '030393-12345'),
	(24, 'DT2-4', '33 483 01 1', '030393-12345');

-- Дамп структуры для таблица izglitibas_programmas.izglitibas_programmas
CREATE TABLE IF NOT EXISTS `izglitibas_programmas` (
  `programmas_kods` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nosaukums` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`programmas_kods`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.izglitibas_programmas: ~2 rows (приблизительно)
INSERT INTO `izglitibas_programmas` (`programmas_kods`, `nosaukums`) VALUES
	('33 483 01 1', 'Datorsistēmas, datubāzes un datortīkli'),
	('33 484 01 1', 'Programmēšana');

-- Дамп структуры для таблица izglitibas_programmas.macibu_process
CREATE TABLE IF NOT EXISTS `macibu_process` (
  `macibu_processID` int NOT NULL,
  `semestris` int DEFAULT NULL,
  `teoretisko_stundu_skaits_semestri` int DEFAULT NULL,
  `praktisko_stundu_skaits_semestri` int DEFAULT NULL,
  `grupasID` int DEFAULT NULL,
  `priekšmetaID` int DEFAULT NULL,
  `skolotajsID` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`macibu_processID`),
  KEY `FK_macibu_process_grupas` (`grupasID`) USING BTREE,
  KEY `FK_macibu_process_prieksmeti` (`priekšmetaID`),
  KEY `FK_macibu_process_pedagogi` (`skolotajsID`),
  CONSTRAINT `FK_macibu_process_grupas` FOREIGN KEY (`grupasID`) REFERENCES `grupas` (`grupasID`),
  CONSTRAINT `FK_macibu_process_pedagogi` FOREIGN KEY (`skolotajsID`) REFERENCES `pedagogi` (`personas_kods`),
  CONSTRAINT `FK_macibu_process_prieksmeti` FOREIGN KEY (`priekšmetaID`) REFERENCES `prieksmeti` (`priekšmetuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.macibu_process: ~5 rows (приблизительно)
INSERT INTO `macibu_process` (`macibu_processID`, `semestris`, `teoretisko_stundu_skaits_semestri`, `praktisko_stundu_skaits_semestri`, `grupasID`, `priekšmetaID`, `skolotajsID`) VALUES
	(10101, 1, 20, 50, 22, 101, '010190-12345'),
	(20101, 2, 20, 50, 22, 202, '040494-12345'),
	(30101, 1, 5, 20, 22, 303, '030393-12345'),
	(40101, 2, 40, 70, 24, 404, '020292-12345'),
	(80101, 2, 40, 70, 24, 505, '050595-12345');

-- Дамп структуры для таблица izglitibas_programmas.nozare
CREATE TABLE IF NOT EXISTS `nozare` (
  `nozareID` int NOT NULL,
  `metodiskas_komisijas` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nozareID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.nozare: ~3 rows (приблизительно)
INSERT INTO `nozare` (`nozareID`, `metodiskas_komisijas`) VALUES
	(111111, 'Informācijas un komunikācijas tehnoloģijas'),
	(222222, 'Matemātika un fizika'),
	(333333, 'Audzināšana');

-- Дамп структуры для таблица izglitibas_programmas.pedagogi
CREATE TABLE IF NOT EXISTS `pedagogi` (
  `personas_kods` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `vards` varchar(30) DEFAULT NULL,
  `uzvards` varchar(30) DEFAULT NULL,
  `talrunis` int DEFAULT NULL,
  `darba_stažs_gados` int DEFAULT NULL,
  `nozaresID` int DEFAULT NULL,
  PRIMARY KEY (`personas_kods`),
  KEY `FK_pedagogi_nozare` (`nozaresID`),
  CONSTRAINT `FK_pedagogi_nozare` FOREIGN KEY (`nozaresID`) REFERENCES `nozare` (`nozareID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.pedagogi: ~5 rows (приблизительно)
INSERT INTO `pedagogi` (`personas_kods`, `vards`, `uzvards`, `talrunis`, `darba_stažs_gados`, `nozaresID`) VALUES
	('010190-12345', 'Pēteris', 'Bērziņš', 26345678, 10, 111111),
	('020292-12345', 'Anna', 'Kalniņa', 26345679, 5, 222222),
	('030393-12345', 'Jānis', 'Ozoliņš', 26345680, 7, 333333),
	('040494-12345', 'Dace', 'Liepiņa', 26345681, 3, 111111),
	('050595-12345', 'Ilze', 'Ziediņa', 26345682, 2, 222222);

-- Дамп структуры для таблица izglitibas_programmas.prieksmeti
CREATE TABLE IF NOT EXISTS `prieksmeti` (
  `priekšmetuID` int NOT NULL,
  `nosaukums` varchar(50) DEFAULT NULL,
  `teoretisko_stundu_skaits` int DEFAULT NULL,
  `praktisko_stundu_skaits` int DEFAULT NULL,
  PRIMARY KEY (`priekšmetuID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы izglitibas_programmas.prieksmeti: ~5 rows (приблизительно)
INSERT INTO `prieksmeti` (`priekšmetuID`, `nosaukums`, `teoretisko_stundu_skaits`, `praktisko_stundu_skaits`) VALUES
	(101, 'Fizika', 50, 20),
	(202, 'Matemātika', 50, 20),
	(303, 'Audzināšana', 20, 5),
	(404, 'Programmēšana', 70, 20),
	(505, 'Datorsistēmas', 70, 20);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
