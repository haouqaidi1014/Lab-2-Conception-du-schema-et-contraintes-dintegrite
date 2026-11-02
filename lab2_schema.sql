-- 1 role: creation de base de donnee bibliotheque
CREATE DATABASE IF NOT EXISTS bibliotheque
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE bibliotheque;

-- 2 role Définition des types de données et du moteur
CREATE TABLE IF NOT EXISTS abonne (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  date_inscription DATE NOT NULL DEFAULT (CURRENT_DATE),
  CHECK (email LIKE '%@%._%')
) ENGINE=InnoDB;

-- 3 role :Création de la table Auteur pour stocker leur informations
CREATE TABLE IF NOT EXISTS auteur (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  date_naissance DATE NULL,
  CONSTRAINT chk_auteur_nom CHECK (LENGTH(nom) > 0)
) ENGINE=InnoDB;
INSERT INTO auteur (nom, prenom, date_naissance)
VALUES ('Dupont', 'Marie', '1975-04-12');

-- 4-role :Création de la table Ouvrage pour stocker les livres et les auteurs
CREATE TABLE IF NOT EXISTS ouvrage (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titre VARCHAR(200) NOT NULL,
  isbn CHAR(13) NOT NULL UNIQUE,
  disponible BOOLEAN NOT NULL DEFAULT TRUE,
  auteur_id INT NOT NULL,
  CONSTRAINT fk_ouvrage_auteur FOREIGN KEY (auteur_id)
    REFERENCES auteur(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT chk_isbn CHECK (isbn REGEXP '^[0-9]{13}$')
) ENGINE=InnoDB;
INSERT INTO ouvrage (titre, isbn, disponible, auteur_id)
VALUES ('Les Misérables', '1234567890123', TRUE, 1);
SHOW DATABASES;
-- 5 role :Création de la table Abonné
CREATE TABLE IF NOT EXISTS abonne (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  date_inscription DATE NOT NULL DEFAULT (CURRENT_DATE),
  CONSTRAINT chk_email_format CHECK (email LIKE '%@%._%')
) ENGINE=InnoDB;
INSERT INTO abonne (nom, prenom, email)
VALUES ('Martin', 'Luc', 'luc.martin@example.com');
-- 6 role :Création de la table Emprunt
CREATE TABLE IF NOT EXISTS emprunt (
  ouvrage_id INT NOT NULL,
  abonne_id INT NOT NULL,
  date_debut DATE NOT NULL DEFAULT (CURRENT_DATE),
  date_fin DATE NULL,
  PRIMARY KEY (ouvrage_id, abonne_id, date_debut),
  CONSTRAINT fk_emprunt_ouvrage FOREIGN KEY (ouvrage_id)
    REFERENCES ouvrage(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_emprunt_abonne FOREIGN KEY (abonne_id)
    REFERENCES abonne(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT chk_dates CHECK (date_fin IS NULL OR date_fin >= date_debut)
) ENGINE=InnoDB;
INSERT INTO emprunt (ouvrage_id, abonne_id, date_debut)
VALUES (1, 1, CURRENT_DATE);
-- 7 role :Indexation et tests de cohérence
ALTER TABLE ouvrage ADD INDEX idx_ouvrage_disponible (disponible);
ALTER TABLE emprunt ADD INDEX idx_emprunt_date_fin (date_fin);
-- 7.1. Email dupliqué
INSERT INTO abonne (nom, prenom, email)
VALUES ('Dupont', 'Jean', 'luc.martin@example.com');
-- 7.2. Date incohérente
INSERT INTO emprunt (ouvrage_id, abonne_id, date_debut, date_fin)
VALUES (1, 1, '2024-10-01', '2024-09-30');

-- 8 role :Gestion automatique de la disponibilité
DELIMITER $$
CREATE TRIGGER trg_emprunt_insert BEFORE INSERT ON emprunt
FOR EACH ROW
BEGIN
  -- Vérifier que l'ouvrage est disponible
  IF (SELECT disponible FROM ouvrage WHERE id = NEW.ouvrage_id) = FALSE THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''ouvrage n''est pas disponible.';
  END IF;
  -- Marquer l'ouvrage comme indisponible
  UPDATE ouvrage SET disponible = FALSE WHERE id = NEW.ouvrage_id;
END$$
DELIMITER ;
-- les verification des donnees
SHOW TABLES;
SELECT * FROM auteur;
SELECT * FROM ouvrage;
SELECT * FROM abonne;
