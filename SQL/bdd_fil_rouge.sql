CREATE DATABASE hardware_shop;
USE hardware_shop;
CREATE TABLE Commande(
   Id_Commande INT AUTO_INCREMENT,
   date_com DATE NOT NULL,
   total_com DECIMAL(7,2)   NOT NULL,
   PRIMARY KEY(Id_Commande)
);

CREATE TABLE Distributeurs(
   Id_Distributeurs INT AUTO_INCREMENT,
   logo_distri VARCHAR(50) ,
   nom_distri VARCHAR(50)  NOT NULL,
   adr_distri VARCHAR(100)  NOT NULL,
   tel_distri VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Id_Distributeurs)
);

CREATE TABLE Bon_livraison(
   Id_bl INT AUTO_INCREMENT,
   date_livr DATE NOT NULL,
   Id_Commande INT NOT NULL,
   PRIMARY KEY(Id_bl),
   FOREIGN KEY(Id_Commande) REFERENCES Commande(Id_Commande)
);

CREATE TABLE Produit(
   Id_Produit INT AUTO_INCREMENT,
   img_prod VARCHAR(50) ,
   libelle_prod VARCHAR(50)  NOT NULL,
   prix_achat_fourn DECIMAL(10,2)   NOT NULL,
   prix_vente_ht DECIMAL(10,2)   NOT NULL,
   Id_Distributeurs INT,
   PRIMARY KEY(Id_Produit),
   FOREIGN KEY(Id_Distributeurs) REFERENCES Distributeurs(Id_Distributeurs)
);

CREATE TABLE Utilisateurs(
   Id_util INT AUTO_INCREMENT,
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
   com_assigné BOOLEAN,
   Id_util_1 INT,
   Id_Commande INT,
   PRIMARY KEY(Id_util),
   FOREIGN KEY(Id_util_1) REFERENCES Utilisateurs(Id_util),
   FOREIGN KEY(Id_Commande) REFERENCES Commande(Id_Commande)
);

CREATE TABLE Facture(
   Id_facture INT AUTO_INCREMENT,
   mode_paie VARCHAR(1)  NOT NULL,
   prix_ht DECIMAL(6,2)   NOT NULL,
   date_emi DATE NOT NULL,
   taux_tva DECIMAL(2,2)   NOT NULL,
   prix_total DECIMAL(6,2)   NOT NULL,
   Id_Commande INT NOT NULL,
   PRIMARY KEY(Id_facture),
   FOREIGN KEY(Id_Commande) REFERENCES Commande(Id_Commande)
);

CREATE TABLE Catégorie(
   Id_Catégorie INT AUTO_INCREMENT,
   photo_cat VARCHAR(50) ,
   libelle_cat VARCHAR(50) ,
   Id_Produit INT NOT NULL,
   PRIMARY KEY(Id_Catégorie),
   FOREIGN KEY(Id_Produit) REFERENCES Produit(Id_Produit)
);

CREATE TABLE Sous_cat(
   Id_Sous_cat INT AUTO_INCREMENT,
   Id_Catégorie INT NOT NULL,
   PRIMARY KEY(Id_Sous_cat),
   FOREIGN KEY(Id_Catégorie) REFERENCES Catégorie(Id_Catégorie)
);

CREATE TABLE detail_bl_produit(
   Id_Produit INT,
   Id_bl INT,
   qte DECIMAL(5,0)   NOT NULL,
   PRIMARY KEY(Id_Produit, Id_bl),
   FOREIGN KEY(Id_Produit) REFERENCES Produit(Id_Produit),
   FOREIGN KEY(Id_bl) REFERENCES Bon_livraison(Id_bl)
);

CREATE TABLE Detail_commande(
   Id_Produit INT,
   Id_Commande INT,
   qte DECIMAL(5,0)   NOT NULL,
   prix DECIMAL(6,2)   NOT NULL,
   PRIMARY KEY(Id_Produit, Id_Commande),
   FOREIGN KEY(Id_Produit) REFERENCES Produit(Id_Produit),
   FOREIGN KEY(Id_Commande) REFERENCES Commande(Id_Commande)
);
