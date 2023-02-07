# MaxiProsit_Git

Comment réaliser une application/site de génération de document pour prosit ?


	Tout d’abord nous allons voir ce qu’est un prosit afin de comprendre l’intérêt de créer une application ou site permettant de générer des documents de prosit. Un prosit est un petit projet qui à pour but d’apporter des connaissances aux étudiants, celles ci qui serviront à un projet fil rouge. 
Un prosit se décompose en trois parties : 
-	Le « Prosit Aller » est une séance collective encadrée par les tuteurs d’un durée d’une heure et qui a pour objectif d’analyser et de clarifier le problème présenté et de construire un plan d’action pour le résoudre.
-	L’AER (Activité d’Etudes et de Recherche) d’une durée de 1 à 2 jours, cette séquence à pour but d’une part, d’acquérir individuellement les notions identifiées comme nécessaires à la résolution du problème, et d’autre part de proposer et de confronter entre les membres du groupe, les solutions possibles au problème. Pendant cette phase, les élèves sont en autonomie, ils peuvent utiliser les outils et ressources qui leur sont propres, en plus de celles fournies sur le centre de ressources « Moodle ». Les tuteurs peuvent être sollicités pour apporter des compléments d’information.
-	Le « Prosit Retour » est une séance collective encadrée par les tuteurs, d’une durée d’une heure et qui permet de valider les solutions proposées au problème par les groupes et à faire le bilan des apprentissages individuels et collectifs.

L’intérêt de l’application/site va être de créer un document qui va centraliser les informations données au « Prosit Aller » (comme le contexte, les problématiques ou encore les mots clés). Ce document servira alors de fil conducteur pour la séance d’AER afin de s’assurer d’avoir suffisamment de connaissances pour le prosit retour. Et enfin pour le prosit retour, il servira de support. Maintenant que nous sommes fixés sur les objectifs de notre application/site nous allons pouvoir choisir le Framework et le langage de programmation adapté. 

	Il est important de bien sélectionner un Framework et un langage de programmation pour un projet, car cela peut avoir un impact considérable sur la qualité, la rapidité et la facilité de développement du produit final. Il en existe de nombreux disponibles, chacun ayant ses propres avantages et inconvénients.

Pour choisir un bon Framework et un bon langage de programmation, il est important de prendre en compte les besoins spécifiques du projet, ainsi que les caractéristiques et les fonctionnalités des différents outils disponibles. La popularité et la communauté sont également des éléments importants à considérer, des Framework et des langages de programmation populaires ayant généralement une communauté active qui peut aider à résoudre les problèmes et à trouver des solutions.

La documentation et les ressources disponibles sont également un facteur important à prendre en compte. Des Framework et des langages de programmation avec une bonne documentation et des ressources en ligne peuvent faciliter l'apprentissage et la résolution des problèmes.

La performance et les fonctionnalités sont également des facteurs importants à considérer. Il est important de choisir un Framework et un langage de programmation qui répondent aux exigences en termes de performance et de fonctionnalités.

Enfin, la compatibilité et la facilité de déploiement sont des éléments clés à prendre en compte. Il est obligatoire de choisir des outils compatibles avec les plateformes et systèmes d'exploitation utilisés et faciles à déployer.

Flutter est un excellent choix pour le développement d'applications mobiles car il permet de créer des interfaces utilisateur hautement personnalisables en utilisant des widgets natifs pour iOS et Android. 
Flutter est un Framework open-source pour le développement d'applications multi-plateformes. Il est développé par Google et utilise le langage de programmation Dart. Il permet de créer des applications hautement performantes, esthétiques et offrant une expérience utilisateur fluide pour un grand nombre de plates-formes, comme iOS, Android, MacOs, Windows, Linux et le web.

Il utilise un modèle de programmation orienté widget, où toutes les parties de l'interface utilisateur sont des widgets. Il offre un grand nombre de widgets prédéfinis qui peuvent être utilisés pour construire des interfaces utilisateur, comme des boutons, des entrées de texte, des images, etc. Il utilise un moteur graphique personnalisé appelé Skia pour dessiner des widgets, ce qui permet de créer des interfaces utilisateur hautement personnalisables et performantes.

Il utilise également un système de gestion d'état pour gérer les données et les interactions de l'application. Les widgets peuvent accéder à l'état de l'application via un arbre de contextes, ce qui permet de mettre à jour automatiquement l'interface utilisateur en fonction de l'état de l'application.

