#!/bin/bash
# wf.sh : Compte la fréquence de répétition des mots d'un fichier texte.
# Ceci est une version plus efficace du script "wf2.sh".
# Source: http://abs.traduc.org/abs-5.3-fr/ch15s04.html

# Vérifie si un fichier a été fourni en ligne de commande.
ARGS=1
E_MAUVAISARGS=65
E_FICHIERINEXISTANT=66

if [ $# -ne "$ARGS" ]   #  Le nombre d'arguments passés au script
                        #+ est-il correct ?
then
  echo "Usage: `basename $0` nomfichier"
  exit $E_MAUVAISARGS
fi

if [ ! -f "$1" ]       # Est-ce que le fichier existe ?
then
  echo "Le fichier \"$1\" n'existe pas."
  exit $E_FICHIERINEXISTANT
fi



################################################################################
# main ()
sed -e 's/\.//g'  -e 's/\,//g' -e 's/ /\
/g' "$1" | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr
#                           =========================
#                           Fréquence des occurrences

#  Enlève les points et les virgules, et
#+ change les espaces entre les mots en retours chariot,
#+ puis met les lettres en minuscule et
#+ enfin préfixe avec le nombre d'apparition et
#+ effectue un tri numérique.

#  Arun Giridhar suggère la modification de ce qui est ci-dessus par :
#  . . . | sort | uniq -c | sort +1 [-f] | sort +0 -nr
#  Ceci ajoute une clé de tri secondaire, donc les instances des mêmes
#+ occurences sont triées alphabétiquement.
#  Comme il l'explique :
#  "Ceci est effectivement un tri radical, le premier étant sur la colonne
#+ la moins significatrice
#+ (mot ou chaîne, et une option pour ne pas être sensible à la casse)
#+ et le dernier étant la colonne la plus significative (fréquence)."
#
#  Ainsi que l'explique Frank Wang, voici l'équivalent de ci-dessus
#+       . . . | sort | uniq -c | sort +0 -nr
#+ et le reste fonctionne aussi :
#+       . . . | sort | uniq -c | sort -k1nr -k
################################################################################

exit 0
