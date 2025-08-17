# Microsoft SQL Server Tips & Tricks

[![forthebadge](https://forthebadge.com/images/badges/you-didnt-ask-for-this.svg)](http://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/contains-technical-debt.svg)](http://forthebadge.com)  [![forthebadge](https://forthebadge.com/images/badges/check-it-out.svg)](http://forthebadge.com)  [![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

Quelques trucs et astuces sur Microsoft SQL Server.

Ce projet utilise un devcontainer Docker pour fournir :

- Une base de données Microsoft SQL Server 2022 accessible localement
- Un conteneur de développement Debian pour se connecter via VS Code

---

![Microsoft SQL Server](./images/mssql-logo-256.png)

---

## ♻ Prérequis

- Docker
- Visual Studio Code
- Extension VS Code : Dev Containers (ou "Remote - Containers")

## 📂 Structure du projet

```bash
.devcontainer/
├── devcontainer.json
├── docker-compose.yml
workspace/
└── (vos fichiers de projet)
```

## ⚖️ Services Docker

- dev : conteneur Debian pour le développement (VS Code se connecte ici)
- sqlserver : conteneur SQL Server 2022

## ⚡ Lancement rapide

1. Cloner le projet
```bash
git clone <url-du-repo>
cd <repo>
```
2. Ouvrir dans VS Code
- Lancer la commande Reopen in Container
- Attendre le démarrage des services
3. Connexion SQL Server (via SSMS ou autre)
- Serveur : localhost,1433
- Utilisateur : sa
- Mot de passe : YourStrong!Passw0rd

Vous pouvez modifier ce mot de passe dans docker-compose.yml

## ⚙️ Commandes utiles

Redémarrer le conteneur :
```bash
docker compose down && docker compose up -d
```

Afficher les logs SQL Server :
```bash
docker logs sqlserver
```

## 🔧 Personnalisation

Vous pouvez :
- Installer sqlcmd dans le conteneur dev pour requêter la base en ligne de commande
- Ajouter des scripts SQL d'initialisation dans un volume ou un entrypoint

## Conseils

* Quelques bons [conseils](./doc/mssql-tips-tricks.md)

## Scripts utiles

### Sécurité

* [Trouver le port TCD](./scripts/security/find-tcp-port.sql)
* [Lister tous les comptes locaux qui peuvent se connecter](./scripts/security/list-of-sqlserver-users-who-can-connect.sql)
* [Lister tous les comptes AD qui peuvent se connecter](./scripts/security/list-of-ad-users-who-can-connect.sql)
* [Changer le mot de passe actuel du compte local](./scripts/security/changing-the-current-password.sql)
* [Restaurer le mot de passe du compte local](./scripts/security/restore-password.sql)
* [Générer les permissions sur les objets](./scripts/security/generate-permissions.sql)
* [Lister les permissions sur les objets ainsi que leur propriétaire](./scripts/security/permissions-on-objects-and-object-owners.sql)

### Index

* [Supprimer les index hypothétiques](./scripts/indexes/deletion-of-hypothetical-indexes.sql)
* [Trouver les index dupliqués](./scripts/indexes/find-duplicate-indexes.sql)
* [Reconstruire les index](./scripts/indexes/rebuild-indexes.sql)
* [Trouver les index inutiles](./scripts/indexes/useless-indexes.sql)
* [Trouver les index manquants #1](./scripts/indexes/missing-indexes-1.sql)
* [Trouver les index manquants #2](./scripts/indexes/missing-indexes-2.sql)
* [Déterminer la sélectivité des colonnes d'un index](./scripts/mssql/indexes/selectivite-index.sql)

### Clé primaire / Clés étrangères / Contraintes

* [Supprimer et recréer toutes les contraintes](./scripts/pk_fk_constraints/drop-create-of-all-existing-constraints.sql)
* [Supprimer toutes les clés étrangères d'une base de données](./scripts/pk_fk_constraints/drop-all-fk-from-db.sql)
* [Lister toutes les tables qui n'ont pas de clés étrangères](./scripts/pk_fk_constraints/find-tables-that-do-not-have-foreign-keys.sql)
* [Lister toutes les dépendances de la base de données](./scripts/pk_fk_constraints/list-all-the-dependencies-of-the-database.sql)
* [Lister les tables orphelines (sans contraintes d'intégrité référentielle)](./scripts/pk_fk_constraints/orphan-tables.sql)
* [Lister les tables contenant des identifiants mais sans clés étrangères](./scripts/pk_fk_constraints/tables-containing-id-columns-with-no-foreign-key.sql)
* [Lister les tables avec contraintes, valeurs par défaut, règles, déclencheurs, ...](./scripts/pk_fk_constraints/tables-with-constraints-default-values-rules-triggers-and-how-many.sql)
* [Lister les tables sans clé primaire](./scripts/pk_fk_constraints/tables-without-primary-key.sql)
* [Lister les tables sans index clustered (et sans aucun index également)](./scripts/pk_fk_constraints/tables-without-clustered-index.sql)
* [Top 10 des tables les plus indexées](./scripts/pk_fk_constraints/top-10-most-indexed-tables.sql)
* [Lister les tables avec des clés étrangères](./scripts/pk_fk_constraints/find-tables-with-fk.sql)

### Triggers

* [Trouver tous les déclencheurs positionnés](./scripts/triggers/find-all-triggers.sql)

### Cycle de vie de la donnée

* [Supprimer un historique de données d'une table en fonction de ses dépendances](./scripts/data_lifecycle/delete-historical-data-from-a-table-according-to-its-dependencies.sql)
* [Un résumé de la structure des tables](./scripts/data_lifecycle/summary-of-tables-structures.sql)
* [Obtenir le contenu de chaque colonne d'une table](./scripts/data_lifecycle/get-content-of-each-column-in-a-specified-table.sql)
* [Obtenir la longueur maximale d'une donnée](./scripts/data_lifecycle/max-data-length.sql)
* [Obtenir le nombre de tables par schéma](./scripts/data_lifecycle/number-of-tables-per-schema.sql)
* [Lister les tables qui n'ont pas de documentation dans les propriétés étendues](./scripts/data_lifecycle/tables-without-documentation-in-extended-properties.sql)
* [Recherche un colonne dans l'ensemble des tables d'une base de données](./scripts/data_lifecycle/using-a-column-in-a-database.sql)
* [Analyse d'impact](./scripts/data_lifecycle/impact-analysis.sql)
* [Suppression de données en lot](./scripts/data_lifecycle/batch-delete.sql)

### Procédures stockées

* [Exécuter une procédure stockée](./scripts/stored_procedures/execute-instructions-stored-in-database.sql)
* [Lister toutes les procédures stockées d'une base de données](./scripts/stored_procedures/retrieve-all-stored-procedures.sql)

### BCP

* [Générer l'instruction BCP pour une table spécifiée](./scripts/bcp/generate-bcp-instruction-for-a-table.sql)
* [Générer l'instruction BCP pour l'ensemble des tables d'une base de données](./scripts/bcp/generate-bcp-instruction-for-all-the-tables-in-db.sql)

### Vues

* [Obtenir la composition d'une vue](./scripts/view/view-composition.sql)

### Audit

* [Obtenir l'espace disponible pour un serveur](./scripts/audit/available-space.sql)
* [Obtenir la date de la dernière sauvegarde réalisée](./scripts/audit/last-backup-date.sql)
* [Vérification de la mémoire utilisée](./scripts/audit/memory-usage-check.sql)
* [Obtenir le nombre de lignes et l'espace occupé (alloué, utilisé et inutilisé) par chaque table](./scripts/audit/number-rows-and-table-space.sql)
* [Obtenir les informations système du serveur de base de données](./scripts/audit/rdbms-system-informations.sql)
* [Réaliser un diagnostic pour SQL Server 2012](./scripts/audit/sqlserver-2012-diagnostic-information.sql)
* [Recalcule les statistiques des tables](./scripts/audit/compute-statistics.sql)
* [Obtenir la fragmentation détaillée des index](./scripts/audit/detailed-index-fragmentation.sql)
* [Obtenir la fragmentation des index](./scripts/audit/limited-index-fragmentation.sql)
* [Volumetrie présente dans la base de données](./scripts/audit/volumetry.sql)
* [Obtenir les dernières modifications réalisées sur la base de données](./scripts/audit/latest-modification-made.sql)
* [Top 20 des requêtes les plus longues](./scripts/audit/top-20-longest-queries.sql)
* [Obtenir la liste optimales des colonnes pour définir une clé primaire](./scripts/audit/optimal-set-of-columns.sql)
* [Obtenir le statut d'un job](./scripts/audit/job-status.sql)
* [Obtenir la structure des tables de la base de données](./scripts/audit/one-stop-view-of-tables-structure.sql)
* [Obtenir la liste des objets de chaque table](./scripts/audit/each-objects-of-tables.sql)

## Liens utiles

* [Cycles Adventure Works](https://docs.microsoft.com/fr-fr/previous-versions/sql/sql-server-2008/ms124825(v=sql.100)?redirectedfrom=MSDN) - Exemple de base de données
* [Adventure Works](https://docs.microsoft.com/fr-fr/previous-versions/sql/sql-server-2008/ms124501(v=sql.100)?redirectedfrom=MSDN) - Exemple de base de données
* [SQL Authority](https://blog.sqlauthority.com/) - Une référence sur MS SQL Server
* [SQL Server Maintenance Solution](https://ola.hallengren.com/) - Solution de maintenance pour MS SQL Server (sauvegarde, intégrité référentielle, plan de maintenance des index et des statistiques, ...) réalisé par [Ola Hallengren](https://github.com/olahallengren)

## Dépôts utiles

* [Ola Hallengren](https://github.com/olahallengren)

## Réalisé avec

* [Git](https://git-scm.com)

## Contributions

Si vous souhaitez contribuer, lisez le fichier CONTRIBUTING.md pour savoir comment procéder.