DROP DATABASE IF EXISTS reservation_cinema;

 use reservation_cinema;

 
CREATE TABLE IF NOT EXISTS CINEMA
 (
   IDCINEMA INT NOT NULL AUTO_INCREMENT  ,
   IDUSER INT NOT NULL  ,
   LOCALISATION VARCHAR(255) NOT NULL  ,
   POSSESSEUR VARCHAR(255) NOT NULL  ,
   ADRESSE VARCHAR(255) NOT NULL  
   , PRIMARY KEY (IDCINEMA) 
 ) 
 comment = "";

 CREATE UNIQUE INDEX I_FK_CINEMA_USER
     ON CINEMA (IDUSER ASC);

CREATE TABLE IF NOT EXISTS USER
 (
   IDUSER INT(128) NOT NULL AUTO_INCREMENT  ,
   IDCINEMA INT(128) NOT NULL  ,
   NOM VARCHAR(128) NOT NULL  ,
   PRENOM VARCHAR(128) NOT NULL  
   , PRIMARY KEY (IDUSER) 
 ) 
 comment = "";

CREATE UNIQUE INDEX I_FK_USER_CINEMA
     ON USER (IDCINEMA ASC);

CREATE TABLE IF NOT EXISTS ADMINISTRATEUR
 (
   IDADMINISTRATEUR INT(128) NOT NULL AUTO_INCREMENT  ,
   NOM VARCHAR(128) NOT NULL  ,
   PRENOM VARCHAR(128) NOT NULL  
   , PRIMARY KEY (IDADMINISTRATEUR) 
 ) 
 comment = "";

 CREATE TABLE IF NOT EXISTS TARIF
 (
   IDTARIF INT(128) NOT NULL AUTO_INCREMENT   ,
   CATEGORY VARCHAR(128) NOT NULL  ,
   PRIX INT(128) NOT NULL  ,
   TYPEPAIEMENT VARCHAR(128) NOT NULL  
   , PRIMARY KEY (IDTARIF) 
 ) 
 comment = "";

 CREATE TABLE IF NOT EXISTS CLIENT
 (
   IDCLIENT INT(128) NOT NULL AUTO_INCREMENT  ,
   NOM VARCHAR(128) NOT NULL  ,
   PRENOM VARCHAR(128) NOT NULL  ,
   ADRESSE VARCHAR(128) NOT NULL  
   , PRIMARY KEY (IDCLIENT) 
 ) 
 comment = "";

CREATE TABLE IF NOT EXISTS FILM
 (
   IDFILM INT(128) NOT NULL AUTO_INCREMENT  ,
   TITRE VARCHAR(128) NOT NULL  ,
   DUREE TIME NOT NULL  ,
   GENRE VARCHAR(128) NOT NULL  ,
   DATESORTIE DATETIME NOT NULL  
   , PRIMARY KEY (IDFILM) 
 ) 
 comment = "";

CREATE TABLE IF NOT EXISTS RESERVATION
 (
   IDRESERVATION INT(128) NOT NULL AUTO_INCREMENT  ,
   DATERESERVATION DATETIME NOT NULL  
   , PRIMARY KEY (IDRESERVATION) 
 ) 
 comment = "";

CREATE TABLE IF NOT EXISTS SALLE
 (
   IDSALLE INT(128) NOT NULL AUTO_INCREMENT  ,
   NOM VARCHAR(128) NOT NULL  ,
   ADRESSE VARCHAR(128) NOT NULL  ,
   NOMBRESIEGE INT(128) NOT NULL  
   , PRIMARY KEY (IDSALLE) 
 ) 
 comment = "";

CREATE TABLE IF NOT EXISTS SEANCE
 (
   IDSEANCE INT(128) NOT NULL AUTO_INCREMENT ,
   DATESEANCE DATETIME NOT NULL  ,
   DUREE TIME NOT NULL  
   , PRIMARY KEY (IDSEANCE) 
 ) 
 comment = "";

CREATE TABLE IF NOT EXISTS PROGRAMME
 (
   IDFILM INT(128) NOT NULL AUTO_INCREMENT  ,
   IDSEANCE INT(128) NOT NULL  
   , PRIMARY KEY (IDFILM,IDSEANCE) 
 ) 
 comment = "";

CREATE  INDEX I_FK_PROGRAMME_FILM
     ON PROGRAMME (IDFILM ASC);

CREATE  INDEX I_FK_PROGRAMME_SEANCE
     ON PROGRAMME (IDSEANCE ASC);

