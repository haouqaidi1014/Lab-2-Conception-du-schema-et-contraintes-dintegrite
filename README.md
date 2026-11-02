# Lab-2-Conception-du-schema-et-contraintes-dintegrite
1-introduction

2-Analyse du besoin métier:

en Liste des entités et attributs

Auteur : id (identifiant), nom, prénom, date_de_naissance (optionnel).

Ouvrage : id, titre, isbn, disponible (booléen), auteur_id (FK).

Abonné : id, nom, prénom, email (unique), date_inscription.

Emprunt : ouvrage_id (FK), abonne_id (FK), date_debut, date_fin (nullable).

cela permettre créer des relations et cardinalites tel que :

auteur->ouvrage : un auteur peut ecrire un ou plusieurs ouvrage (1,N),un ouvrage est ecrit par un seul auteur (1,1).    

abonne<->emprunt<->ouvrage: un abonne peut effectuer plusieur emprunt et c'est pour ca il y a le fk etet l'ouvrage peut faire l'objet de plusieurs emprunts 
    

    règles métier à retenir
    
Un ouvrage ne peut être emprunté que s'il est disponible. donc utiliser disponible=TRUE 
Un abonné ne peut pas emprunter le même ouvrage plusieurs fois simultanément.
Un email d'abonné doit être unique dans le système. avoir la contrainte UNIQUE

3-Normalisation:

4-Modélisation entité‑relation (ER): en utilisant draw.io et puis en organiser->inserer->avancee ->plantUML afin de utilise le uml simplifie dans le lab 
donc le diagramme resultant est :

<img width="1918" height="917" alt="Capture d&#39;écran 2026-11-02 213545" src="https://github.com/user-attachments/assets/7d8d9340-bf1f-4738-8e6a-eb715f585b71" />

5-Création de la base de données:

<img width="1913" height="1068" alt="Capture d&#39;écran 2026-11-02 215746" src="https://github.com/user-attachments/assets/3f65d112-c145-424c-a82b-9f5e5b2a98b0" />

6-Définition des types de données et du moteur:

<img width="1918" height="1077" alt="Capture d&#39;écran 2026-11-02 221629" src="https://github.com/user-attachments/assets/c6007604-65e4-4cac-a61a-6b6bea5c48d2" />

7-Création de la table Auteur:

<img width="1917" height="1077" alt="image" src="https://github.com/user-attachments/assets/04307274-f138-41b8-9460-3b3849d2e3f4" />

8-Création de la table Ouvrage: apres je liste SHOW auteur SHOW ouvrage ... pour une bonne lisibilite 

<img width="1917" height="1062" alt="image" src="https://github.com/user-attachments/assets/5d6be2e9-cdb3-4ccc-9aad-c13b668af741" />

9-Création de la table Abonné:

<img width="1917" height="1012" alt="image" src="https://github.com/user-attachments/assets/b640cfd5-8c7b-4e33-975e-005af518195d" />

10-Création de la table Emprunt:

<img width="1917" height="1012" alt="image" src="https://github.com/user-attachments/assets/806fc685-1b49-40a1-b30c-51d304d1c280" />

11-Indexation et tests de cohérence: et renvoie d’erreur 1062 (duplicate entry) 

<img width="1917" height="1030" alt="image" src="https://github.com/user-attachments/assets/4b302785-5833-4d7f-961c-ef0b3cfa8152" />

12-Gestion automatique de la disponibilité:

<img width="1917" height="1037" alt="image" src="https://github.com/user-attachments/assets/43618009-10b6-464c-b2c3-8e124f6f7f3a" />

les verifications des donnees :

<img width="1917" height="1025" alt="image" src="https://github.com/user-attachments/assets/c5470edb-4ee2-4070-a89d-faa2a7c20f96" />

<img width="1917" height="1045" alt="image" src="https://github.com/user-attachments/assets/06dcf794-69cd-43cf-b9b1-d92727989453" />

<img width="1917" height="1042" alt="image" src="https://github.com/user-attachments/assets/6af5afec-48f2-49e0-8330-f7030f295c8c" />

<img width="1907" height="1037" alt="image" src="https://github.com/user-attachments/assets/2ff82f3e-e5e9-48d3-bb49-1c74f2f57650" />


<img width="1198" height="122" alt="Capture d&#39;écran 2026-11-02 233831" src="https://github.com/user-attachments/assets/d5746cf7-2624-47f6-83c3-3dff2ff810cc" />







