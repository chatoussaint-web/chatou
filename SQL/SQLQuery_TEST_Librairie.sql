---------------------------------------DB

CREATE DATABASE Librairie;
GO

USE Librairie;
GO

CREATE TABLE Auteurs (
    auteur_id   INT PRIMARY KEY IDENTITY(1,1),
    nom         VARCHAR(100) NOT NULL,
    prenom      VARCHAR(100) NOT NULL,
    nationalite VARCHAR(50)
);

CREATE TABLE Livres (
    livre_id    INT PRIMARY KEY IDENTITY(1,1),
    titre       VARCHAR(200) NOT NULL,
    auteur_id   INT FOREIGN KEY REFERENCES Auteurs(auteur_id),
    genre       VARCHAR(50),
    annee       INT,
    prix        DECIMAL(5,2)
);

CREATE TABLE Clients (
    client_id   INT PRIMARY KEY IDENTITY(1,1),
    nom         VARCHAR(100) NOT NULL,
    prenom      VARCHAR(100) NOT NULL,
    ville       VARCHAR(100)
);

CREATE TABLE Commandes (
    commande_id INT PRIMARY KEY IDENTITY(1,1),
    client_id   INT FOREIGN KEY REFERENCES Clients(client_id),
    livre_id    INT FOREIGN KEY REFERENCES Livres(livre_id),
    date_achat  DATE,
    quantite    INT
);

-----------------------------------------------------------------Données

INSERT INTO Auteurs (nom, prenom, nationalite) VALUES
('Tolkien',     'J.R.R.',    'Britannique'),
('Hugo',        'Victor',    'Française'),
('Rowling',     'J.K.',      'Britannique'),
('Dumas',       'Alexandre', 'Française'),
('Asimov',      'Isaac',     'Américaine'),
('Le Guin',     'Ursula K.', 'Américaine'),
('Pratchett',   'Terry',     'Britannique');

INSERT INTO Livres (titre, auteur_id, genre, annee, prix) VALUES
('Le Seigneur des Anneaux',     1, 'Fantasy',       1954, 24.99),
('Le Hobbit',                   1, 'Fantasy',       1937, 12.99),
('Les Misérables',              2, 'Roman',         1862, 18.50),
('Notre-Dame de Paris',         2, 'Roman',         1831, 14.00),
('Harry Potter T1',             3, 'Fantasy',       1997, 10.99),
('Harry Potter T2',             3, 'Fantasy',       1998, 10.99),
('Les Trois Mousquetaires',     4, 'Aventure',      1844, 11.50),
('Le Comte de Monte-Cristo',    4, 'Aventure',      1844, 19.90),
('Fondation',                   5, 'Science-Fiction',1951, 13.00),
('Les Robots',                  5, 'Science-Fiction',1950, 12.00),
('La Main Gauche de la Nuit',   6, 'Science-Fiction',1969, 14.50),
('Terramare',                   6, 'Fantasy',       1968, 11.00),
('Les Annales du Disque-Monde', 7, 'Fantasy',       1983, 13.99);

INSERT INTO Clients (nom, prenom, ville) VALUES
('Dupont',    'Marie',   'Bruxelles'),
('Laurent',   'Thomas',  'Paris'),
('Renard',    'Sophie',  'Lyon'),
('Martin',    'Lucas',   'Bruxelles'),
('Lecomte',   'Camille', 'Liège'),
('Bernard',   'Emma',    'Paris'),
('Fontaine',  'Hugo',    'Namur');

INSERT INTO Commandes (client_id, livre_id, date_achat, quantite) VALUES
(1, 1,  '2024-01-15', 1),
(1, 5,  '2024-02-03', 1),
(2, 9,  '2024-01-20', 2),
(2, 10, '2024-01-20', 1),
(3, 3,  '2024-03-10', 1),
(4, 2,  '2024-02-28', 1),
(4, 6,  '2024-03-01', 1),
(5, 8,  '2024-03-15', 1),
(6, 13, '2024-04-02', 3),
(7, 4,  '2024-04-10', 1),
(1, 11, '2024-04-12', 1),
(3, 7,  '2024-05-05', 2),
(2, 1,  '2024-05-18', 1);


-----------Exercices
--Niveau facile

--Lister tous les livres avec le nom de leur auteur
SELECT l.titre, CONCAT(a.prenom,' ',a.nom) AS 'Nom'
FROM Livres l
JOIN Auteurs a ON l.auteur_id=a.auteur_id;

--Trouver les livres de genre Fantasy
SELECT titre
FROM Livres
WHERE genre='Fantasy'

--Afficher les clients de Bruxelles
SELECT CONCAT(prenom,' ',nom) AS Nom
FROM Clients
WHERE ville='Bruxelles'

--Niveau intermédiaire

--Calculer le chiffre d'affaires total par client
SELECT cl.client_id,SUM(l.prix*c.quantite) AS 'Total chiffre d''affaire'
FROM Clients cl
JOIN Commandes c ON cl.client_id=c.client_id
JOIN Livres l ON c.livre_id=l.livre_id
GROUP BY cl.client_id
-- OU
SELECT cl.client_id, 
       CONCAT(cl.prenom,' ',cl.nom) AS client,
       SUM(l.prix*c.quantite) AS chiffre_affaires
FROM Clients cl
JOIN Commandes c ON cl.client_id=c.client_id
JOIN Livres l ON c.livre_id=l.livre_id
GROUP BY cl.client_id,cl.prenom,cl.nom;

--Trouver les auteurs ayant écrit plus d'un livre
SELECT CONCAT(a.prenom,' ',a.nom) AS Nom, COUNT(l.livre_id) AS 'Nombre de livres'
FROM Auteurs a
JOIN Livres l ON a.auteur_id=l.auteur_id
GROUP BY a.auteur_id,a.prenom,a.nom
HAVING COUNT(l.livre_id)>1;

--Lister les livres qui n'ont jamais été commandés
SELECT *
FROM Livres l
LEFT JOIN Commandes c ON l.livre_id=c.livre_id
WHERE c.commande_id IS NULL

--Niveau avancé

--Quel client a dépensé le plus ? (JOIN + GROUP BY + ORDER BY)
SELECT TOP 1 WITH TIES cl.client_id, CONCAT(cl.prenom,' ',cl.nom) AS Nom, SUM(l.prix*c.quantite) AS 'Dépense'
FROM Commandes c
JOIN Clients cl ON c.client_id=cl.client_id
JOIN Livres l ON c.livre_id=l.livre_id
GROUP BY cl.client_id,cl.prenom,cl.nom
ORDER BY SUM(l.prix*c.quantite) DESC;

--Classer les genres par chiffre d'affaires total
SELECT l.genre,SUM(l.prix*c.quantite) AS 'Chiffre d''affaire'
FROM Livres l
JOIN Commandes c ON l.livre_id=c.livre_id
GROUP BY l.genre
ORDER BY SUM(l.prix*c.quantite) DESC;

--Trouver les clients ayant commandé des livres de plusieurs genres différents
SELECT cl.client_id, CONCAT(cl.prenom,' ',cl.nom) AS Nom
FROM Livres l
JOIN Commandes c ON l.livre_id=c.livre_id
JOIN Clients cl ON c.client_id=cl.client_id
GROUP BY cl.client_id,cl.prenom,cl.nom
HAVING COUNT(DISTINCT l.genre)>1