En utilisant Flutter, les développeurs peuvent utiliser un seul code source pour créer des applications pour différentes plates-formes, ce qui permet de réduire considérablement le coût et le temps de développement. Il est également facile à apprendre et à utiliser, grâce à la syntaxe claire et concise de Dart, son langage de programmation associé et à une communauté active qui fournit de nombreuses ressources et outils pour les développeurs.

En somme, Flutter est un choix flexible et puissant pour les développeurs qui cherchent à créer des applications performantes et esthétiques pour plusieurs plates-formes, avec un temps de développement et un coût réduit.


Dart est quant à lui un langage de programmation open-source développé par Google. Il a été conçu pour être facile à apprendre et à utiliser, tout en offrant des fonctionnalités avancées pour les développeurs expérimentés. Dart est utilisé principalement pour le développement d'applications mobiles et web, mais il peut également être utilisé pour le développement de logiciels de bureau et de serveur.

Dart possède une syntaxe similaire à celle de Java ou JavaScript, ce qui en fait un langage de programmation facile à apprendre pour les développeurs qui viennent de ces langages. Il offre des fonctionnalités telles que des classes, des fonctions, des variables, des boucles et des structures de contrôle de flux, ainsi que des fonctionnalités plus avancées telles que les types génériques et les expressions régulières.

Sans l’utilisation de Flutter, Dart utilise un modèle de programmation orienté objet, ce qui permet aux développeurs de créer des classes et des objets pour organiser leur code. Il prend en charge les fonctionnalités de programmation asynchrone, comme les promesses et les tâches asynchrones, pour gérer efficacement les opérations de longue durée.

Il possède un système de type fort, ce qui permet de garantir la qualité et la sécurité du code en vérifiant les types de données à la compilation. Il intègre également un système de génération de code, qui permet de générer automatiquement des parties du code en fonction de modèles prédéfinis, ce qui permet d'accélérer le développement et d'améliorer la qualité du code.

En résumé, Dart est un langage de programmation open-source développé par Google, qui est facile à apprendre, facile à utiliser, et offre des fonctionnalités avancées pour les développeurs expérimentés. Il est utilisé en conjonction avec Flutter pour créer des applications multiplateformes hautement performantes et esthétiques.

Nous avons donc tout ce qui nous faut pour créer notre application/site. Nous allons maintenant voir ce que nous devons obtenir comme résultat :
 
Le but est donc d’obtenir un résultat similaire à celui-ci-dessous. De préférence en format .docx ou .doc pour pouvoir modifier celui-ci sur Word ou un autre éditeur de texte.

