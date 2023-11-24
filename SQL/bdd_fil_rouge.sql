CREATE DATABASE hardware_shop;
USE hardware_shop;

CREATE TABLE commande (
   id_com INT AUTO_INCREMENT,
   date_com DATE NOT NULL,
   total_com DECIMAL(7,2)   NOT NULL,
   PRIMARY KEY(id_com)
);

CREATE TABLE distributeurs(
   id_dis INT AUTO_INCREMENT,
   logo_dis VARCHAR(50) ,
   nom_dis VARCHAR(50)  NOT NULL,
   adr_dis VARCHAR(100)  NOT NULL,
   tel_dis VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_dis)
);


CREATE TABLE bon_livraison(
   id_bl INT AUTO_INCREMENT,
   date_livr DATE NOT NULL,
   id_com INT NOT NULL,
   PRIMARY KEY(id_bl),
   FOREIGN KEY(id_com) REFERENCES commande (id_com)
);

CREATE TABLE produit(
   id_prod INT AUTO_INCREMENT,
   img_prod VARCHAR(50) ,
   libelle_prod VARCHAR(50)  NOT NULL,
   prix_achat_fourn DECIMAL(10,2)   NOT NULL,
   prix_vente_ht DECIMAL(10,2)   NOT NULL,
   id_ss_cat INT,
   id_dis INT,
   PRIMARY KEY(id_prod),
   FOREIGN KEY(id_dis) REFERENCES distributeurs(id_dis),
   FOREIGN KEY(id_ss_cat) REFERENCES distributeurs(id_dis)
);

CREATE TABLE utilisateurs(
   id_util INT AUTO_INCREMENT,
   nom_entr VARCHAR(50) ,
   cli_nom VARCHAR(50)  NOT NULL,
   cli_prenom VARCHAR(50)  NOT NULL,
   coef DECIMAL(2,2)   NOT NULL,
   role VARCHAR(1)  NOT NULL,
   cli_adr_livr VARCHAR(100)  NOT NULL,
   cli_adr_livr_2 VARCHAR(100)  NOT NULL,
   cli_adr_fact VARCHAR(100)  NOT NULL,
   cli_adr_fact_2 VARCHAR(100)  NOT NULL,
   util_mdp VARCHAR(50)  NOT NULL,
   com_assignee BOOLEAN,
   id_util_1 INT,
   id_Com INT,
   PRIMARY KEY(id_util),
   FOREIGN KEY(id_util_1) REFERENCES utilisateurs(id_util),
   FOREIGN KEY(id_Com) REFERENCES commande(id_Com)
);

CREATE TABLE facture(
   id_fact INT AUTO_INCREMENT,
   mode_paie VARCHAR(1)  NOT NULL,
   prix_ht DECIMAL(6,2)   NOT NULL,
   date_emi DATE NOT NULL,
   taux_tva DECIMAL(2,2)   NOT NULL,
   prix_total DECIMAL(6,2)   NOT NULL,
   id_Com INT NOT NULL,
   PRIMARY KEY(id_fact),
   FOREIGN KEY(id_Com) REFERENCES commande(id_Com)
);

CREATE TABLE categorie(
   id_Cat INT AUTO_INCREMENT,
   img_cat VARCHAR(50) ,
   libelle_cat VARCHAR(50) ,
   id_prod INT NOT NULL,
   PRIMARY KEY(id_cat),
   FOREIGN KEY(id_prod) REFERENCES produit(id_prod)
);

CREATE TABLE id_ss_cat(
   id_ss_cat INT AUTO_INCREMENT,
   id_cat INT NOT NULL,
   PRIMARY KEY(id_ss_cat),
   FOREIGN KEY(id_cat) REFERENCES categorie(id_cat)
);

CREATE TABLE sous_cat2(
   id_ss_cat2 INT AUTO_INCREMENT,
   id_ss_cat NOT NULL,
   PRIMARY KEY(id_ss_cat2),
   FOREIGN KEY(id_ss_cat) REFERENCES id_ss_cat(id_ss_cat)
);

