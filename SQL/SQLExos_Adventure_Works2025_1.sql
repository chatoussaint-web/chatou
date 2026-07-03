--Exercice 1 — SELECT simple
--Affiche : le nom du produit, son prix (ListPrice), sa couleur
--Depuis la table Production.Product.
--Conditions :
--seulement les produits rouges, prix > 100, triés du plus cher au moins cher
SELECT Name,ListPrice,Color
FROM Production.Product
WHERE Color = 'Red' AND ListPrice > 100
ORDER BY ListPrice DESC

--Exercice 2 — COUNT
--Compte combien il existe de produits : dont le prix est supérieur à 1000
--Tu dois obtenir une seule ligne avec un nombre.
SELECT COUNT(*) AS Total
FROM Production.Product
WHERE ListPrice>1000

--Exercice 3 — GROUP BY
--Pour chaque couleur : compter le nombre de produits
--Exclure les couleurs NULL.
--Trier par nombre décroissant.
SELECT Color,COUNT(*) AS Total
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY COUNT(*)DESC

--Exercice 4 — HAVING
--Afficher uniquement les couleurs : ayant plus de 10 produits
--Avec : la couleur, le nombre de produits
SELECT Color,Count(*) AS Total
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY Color
HAVING COUNT(*)>10
ORDER BY COUNT(*)DESC;

--Exercice 5 — Produits et catégories
--Afficher : le nom du produit, le nom de sa catégorie

--Tables utiles :
--Production.Product
--Production.ProductSubcategory
--Production.ProductCategory
SELECT p_p.Name AS ProductName,p_c.Name AS CategoryName
FROM Production.Product p_p
JOIN Production.ProductSubcategory p_s
	ON p_p.ProductSubcategoryID = p_s.ProductSubcategoryID
JOIN Production.ProductCategory p_c
	ON p_s.ProductCategoryID = p_c.ProductCategoryID;

--Exercice 6 — Clients et commandes
--Afficher : l’ID de commande, la date, l’ID client
--Depuis :
--Sales.SalesOrderHeader
--Limiter aux commandes après 2023.
SELECT SalesOrderID,OrderDate,CustomerID
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2023-01-01';

--Exercice 7 — Total par client
--Pour chaque client : calculer le montant total commandé
--Indice : utiliser TotalDue
--Afficher : CustomerID, total des achats
--Trier du plus gros client au plus petit.
SELECT CustomerID, SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY SUM(TotalDue) DESC;

--Exercice 8 — Top produits vendus
--Trouver les 10 produits : les plus vendus en quantité
--Tables :
--Sales.SalesOrderDetail
--Production.Product
--Afficher : nom du produit, quantité totale vendue
SELECT TOP 10 p_p.Name, SUM(s_s.OrderQty) AS Total
FROM Production.Product p_p
JOIN Sales.SalesOrderDetail s_s
	ON p_p.ProductID = s_s.ProductID
GROUP BY p_p.ProductID, p_p.Name
ORDER BY SUM(s_s.OrderQty) DESC;

--Exercice 9 — Moyenne
--Calculer : le prix moyen des produits par catégorie.
SELECT p_c.ProductCategoryID, p_c.Name, AVG(p_p.ListPrice) AS Moyenne
FROM Production.Product p_p
JOIN Production.ProductSubcategory p_s
	ON p_p.ProductSubcategoryID = p_s.ProductSubcategoryID
JOIN Production.ProductCategory p_c
	ON p_s.ProductCategoryID = p_c.ProductCategoryID
GROUP BY p_c.ProductCategoryID, p_c.Name;

--Exercice 10 — Clients “importants”
--Afficher les clients : ayant dépensé plus de 100000
--Avec : CustomerID, somme totale dépensée
SELECT CustomerID, SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue)>100000
ORDER BY SUM(TotalDue) DESC;

--Exercice 11 — WHERE ou HAVING ?
--Trouver les produits : dont le prix moyen par catégorie est > 500
--Question implicite : où faut-il mettre la condition ?
SELECT 
    p_c.ProductCategoryID,
    p_c.Name,
    AVG(p_p.ListPrice) AS PrixMoyen
FROM Production.Product p_p
JOIN Production.ProductSubcategory p_s
    ON p_p.ProductSubcategoryID = p_s.ProductSubcategoryID
JOIN Production.ProductCategory p_c
    ON p_s.ProductCategoryID = p_c.ProductCategoryID
GROUP BY p_c.ProductCategoryID, p_c.Name
HAVING AVG(p_p.ListPrice) > 500
ORDER BY PrixMoyen DESC;

--Exercice 12 — LEFT JOIN
--Afficher toutes les catégories : même celles sans produit
--Avec : le nombre de produits par catégorie
SELECT p_c.ProductCategoryID, p_c.Name, COUNT(p_p.ProductID) AS ProductCount
FROM Production.ProductCategory p_c
LEFT JOIN Production.ProductSubcategory p_s
    ON p_c.ProductCategoryID = p_s.ProductCategoryID
LEFT JOIN Production.Product p_p
    ON p_s.ProductSubcategoryID = p_p.ProductSubcategoryID
GROUP BY p_c.ProductCategoryID, p_c.Name
ORDER BY p_c.ProductCategoryID DESC;
