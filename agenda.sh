#!/bin/sh
#BENCHERIF Ayman 11919631
#Je déclare qu'il s'agit de mon propre travail


agenda=agenda.csv
#les champs du csv sont: 
#nom_event,date_debut,date_fin,localisation,description,heure_debut,heure_fin
#le champ heure_debut est vide si il n'y a pas d'argument

aide()
{
	cat<<'FIN'
-a ou --add		ajouter un nouvel évènement dans l'agenda
-s ou --affichage 		affiche tous les évènements
-h ou --help		affiche l'aide et quitter l'aide
-t ou --trie 		permet d'afficher par ordre chronologique les évènements
-m ou --modifier    (en cours de réparation, ne fonctionne pas encore)

FIN

}

add()
{

	printf "Veuillez entrez le nom de l'évènement: \n"
	IFS= read -r nom_event
	printf "Entrez le jour  de l'évènement sous format jj \n"
	IFS= read -r day
	printf "Entrez le mois  de l'évènement sous format mm \n"
	IFS= read -r month
	printf "Entrez l'année  de l'évènement sous format aaaa \n"
	IFS= read -r year
	printf "Entrez la date de fin de l'évènement sous format jj/mm/aaaa:\n "
	IFS= read -r date_fin
	printf "Entrez la localisation de l'évènement: \n"
	IFS= read -r localisation
	printf "Entrez les détails de l'évènements:  \n "
	IFS= read -r description
	printf "Entrez l'heure du début du de l'évènement \n"
	IFS= read -r heure_debut
	printf "Entrez l'heure de fin de l'évènement \n"
	IFS= read -r heure_fin
	printf "%s,%s,%s,%s,%s,%s,%s,%s,%s\n" "$nom_event" "$day" "$month" "$year" "$date_fin" "$localisation" "$description" "$heure_debut" "$heure_fin" >>$agenda


}

incommingevent()
{
yearstoday=$(date '+%Y')
monthtoday=$(date '+%m')
daytoday=$(date '+%d')

	IFS=,
	while IFS=',' read -r nom_event day month year date_fin localisation description heure_debut heure_fin
	do
				
			
			if  [ $year -ge $yearstoday ]
			then
			
    			if [ $month -ge $monthtoday ]
    			 then
  					
    				if [  $day -ge $daytoday  ] #si la condition est réussi, affiche tous les évènements à venir
    				 then
    					
									echo "Evènement : $nom_event " 
									echo "Début: $day / $month / $year"
									echo "horaire de début d'évènement  : $heure_debut " 
									echo "Localisation :$localisation " 
									echo "Déscription importante de l'évènement : $description"
									echo " -----------------------------------------------------------------------------------------"
								
					fi
				fi
			fi
	done	

}


		




affichage()
{
	
	IFS=,
	while IFS=',' read -r nom_event day month year date_fin localisation description heure_debut heure_fin
	do
		echo "Evènement : $nom_event " 
									echo "Début: $day / $month / $year"
									echo "horaire de début d'évènement  : $heure_debut " 
									echo "Localisation :$localisation " 
									echo "Déscription importante de l'évènement : $description"
									echo " -----------------------------------------------------------------------------------------"
								
	done


}
evenement_trie()
{
	sort -n -k2,4 -t, "$agenda" | affichage #trie tout ce qui est dans affichage en utilisant -t ou --trie
	
}
#je laisse le code en commentaire cependant
#il ne fonctionne pas correctement et affiche plusieurs erreur, je ne vois pas comment faire bien que j'ai fais des  recherche.

modification()
{
	echo 'en construction'
	#read -r nom_event day month year date_fin localisation description heure_debut heure_fin  

		#printf "Veuillez entrez le nouveau nom de l'évènement: \n"
		#IFS= read -r new_nom_event
		#sed 's/$nom_event/$new_event/' 

		#printf "Veuillez entrez le nouveau jour de l'évènement: \n"
		#IFS= read -r new_jour_event
		#sed 's/$day/$new_jour_event/' 

		#printf "Veuillez entrez le nouveau mois de l'évènement: \n"
		#IFS= read -r new_month_event
		#sed 's/$month/$new_month_event/' 

		#printf "Veuillez entrez la nouvelle année de l'évènement: \n"
		#IFS= read -r new_year_event
		#sed 's/$year/$new_year_event/' 

		#printf "Veuillez entrez la nouvelle date de fin de l'évènement: \n"
		#IFS= read -r new_date_fin_event
		#sed 's/$date_fin/$new_date_fin_event/' 

		#printf "Veuillez entrez la nouvelle localisation de l'évènement: \n"
		#IFS= read -r new_localisation_event
		#sed 's/$localisation/$new_localisation_event/' 

		#printf "Veuillez entrez la nouvelle heure de début d'évènement: \n"
		#IFS= read -r new_heure_event
		#sed 's/$heure_debut/$new_heure_event/' 

		#printf "Veuillez entrez la nouvelle heure de fin de l'évènement: \n"
		#IFS= read -r new_heure_fin_event
		#sed 's/$heure_fin/$new_heure_fin_event/' 
	

		
}



evenement_trie_event_a_venir()
{
	sort -n -k2,4 -t, "$agenda" | incommingevent #trie tout ce qui est dans incommingevent par ordre chronologique des dates jour, mois, année
}

case $# in
0)
	aide <$agenda
	;;
1)
	case $1 in
	-a | --add)
		add
		;;
	-s | --affichage)
		affichage <$agenda
		;;
	-h | --help)
		aide <$agenda
		;;
	-t | --trie)
		evenement_trie <$agenda
		;;
	-av | --avenir)
		evenement_trie_event_a_venir <$agenda
		;;
	-m | --modifier)
		modification <$agenda
		;;
	*)
		aide >&2
		exit 1
	esac
	;;
*)
	aide >&2
	exit 1
	;;
esac