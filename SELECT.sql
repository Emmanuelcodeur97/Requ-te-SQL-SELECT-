-- Afficher toutes les données des clients
SELECT * FROM Customer;

-- Afficher le nom_du_produit et la catégorie pour les produits dont le prix est compris entre 5000 et 10000
SELECT product_name, category FROM Product WHERE price BETWEEN 5000 AND 10000;

-- Afficher toutes les données des produits triés par ordre décroissant de prix
SELECT * FROM Product ORDER BY price DESC;

-- Afficher le nombre total de commandes, le montant moyen, le montant total le plus élevé et le montant total inférieur. 
-- Pour chaque product_id, afficher le nombre de commandes
SELECT 
    COUNT(Order_ID) AS Total_Commandes, 
    AVG(Order_Total) AS Montant_Moyen, 
    MAX(Order_Total) AS Montant_Total_Plus_Eleve, 
    MIN(Order_Total) AS Montant_Total_Inferieur,
    Product_ID,
    COUNT(DISTINCT Order_ID) AS Nombre_Commandes
FROM 
    Orders 
GROUP BY 
    Product_ID;

-- Afficher le customer_id qui a plus de 2 commandes
SELECT Customer_ID 
FROM Orders 
GROUP BY Customer_ID 
HAVING COUNT(Order_ID) > 2;

-- Pour chaque mois de l'année 2020, afficher le nombre de commandes
SELECT 
    EXTRACT(MONTH FROM OrderDate) AS Mois,
    COUNT(Order_ID) AS Nombre_Commandes
FROM 
    Orders 
WHERE 
    EXTRACT(YEAR FROM OrderDate) = 2020 
GROUP BY 
    EXTRACT(MONTH FROM OrderDate);

-- Pour chaque commande, afficher le nom_produit, le nom_client et la date de la commande
SELECT 
    Product.product_name,
    Customer.customer_name,
    Orders.OrderDate
FROM 
    Orders
JOIN 
    Product ON Orders.Product_ID = Product.Product_ID
JOIN 
    Customer ON Orders.Customer_ID = Customer.Customer_ID;

-- Afficher toutes les commandes passées il y a trois mois
SELECT * 
FROM Orders 
WHERE OrderDate >= ADD_MONTHS(SYSDATE, -3);

-- Afficher les clients (customer_id) qui n'ont jamais commandé de produit
SELECT Customer_ID 
FROM Customer 
WHERE Customer_ID NOT IN (SELECT DISTINCT Customer_ID FROM Orders);
