###############################################################
scaletta demo
###############################################################

1) Deployment di topologia senza servizi

- disegnare topologia
- validate
- deploy: comando deploy dentro la console del topology

- entrare negli OSHI far vedere le routes: attendere che i nodi 
  siano effettivamente raggiungibili, in caso di dubbio pingare il nodo  

- entrare nei cer e provare ping

2) Deployment di topologia con vll

- disegnare topologia (aggiungere il ctrl, ATTENZIONE in alcune topologie gia' ci sta)
- disegnare la vll
- validate
- deploy

- start controller con verbose
	
	dal terminale del controller dentro il topoloy
	cd /home/user/workspace/dreamer-ryu/ryu/app
	ryu-manager --verbose --observe-links ofctl_rest.py rest_topology

	oppure usare il ryu_launcher.sh (modificare prima il path di default
	da my_workspace a workspace, e mettere --verbose se necessario, 
	lo script sta alla fine del README se serve)

- creare le vll da un terminale della VM (spostando il file di configurazione)

	dal un terminale dentro la VM	
	cp workspace/Dreamer-Mininet-Extensions/vll_pusher.cfg workspace/Dreamer-VLL-Pusher/ryu/
	cd workspace/Dreamer-VLL-Pusher/ryu/
	(recuperare indirizzo ip del controller)
	./vll_pusher.py --controller indirizzo_controller:8080 --add

	oppure usare lo script per l'avvio dei servizi alla fine della pag
	(./nome_script indirizzo_controller )

- aprire shell dei cer e pingare ip che stanno sulla stessa network

	es: ping -c 6 10.0.11.1



3) Deployment di topologia con vss

- disegnare topologia (aggiungere il ctrl, ATTENZIONE in alcune topologie gia' ci sta)
- disegnare il vss
- validate
- deploy

- start controller con verbose

	dal terminale del controller dentro il topology
	cd /home/user/workspace/dreamer-ryu/ryu/app
	ryu-manager --verbose --observe-links ofctl_rest.py rest_topology

	oppure usare il ryu_launcher.sh (modificare prima il path di default
	da my_workspace a workspace, e mettere --verbose se necessario, 
	lo script sta alla fine del README se serve)
	

- creare il vss da un terminale della VM (spostando il file di configurazione)
	
	attendere nella console di deploy del topology  che il vs sia configurato 
	ATTENZIONE il vs deve avere almeno 3 nodi, anche se viene validato con 2

	dal un terminale dentro la VM
	cp workspace/Dreamer-Mininet-Extensions/vll_pusher.cfg workspace/Dreamer-VLL-Pusher/ryu/
	cd workspace/Dreamer-VLL-Pusher/ryu/
	(recuperare indirizzo ip del controller)
	./vll_pusher.py --controller indirizzo_controller:8080 --add

	oppure usare lo script per l'avvio dei servizi alla fine della pag
	(./nome_script indirizzo_controller )

- aprire shell dei cer e pingare ip che stanno sulla stessa network

	es: ping -c 6 10.0.11.1



###############################################################
possibili problemi
###############################################################

- Consumo di cpu elevato sulla VM

	killall VBoxClient 

	(perdi il copia e incolla)

- nodi mininet ancora non connessi con ssh 

	usare il comando cmd_reconnect per ritentare la connessione
	e controllare l'output sulla console di node.js
	in generle conviene mettere un ping e aspettare

- nodi mininet non raggiungibili

	controllare se ci sono sovrapposizioni tra la network usata da virtualbox 
	e quelle utilizzate da mininet 
	possibili soluzioni: 1)cambiare il tipo di rete da NAT a bridged su virtualbox
	2)togliere la connessione dalla VM

- la shell non cattura il Ctrl-C
	
	usare comandi che non vanno interrotti es ping -c 10 10.0.5.1

- il ryu launcher non funziona
	
	cambiare il path da my_workspace a workspace


##############################################################
oshi start script
##############################################################

scompattare il tar dentro la home 

rendere i file eseguibili se non lo sono già

creare i launcher sul desktop click col destro create launcher

	nel launcher "go" mettere come comando 

		/home/user/start_all.sh start

	selezionare l'icona scegliendola dal percorso 
	tutto il resto può essere lasciato in bianco


	nel launcher "update" mettere come comando 
		
		/home/user/start_all.sh start	

	selezionare l'icona scegliendola dal percorso
	tutto il resto può essere lasciato in bianco



IMPORTANTE il prog Dreamer-Mininet-Extensions non e' aggiornato su github
quindi bisogna fare l'update a mano

	git remote remove origin

	git remote add origin https://Siracusano@bitbucket.org/ssalsano/dreamer-mininet-extensions.git 

	(metti il link con il tuo username, lo trovi sulla pag web del repo)

	git pull origin master

configura i path di Dreamer-Mininet-Extensions

	in /home/user/workspace/Dreamer-Mininet-Extensions/mininet_deployer.py

	parser_path = "../Dreamer-Topology-Parser-and-Validator/"

	in /home/user/workspace/Dreamer-Mininet-Extensions/mininet_extensions.py

	RYU_PATH = '/home/user/workspace/dreamer-ryu/ryu/app/'
	PROJECT_PATH = '/home/user/workspace/Dreamer-Mininet-Extensions/'


##############################################################
ryu start script == ryu_launcher.sh
##############################################################

copiare tutto quello qui sotto in un file dentro /root
e renderlo eseguibile 


#!/bin/bash

echo -e "\n"
echo "#################################################"
echo "##     DREAMER IP/SDN Hyibrid RYU Launcher     ##"
echo "##                                             ##"
echo "##  The process can last many minutes. Please  ##"
echo "##  wait and do not interrupt the process.     ##"
echo "#################################################"

WORKSPACE="workspace"
cd /home/user/$WORKSPACE/dreamer-ryu/ryu/app
ryu-manager --observe-links ofctl_rest.py rest_topology



##############################################################
service start script
##############################################################

copiare tutto quello qui sotto in un file dentro /home/user
e renderlo eseguibile
./activate_services indirizzo_controller


#!/bin/bash

if [ $1 ]; then

	echo -e "\n"
	echo "#################################################"
	echo "##     DREAMER IP/SDN service Launcher         ##"
	echo "##                                             ##"
	echo "##  The process can last many minutes. Please  ##"
	echo "##  wait and do not interrupt the process.     ##"
	echo "#################################################"

	cp workspace/Dreamer-Mininet-Extensions/vll_pusher.cfg workspace/Dreamer-VLL-Pusher/ryu/
	cd workspace/Dreamer-VLL-Pusher/ryu/
	./vll_pusher.py --controller $1:8080 --add

else
	echo "Usage: specify controller ip!!"

fi