CREATE TABLE IF NOT EXISTS ACCUEIL
 (
   IDSEANCE INT(128) NOT NULL  ,
   IDSALLE INT(128) NOT NULL  
   , PRIMARY KEY (IDSEANCE,IDSALLE) 
 ) 
 comment = "";

CREATE  INDEX I_FK_ACCUEIL_SEANCE
     ON ACCUEIL (IDSEANCE ASC);

CREATE  INDEX I_FK_ACCUEIL_SALLE
     ON ACCUEIL (IDSALLE ASC);

CREATE TABLE IF NOT EXISTS OCCUPE
 (
   IDSEANCE INT(128) NOT NULL  ,
   IDRESERVATION INT(128) NOT NULL  
   , PRIMARY KEY (IDSEANCE,IDRESERVATION) 
 ) 
 comment = "";

CREATE  INDEX I_FK_OCCUPE_SEANCE
     ON OCCUPE (IDSEANCE ASC);

CREATE  INDEX I_FK_OCCUPE_RESERVATION
     ON OCCUPE (IDRESERVATION ASC);

CREATE TABLE IF NOT EXISTS REPRESENTE
 (
   IDRESERVATION INT(128) NOT NULL  ,
   IDTARIF INT(128) NOT NULL  
   , PRIMARY KEY (IDRESERVATION,IDTARIF) 
 ) 
 comment = "";

CREATE  INDEX I_FK_REPRESENTE_RESERVATION
     ON REPRESENTE (IDRESERVATION ASC);

CREATE  INDEX I_FK_REPRESENTE_TARIF
     ON REPRESENTE (IDTARIF ASC);

CREATE TABLE IF NOT EXISTS FAIT
 (
   IDCLIENT INT(128) NOT NULL  ,
   IDRESERVATION INT(128) NOT NULL  
   , PRIMARY KEY (IDCLIENT,IDRESERVATION) 
 ) 
 comment = "";

CREATE  INDEX I_FK_FAIT_CLIENT
     ON FAIT (IDCLIENT ASC);

CREATE  INDEX I_FK_FAIT_RESERVATION
     ON FAIT (IDRESERVATION ASC);

CREATE TABLE IF NOT EXISTS ADMINISTRE
 (
   IDADMINISTRATEUR INT(128) NOT NULL  ,
   IDCINEMA INT(128) NOT NULL  
   , PRIMARY KEY (IDADMINISTRATEUR,IDCINEMA) 
 ) 
 comment = "";

CREATE  INDEX I_FK_ADMINISTRE_ADMINISTRATEUR
     ON ADMINISTRE (IDADMINISTRATEUR ASC);

CREATE  INDEX I_FK_ADMINISTRE_CINEMA
     ON ADMINISTRE (IDCINEMA ASC);

ALTER TABLE CINEMA 
  ADD FOREIGN KEY FK_CINEMA_USER (IDUSER)
      REFERENCES USER (IDUSER) ;


ALTER TABLE USER 
  ADD FOREIGN KEY FK_USER_CINEMA (IDCINEMA)
      REFERENCES CINEMA (IDCINEMA) ;


ALTER TABLE PROGRAMME 
  ADD FOREIGN KEY FK_PROGRAMME_FILM (IDFILM)
      REFERENCES FILM (IDFILM) ;


ALTER TABLE PROGRAMME 
  ADD FOREIGN KEY FK_PROGRAMME_SEANCE (IDSEANCE)
      REFERENCES SEANCE (IDSEANCE) ;


ALTER TABLE ACCUEIL 
  ADD FOREIGN KEY FK_ACCUEIL_SEANCE (IDSEANCE)
      REFERENCES SEANCE (IDSEANCE) ;


ALTER TABLE ACCUEIL 
  ADD FOREIGN KEY FK_ACCUEIL_SALLE (IDSALLE)
      REFERENCES SALLE (IDSALLE) ;


ALTER TABLE OCCUPE 
  ADD FOREIGN KEY FK_OCCUPE_SEANCE (IDSEANCE)
      REFERENCES SEANCE (IDSEANCE) ;


ALTER TABLE OCCUPE 
  ADD FOREIGN KEY FK_OCCUPE_RESERVATION (IDRESERVATION)
      REFERENCES RESERVATION (IDRESERVATION) ;