CREATE TABLE details_bl(
   id_Produit INT,
   id_bl INT,
   qte DECIMAL(5,0)   NOT NULL,
   PRIMARY KEY(id_prod, id_bl),
   FOREIGN KEY(id_prod) REFERENCES produit(id_prod),
   FOREIGN KEY (id_bl) REFERENCES bon_livraison(id_bl)
);

CREATE TABLE details_commande (
   id_prod INT,
   id_com INT,
   qte DECIMAL(5,0)   NOT NULL,
   prix DECIMAL(6,2)   NOT NULL,
   PRIMARY KEY(id_prod, id_com),
   FOREIGN KEY(id_prod) REFERENCES produit(id_prod),
   FOREIGN KEY(id_com) REFERENCES commande(id_com)
);

-- categorie : CPU / GPU / ...
-- sous-cat : 1080p / 1440p / 4k
-- sous-cat2 : gaming / professionnel

INSERT INTO distributeurs (nom_distri) VALUES ('AMD');
INSERT INTO distributeurs (nom_distri) VALUES ('NVIDIA');
INSERT INTO distributeurs (nom_distri) VALUES ('INTEL');

INSERT INTO categorie (libel_cat) VALUES ('cartes graphiques'); --1
INSERT INTO categorie (libel_cat) VALUES ('processeurs'); --2
INSERT INTO categorie (libel_cat) VALUES ('refroidissement processeur'); --3
INSERT INTO categorie (libel_cat) VALUES ('cartes mères'); --4
INSERT INTO categorie (libel_cat) VALUES ('mémoire vive'); --5
INSERT INTO categorie (libel_cat) VALUES ('mémoire de stockage'); --6
INSERT INTO categorie (libel_cat) VALUES ('alimentations'); --7
INSERT INTO categorie (libel_cat) VALUES ('boitiers'); --8
INSERT INTO categorie (libel_cat) VALUES ('cablage'); --9
INSERT INTO categorie (libel_cat) VALUES ('ventilateurs boitier'); --10

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('RX6700XT', 235, 290, 1),('RX6800XT', 380, 450, 1),('RX7900XTX', 750, 900, 1);
INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('RTX3060Ti', 250, 330, 1),('RTX3080', 450, 580, 1),('RTX4090', 1400, 1600, 1);
INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('ARC770', 250, 330, 1);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('RYZEN 7600X', 200, 250, 2),('RYZEN 7950X', 400, 550, 2),('RYZEN 5800X3D ', 200, 250, 2),('I5 13600k', 250, 330, 2),('I5 14900k', 600, 750, 2);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('Artic liquid freezer II', 80, 100, 3),('Noctua NH-D15 chromax', 80, 100, 3),('Thermalright Assassin X 120', 10, 15, 3);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('Asus TUF B660-Plus Wifi', 80, 150, 4),('MSI MAG B650 Tomahawk WiFi', 80, 150, 4);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('Corsair Vengeance LPX Kit 32 Go DDR4-3200 CL16', 45, 60, 5),('G.Skill Ripjaws S5 32 Go Kit DDR5-6000 CL30', 80, 120, 5);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('Samsung 980 Pro M.2 2 To', 80, 100, 6);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('MSI MAG GL A750GL 750W', 70, 90, 7),('Seasonic Focus GX-1000W ATX 3.0', 100, 130, 7);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('Phanteks Eclipse G360A Black', 50, 80, 8),('Lian Li O11 Dynamic EVO White', 90, 120, 8);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('Corsair Premium Individually Sleeved PSU Cables Pro Kit Type 4 Gen 4 - White/Black', 50, 80, 9);

INSERT INTO produit (libelle_prod, prix_achat_fourn, prix_vente_ht, id_ss_cat) VALUES ('Arctic P12 PWM PST black Value Pack 120mm', 15, 25, 11),('Corsair iCUE Link QX120 RGB 120mm', 90, 120, 10);



