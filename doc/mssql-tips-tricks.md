# Conseils essentiels pour éviter les erreurs courantes de réglage des performances de SQL Server

## Ignorer l’indexation et l’optimisation des requêtes 

Pour vous assurer que vos requêtes SQL sont optimisées, vous devez créer des index sur les colonnes fréquemment recherchées. 

Par exemple, pour créer un index non clusterisé dans la colonne "Nom" de la table "Elements", vous pouvez utiliser le T-SQL suivant :

```SQL
CREATE NONCLUSTERED INDEX IX_Items_Name ON Items (Name)
```

## Dépendance excessive à l’égard des mises à niveau matérielles 

Pour éviter de trop dépendre des mises à niveau matérielles, vous devez vous concentrer sur l’optimisation de la conception et du schéma de votre base de données. 

Par exemple, vous pouvez créer un index de couverture pour améliorer les performances des requêtes :

```SQL
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID_OrderDate 
ON Orders (CustomerID, OrderDate);
```

## Ne pas surveiller l’utilisation des ressources 

Pour surveiller l’utilisation des ressources, vous pouvez utiliser l’Analyseur de performances SQL Server. 

Par exemple, vous pouvez suivre l’utilisation du processeur de votre serveur de base de données en ajoutant le compteur de performance "Processeur: % Temps processeur" au graphique:

```
PERFMON.EXE
```

## Échec de la mise à jour des statistiques 

Pour maintenir les statistiques à jour, vous pouvez exécuter la procédure stockée sp_updatestats. 

Par exemple, pour mettre à jour les statistiques de la table "Items", vous pouvez utiliser le T-SQL suivant :

```SQL
EXEC sp_updatestats 'Items';
```

## Ignorer la conception et la normalisation de la base de données 

Pour garantir une bonne conception et normalisation de la base de données, vous devez mettre en oeuvre les meilleures pratiques telles que l’utilisation de types de données appropriés et éviter la redondance des données. 

Par exemple, pour créer une table avec une relation de clé primaire et de clé étrangère, vous pouvez utiliser le T-SQL suivant :

```SQL
CREATE TABLE Orders (
  OrderID int PRIMARY KEY,
  CustomerID int FOREIGN KEY REFERENCES Customers (CustomerID),
  OrderDate datetime,
  TotalAmount money
);
```

## Ne pas utiliser les types et tailles de données appropriés 

Pour utiliser les types et tailles de données appropriés, vous devez choisir des types de données en fonction des données que vous stockez. 

Par exemple, pour stocker une petite quantité de texte, vous devez utiliser le type de données varchar au lieu du type de données varchar(max) :

```SQL
CREATE TABLE Items (
  ItemID int PRIMARY KEY,
  Name varchar(100),
  Address varchar(250),
  Phone varchar(20)
);
```

## Négliger de sauvegarder et de maintenir régulièrement l’intégrité de la base de données 

Pour sauvegarder et maintenir régulièrement l’intégrité de la base de données, vous devez créer une planification de sauvegarde et exécuter des tâches de maintenance de base de données régulières. 

Par exemple, pour créer une sauvegarde complète de la base de données "AdventureWorks", vous pouvez utiliser le T-SQL suivant :

```SQL
BACKUP DATABASE AdventureWorks 
TO DISK = 'C:\AdventureWorks_Full.bak'
```

## Surutilisation des curseurs et des tables temporaires 

Pour éviter d’utiliser trop de curseurs et de tables temporaires, vous devez utiliser des opérations basées sur des ensembles dans la mesure du possible. 

Par exemple, pour récupérer le total des ventes de chaque client, vous pouvez utiliser le T-SQL suivant :

```SQL
SELECT CustomerID, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY CustomerID;
```

## Ne pas gérer la croissance des données et l’espace de stockage 

Pour gérer la croissance des données et l’espace de stockage, vous devez mettre en oeuvre des stratégies d’archivage et de purge des données. 

Par exemple, pour archiver les anciennes données de commande dans une table distincte, vous pouvez utiliser le T-SQL suivant :

```SQL
INSERT INTO ItemArchive (ItemID, CustomerID, ItemDate, TotalAmount)
SELECT ItemID, CustomerID, OrderDate, TotalAmount
FROM Items
WHERE ItemDate < '2021-01-01';
DELETE FROM Items
WHERE ItemDate < '2021-01-01';
```

## Ne pas sécuriser la base de données 

Pour sécuriser la base de données, vous devez mettre en oeuvre des mesures de sécurité appropriées telles que l’utilisation de mots de passe forts, l’activation du chiffrement et la restriction de l’accès aux données sensibles. 

Par exemple, pour créer un utilisateur disposant d’un accès en lecture seule à la table "Items", vous pouvez utiliser le T-SQL suivant :

```SQL
CREATE USER ItemReader WITHOUT LOGIN;
GRANT SELECT ON Items TO ItemReader;
```

## Ne pas tester les modifications dans un environnement de développement

Pour éviter les problèmes potentiels en production, il est essentiel de tester d’abord toute modification ou mise à jour dans un environnement de développement. Cela peut inclure des modifications de schéma, des modifications de données et des modifications d’application. 

Par exemple, avant de mettre à jour le schéma d’une table de production, vous devez tester les modifications dans un environnement de développement pour vous assurer qu’elles ne causent aucun problème :

```SQL
-- In development environment
CREATE TABLE Orders_Dev (
  OrderID int PRIMARY KEY,
  CustomerID int FOREIGN KEY REFERENCES Customers (CustomerID),
  OrderDate datetime,
  TotalAmount money
);
-- Test the changes in the development environment
-- If successful, apply the changes to the production environment
```

## Utiliser des fonctions scalaires dans la clause WHERE

Utiliser des fonctions dans vos clauses WHERE va augmenter le temps pour obtenir votre réponse.

## Utiliser des tables variable au lieu d'utiliser des tables temporaires

## Ne pas surveiller ce qui se passe sur votre instance SQL Server

Vous pouvez mettre en place le magasin de requêtes sur chaque base de données afin de tracer les requêtes consommatrices, la fréquence d'exécution des requêtes, ...

## Ignorer la sélectivité des colonnes lors de la création des index

On tachera de toujours tenir compte de la sélectivité des colonnes lors de la création d'un index de telle sorte que la première colonne soit celle qui ait le plus de valeurs distinctes.

## Ne pas tenir compte de la fragmentation des index

Prévoir un plan de maintenance des index permettant de réduire la fragmentation de ceux-ci.

## Négliger la compression des données

En fonction de votre architecture (processeurs et RAM), vous pouvez mettre en place la compression de données sur vos tables, ce qui réduira votre espace de stockage et améliorera vos opérations I/O (mais cela nécessitera plus de ressources pour compresser/décompresser dès lors que l'on voudra accéder à la donnée).