ALTER TABLE REPRESENTE 
  ADD FOREIGN KEY FK_REPRESENTE_RESERVATION (IDRESERVATION)
      REFERENCES RESERVATION (IDRESERVATION) ;


ALTER TABLE REPRESENTE 
  ADD FOREIGN KEY FK_REPRESENTE_TARIF (IDTARIF)
      REFERENCES TARIF (IDTARIF) ;


ALTER TABLE FAIT 
  ADD FOREIGN KEY FK_FAIT_CLIENT (IDCLIENT)
      REFERENCES CLIENT (IDCLIENT) ;


ALTER TABLE FAIT 
  ADD FOREIGN KEY FK_FAIT_RESERVATION (IDRESERVATION)
      REFERENCES RESERVATION (IDRESERVATION) ;


ALTER TABLE ADMINISTRE 
  ADD FOREIGN KEY FK_ADMINISTRE_ADMINISTRATEUR (IDADMINISTRATEUR)
      REFERENCES ADMINISTRATEUR (IDADMINISTRATEUR) ;


ALTER TABLE ADMINISTRE 
  ADD FOREIGN KEY FK_ADMINISTRE_CINEMA (IDCINEMA)
      REFERENCES CINEMA (IDCINEMA) ;
# ---------------------------------------
# ALIMENTATION DES TABLES
# ---------------------------------------
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO CINEMA (LOCALISATION, POSSESSEUR, ADRESSE) VALUES ('Bordeaux', 'NICE', '21 RUE DU COIN 33000');

INSERT INTO USER (IDCINEMA, NOM, PRENOM) VALUES (6,'MERCIER', 'Nelson');

INSERT INTO CINEMA (LOCALISATION, POSSESSEUR, ADRESSE) VALUES ('Bordeaux', 'NICE', '21 RUE DU COIN 33000');

INSERT INTO TARIF (CATEGORY, PRIX, TYPEPAIEMENT) VALUES ('Étudiant', '7.60', 'Sur Place');

INSERT INTO CLIENT (NOM, PRENOM, ADRESSE) VALUES ('DUPONT', 'Marcel', '21 RUE DU PONT 23400');
INSERT INTO CLIENT (NOM, PRENOM, ADRESSE) VALUES ('DOE', 'John', '21 RUE DU DOE 22500');

INSERT INTO FILM (TITRE, DUREE, GENRE, DATESORTIE) VALUES ('BLACK PANTHER', '02:30:00', 'FICTION', '2022-11-11 13:20:30');
INSERT INTO FILM (TITRE, DUREE, GENRE, DATESORTIE) VALUES ('AMERICAN PIE', '01:30:00', 'COMEDIE', '2009-01-09 12:30:00');

INSERT INTO RESERVATION (DATERESERVATION) VALUES ('2022-11-11 11:20:30');
INSERT INTO RESERVATION (DATERESERVATION) VALUES ('2022-10-11 09:20:30');

INSERT INTO SALLE (NOM, ADRESSE, NOMBRESIEGE) VALUES ('LUXEA', '01 RUE DU COLLIO 21400', 250);
INSERT INTO SALLE (NOM, ADRESSE, NOMBRESIEGE) VALUES ('BEO', '17 RUE DU BEOLOG 31400', 350);

INSERT INTO SEANCE (DATESEANCE, DUREE) VALUES ('2022-12-11 10:20:30', '02:30:00');
INSERT INTO SEANCE (DATESEANCE, DUREE) VALUES ('2023-02-01 09:10:30', '01:30:00');

INSERT INTO ADMINISTRATEUR (NOM, PRENOM) VALUES ('JAOHOVA', 'Miguel');
INSERT INTO ADMINISTRATEUR (NOM, PRENOM) VALUES ('BELAHY', 'Marie');

INSERT INTO PROGRAMME (IDFILM, IDSEANCE) VALUES (2, 2);

INSERT INTO ACCUEIL (IDSEANCE, IDSALLE) VALUES (1 , 1);

INSERT INTO OCCUPE (IDSEANCE, IDRESERVATION) VALUES (1 , 1);

INSERT INTO REPRESENTE (IDRESERVATION, IDTARIF) VALUES (1 , 1);

INSERT INTO FAIT (IDCLIENT, IDRESERVATION) VALUES (1 , 1);

INSERT INTO ADMINISTRE (IDADMINISTRATEUR, IDCINEMA) VALUES (1 , 6);

INSERT INTO ADMINISTRE (IDADMINISTRATEUR, IDCINEMA) VALUES (1 , 6);
