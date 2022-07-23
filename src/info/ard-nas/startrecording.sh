#!/bin/bash

if [ $# -lt 2 ]; then
   echo "Usage: startrecording outputfile stopTime"
  exit
fi

OUTPUT=$1
shift
DURATION=$*

# Ajustement des paramètres de base de la carte
adjusttv
# Quand j'étais sur le coaxial, je devais ensuite ajuster le canal
#ivtv-tune -c$CHANNEL
# Mais à présent, je me contente de passer en mode S-Video pour
#  recevoir le signal de mon Illico
v4l2-ctl  -i 1
# En coaxial, ce serait ceci:
#v4l2-ctl  -i 0
#ivtv-tune -c3

# Maintenant, configurons ALSA pour le flux audio de sauvegarde
# Ajuste le volume au maximum pour l'entrée ligne, puis active le mode
#  de capture
amixer sset Line,0 100% cap
# Activation du premier périphérique de capture et désactivation du
#  second, pour éviter l'interférence.
amixer sset Capture,0 100% cap
amixer sset Capture,1 0% nocap
# Configuration du premier périphérique de capture sur l'entrée ligne
amixer sset "Input Source",0 Line

# Enregistrement A/V depuis le syntoniseur
cp /dev/video0 $OUTPUT &amp;
# Il faut prendre en note l'ID du processus qui copie, pour pouvoir le
#  tuer plus tard.
ID=$!
# Enregistrement du flux audio de sauvegarde
arecord -t wav -f cd -c 2 $OUTPUT.wav &amp;
IDA=$!
# Ancienne tentative pour le flux de sauvegarde
#cp /dev/video24 $OUTPUT-audioback &amp;
#IDA=$!

# Planifie une tâche pour la fin d'enregistrement
echo "kill $ID $IDA" | at $DURATION
if [ $? -ne 0 ]; then
  # Si jamais at échoue, on arrête tout au lieu de laisser le système
  # enregistrer indéfiniment
   kill $ID $IDA
   rm -f $OUTPUT
   rm -f $OUTPUT.wav
   echo "Error with at or cp"
fi