Nous allons commencer par installer un IDE (Environnement de Développement Intégré) qui est une application logicielle qui aide les programmeurs à développer efficacement le code logiciel, compatible avec Flutter. Le meilleur et celui que je recommande est Visual Studio Code. Nous pouvons l’installer sur le site officiel via ce lien Installer VS Code. (https://code.visualstudio.com)





Ensuite il faudra installer Flutter, vous trouverez un tutoriel pour chaque plateforme sur ce lien (https://docs.flutter.dev/get-started/install). Une fois l’installation finie nous allons créer un nouveau projet : 
 
Cliquez sur View.
 
Puis sur Command Palette.
 
Et enfin Flutter : New Project.
 
Nous allons créer une Application de base.

Ensuite sélectionnez le dossier où vous voulez qu’il soit.
Puis donnez un nom à votre dossier projet.

Maintenant que le projet est créé nous allons supprimer ce qui se trouve a l’intérieur pour se retrouver avec ça : 
 


Commençons maintenant par la page d’accueil. Qui devra contenir un titre, de quoi accéder aux documents créés et de quoi créer un nouveau document :

Pour le titre il va se placer dans l’appbar du Scaffold : 
 
Ensuite nous allons créer un bouton « Nouveau document » qui se placera dans le corps (body) et au centre :
 
Et ensuite un bouton exemple pour accéder à un document déjà créé dans un colonne avec le bouton précédent :
 






Cela nous donne ce résultat :
 




Par la suite nous allons centrer le titre et retirer la bannière qui se trouve en haut à droite :
  
 

Passons maintenant à la réalisation de la page de documents :
	Il a falloir créer un nouveau fichier que l’on nommera « document.dart » :
 




	Et importons la librairie de base de Flutter :
 

Commençons par créer une liste qui contiens le nom des différentes catégories :
 

Maintenant créons un Widget qui permettra l’affichage de notre document :
 

Maintenant faisons en sorte que lors de l’appel de ce Widget, nous devons préciser un ID qui sera celui du document :
 

Nous allons maintenant créer un nouveau fichier avec une Classe qui gèrera la partie base de données sur les fichiers de la plateforme : 
Avant toute chose nous devons ajouter le package Hive à notre projet : 
 











Puis nous allons pouvoir gérer cette base de données : 
 
 
Maintenant nous allons pouvoir importer ce fichier dans notre fichier document :
 
Nous allons ensuite créer notre Objet db qui sera une dataBase :
 

Maintenant rajoutons l’Appbar du document :
 
Rajoutons maintenant le fait que l’ID précisé quand on appelle la page du document soit celle qui initialise la DataBase db :
 
Nous allons ensuite créer une liste qui va être notre façon de naviguer entre les différentes pages (Mots Clés, contexte, etc) et un entier qui représentera la page actuelle « currentIndex » :
 









Ajoutons une fonction qui nous permettra d’exporter le document en PDF : 
 







Nous ajoutons maintenant une Colonne qui contient pageList et un bouton à appeler la fonction précédente : 
 
Nous allons ensuite créer ce qui va nous servir à enregistrer le PDF : Il y aura un fichier pour ce qui n’est pas sur web :
 

Et celui qui nous servira pour le web : 
 















Nous pouvons maintenant passer à la conception des pages :
Nous allons commencer par celle avec les informations telles que le nom du Prosit ou l’URL du prosit :
 






Puis par le reste car les autres catégories peuvent se présenter de la même façon :
 





Et pour finir la fonction qui nous permettra de faire le lien entre la page de base et les deux autres :
 

Maintenant que nous avons fini le programme nous allons tester celui-ci sur différents appareils :
Commençons en application Windows :
	Notre page d’accueil ressemblera donc à ça :
 




	Nous avons ajouté un bouton permettant d’afficher plus d’options pour les documents :
 
Ils permettront de dupliquer ou de supprimer un document (avec une sécurité si jamais vous voulez le supprimer) :
 




Ouvrons maintenant un document avec un exemple de prosit :
 
Mettons des exemples dans les catégories : 
 




Maintenant cliquons sur le bouton exporter en PDF et choisissez où enregistrer le fichier.
Vous devrez vous retrouver avec un PDF ressemblant à cela : 
 



Pour tester sur Android il va falloir télécharger le logiciel Android Studio via ce lien. (https://developer.android.com/studio?gclid=Cj0KCQiA_bieBhDSARIsADU4zLfC_1ANyKuBE9v8uDi__LBI0NY51xD3RLfqJwpojunzpgHW3SkECZMaAgRbEALw_wcB&gclsrc=aw.ds)
Une fois installer il va falloir créer un Emulateur d’un smartphone Android :
 
Puis Virtual Device Manager : 
 



Cliquez sur « Create Device » et sélectionnez le smartphone que vous voulez, cliquez sur « Next » et choisissez la version d’Android que vous souhaitez.
Attendez le téléchargement et cliquez sur « Finir ».
Maintenant retournez sur Visual Studio Code avec votre projet d’ouvert puis cliquez ici :
 
Maintenant choisissez votre Emulateur :
 
Vous pouvez lancer le programme et tester si il marche bien.




Passons maintenant à la version web, il faudra avoir Chrome ou Edge d’installer et comme pour l’emulateur Android vous aurez juste à cliquer sur le navigateur web souhaité :
 

Nous allons maintenant voir les plateformes iOS et MacOs :
Il faudra aller sur un Mac, télécharger Xcode.
Maintenant ouvrez le Finder et allez sur votre dossier projet puis allez sur ios et ouvrez le fichier Runner.xcworkspace avec Xcode.
Vous vous retrouverez avec ça :
 
Allez sur Signing & Capabilities puis dans Team et ajoutez votre compte Apple.
Et pour le bundle Identifier remplacer le « exemple » par autre chose du genre « testing » ou « test ».

Ensuite il faudra ouvrir le terminal au niveau de votre projet.
 
Puis installez Cocoapods avec cette commande : 
 
Entrez votre mot de passe, et installez.
Maintenant vous pouvez télécharger Visual Studio Code
A présent ouvrez un simulateur iOS avec faisant command + space.




Puis ouvrez le projet sur Visual Studio Code.
Vous pouvez à présent choisir le simulateur ou essayer sur MacOs en application de bureau :
 

Et enfin pour finir voici une vidéo de démonstration sur chaque appareil ici (https://www.youtube.com/watch?v=PH6WYMqsip8) .
