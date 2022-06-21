# Aux80

**Consignes des TP:**

*	TP1: Premier script
>Pré-requis  
>	1. Dans le répertoire utilisateur, créer un répertoire bin  
>	2. Se déconnecter de la session graphique et se ré-identifier  
>	3. Envoyer par en conversation privée la copie d’écran de la commande.  
>TP Premier scrip :  
>1. Dans ce répertoire créer un fichier timer.sh  
>2. Mettre en première ligne le shebang qui définit l’environnement d’exécution du script.  
>3. Renseigner trois commandes :  
>	Une commande echo avec un message d’acceuil :echo "Votre Message d'accueil"  
>	Une commande sleep faisant attendre 5s (voir le manuel pour l’usage de cette commande)  
>	Une commande echo avec un message de fin d’exécution :echo "Votre Message de fin de traitement"  
>4. Vérifier que le script fonctionne.  
>5. Rendre ce script exécutable.  
>6. Se placer à la racine, vérifier que vous pouvez exécuter le script  
* TP2 : Les arguments de script  
>1. Modifier le script timer.sh pour :  
>	Passer le message d’accueil en argument  
>	Passer le message de sortie en argument  
* TP3 : Redirection et fichier de log  
>1. Créer un répertoire ~/log  
>2. Ajouter un troisième argument recevant le nombre de seconde à attendre  
>3. Récupérer les erreurs de sleep pour les enregistrer dans un fichier de log daté.  
>Le fichier de log doit s’appeler timer.log  
* TP4 : Les conditions  
>1. En reprenant le script timer.sh : mettez en place une commande dépendant du code de sortie de  
>la commande sleep pour remplacer le message d’erreur pour un message que vous aurez rédigé pour l’occasion.  
>2. Proposer une ligne de commande permettant de réaliser les actions de script timer.sh en une seule ligne,  
>en utilisant les enchaînements de commandes logiques. 
* TP5 : test et if  
>1. Modifier le script timer.sh pour vérifier avec un test if si :  
>	il y a bien un répertoire de log.  
>	des chaines de caractères non-nulles pour $1, $2 et $3  
>2. Pour $3, trouver un moyen de vérifier que c’est bien un nombre qui est passé en paramètre.  
>3. Il est possible de gérer l’absence d’arguments directement en définissant une valeurpar défaut de la variable  
>de la manière suivante :  
>	var=${1:-valeurParDéfaut}  
>Ainsi une commande non suivi de son argument verra la variable $var prendre pour valeur “valeurParDéfaut” si $1 est nul.  
>Reparamétrer vos variables et options du script timer.sh pour définir des valeurs par défaut si les arguments  
>n’étaient pas fournis à la ligne de commande et adapter le script timer.sh en conséquence.  
* TP6 : Usage de for pour un script de sauvegarde  
> Pré-requis  
>	1. Créer un nouveau script sauvegarde.sh  
>	2. Créer un dossier backup dans le répertoire home de votre utilisateur  
>Avec ce script : 
>	1. Lister les répertoires du home de l’utilisateur connecté, et si un répertoire bin ou logexiste alors :  
>		Afficher un message de sauvegarde précisant quel répertoire est en cours de sauvegarde  
>		Copier chaque fichier de ce répertoire et afficher un message pour chaque fichierainsi sauvegardé  
>	2. Trouver une méthode qui permettrait de ne pas sauvegarder les fichiers déjà sauveg-ardés.  
>	3. Ajouter la gestion d’une option : si l’utilisateur tapesauvegarde.sh -h la commandene doit rien faire d’autre  
>	afficher un texte d’aide expliquant son fonctionnement.  
* TP7 : Les Fonctions  
> Adapter le script sauvegarde.sh pour que la gestion de l’aide devienne une fonction appelédans le corps du script  
* TP8 : Case  
> Adapter le script sauvegarde .sh et ajouter un case permettant de gérer les options suivantes :  
>	-d : permet d’indiquer le nom du fichier de destination de la sauvegarde.  
>	-s : permet d’indiquer le répertoire source a sauvegarder.  
>	-h : affiche l’aide.  
>	-v : affiche les messages plutôt que les écrire dans le fichier de log.  
* TP 08.1 : Chaines et sous-chaines  
>Rappel :  
>       ${chaine#souschaine} # Efface l'occurrence la plus courte# de $souschaine à partir du début de $chaine.      
>	${chaine##souschaine} # Efface l'occurrence la plus longue# de $souschaine à partir du début de $chaine.       
>	${chaine%souschaine} # Efface l'occurrence la plus courte de $souschaine# à partir de la fin de $chaine.       
>	${chaine%%souschaine} # Efface l'occurrence la plus longue de $souschaine,# en partant de la fin de $chaine.      
>1. En utilisant les paramètres -d et -s précédant pour la sauvegarde, ajouter le code nécessairepour :        
>	Extraire du chemin fourni par l’utilisateur les dossiers parents de la source et de la destination dans des variables distinctes.      
>	Extraire le nom du fichier ou dossier de la source et de la destination que l’on mettradans des variables distinctes.      
>2. L’objectif est donc d’avoir trois variables pour chaque option prenant un chemin en paramètre,par exemple pour -s :     
>	varCheminComplet : /home/$USER/bin     
>	varDossierParent : /home/$USER     
>	varFichierSauvegarde : bin     
* TP 09 : While  
> Maintenant que le case est fonctionnel pour toutes les options prévues pour notre script :  
>	1. Ajouter une syntaxe while pour faire une boucle qui répète le case autant de fois qu’il y a d’options à traiter  
>	quand on appelle le script sauvegarde.sh  
>	2. Adapter votre script pour mettre ce traitement des options dans une fonction
