// Agent sample_agent in project smartHome

/* Initial beliefs and rules */

/* Initial goals */

!start.

+!start: true 
	<- 
		.print("Presente");
		!generationposition;
		?mypos(X,Y);
		.send(lider, tell, mypos(X, Y));
		!generationBattery;
.


/* Plans */

//gera o x e y inicial dos agentes aleatoriamente.
+!generationposition: .random(X) & .random(Y) 
	<- 
		M = 100; 
		+mypos(math.round(M*X), math.round(M*Y));	
.

+!generationBattery: .random(B)
	<-  
	    +mybattery(math.round(5*B)+1);	 
	  // .print("bateria agente: ", B);
.

//se o dispositivo estiver com o status desligado, vai ligar o dispositivo
+!ligardispositivo(Nome,ArtId,Works,Dist) : status(Status) & Status == 0
<- 
	.my_name(NomeAgent);
	.print("peguei a atividade de ligar ", Nome, " do(a) ", Works);
	operaDispositivo[artifact_id(ArtId)];
	!calcBattery(Dist);
	?totBateria(Custo);
	.send(lider,tell,termineiligar(NomeAgent, Nome, Works, Custo, ArtId));
	-termineiligar(NomeAgent, Nome, Works, Custo, ArtId);
	-totBateria(Custo);
.


////se o dispositivo estiver com o status ligado, vai desligar o dispositivo
+!desligardispositivo(Nome1,ArtId1,Works1,Dist1) : status(Status) & Status == 1
<- 
	.my_name(NomeAgent);
	.print("peguei a atividade de desligar ", Nome1, " do(a) ", Works1);
	operaDispositivo[artifact_id(ArtId1)];
	!calcBattery(Dist1);
	?totBateria(Custo1);
	.send(lider,tell,termineidesligar(NomeAgent, Nome1, Works1, Custo1, ArtId1));
	-termineidesligar(NomeAgent, Nome1, Works1, Custo1, ArtId1);
	-totBateria(Custo1);
.


//se o dispositivo estiver com o status desligado, vai ligar o dispositivo
+!ligardispositivo1(Nome,ArtId,Works) : status(Status) & Status == 0
<- 
	.my_name(NomeAgent);
	.print("peguei a atividade de ligar ", Nome, " do(a) ", Works);
	operaDispositivo[artifact_id(ArtId)];
	?posxy(Xd,Yd)[artifact_id(ArtId)];
	.print("pos x artefato", Xd , " Pos Y ", Yd);
	?mypos(X,Y);
	//.print(" agenteX  ", X , " agent Y ", Y);
	!calcDistancia(X, Y, Xd, Yd);
	?distanciaTotal(D);	
	!calcBattery(D);
	?totBateria(Custo);
	//.print("total custo", Custo);
	.send(lider,tell,termineiligar(NomeAgent, Nome, Works, Custo, ArtId));
	-termineiligar(NomeAgent, Nome, Works, Custo, ArtId);
	-totBateria(Custo);
.

+!desligardispositivo1(Nome1,ArtId1,Works1) : status(Status) & Status == 1
<- 
	.my_name(NomeAgent);
	.print("peguei a atividade de desligar ", Nome1, " do(a) ", Works1);
	operaDispositivo[artifact_id(ArtId1)];
	?posxy(Xd,Yd)[artifact_id(ArtId1)];
	//.print("pos x artefato", Xd , " Pos Y ", Yd);
	?mypos(X,Y);
	//.print(" agenteX  ", X , " agent Y ", Y);
	!calcDistancia(X, Y, Xd, Yd);
	?distanciaTotal(D);	
	//.print("distancia total ", D);
	!calcBattery(D);
	?totBateria(Custo1);
	//.print("total custo", Custo1);
	.send(lider,tell,termineidesligar(NomeAgent, Nome1, Works1, Custo1, ArtId1));
	-termineidesligar(NomeAgent, Nome1, Works1, Custo1, ArtId1);
	-totBateria(Custo1);
.

+!calcDistancia(Xa, Ya, Xd,Yd)
	<- 	
		
		D = math.abs(Xa - Xd) + math.abs(Ya - Yd);
		//.print("Distancia calculo", D);
		+distanciaTotal(D);	
.


+!calcBattery(Dist) 
	<- 	
		 ?mybattery(B);
		 CB = Dist * B;
		 +totBateria(CB);
		//.print("custo total: ", CB);
.



{ include("$jacamoJar/templates/common-cartago.asl") }
//{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation  
{ include("$jacamoJar/templates/org-obedient.asl") }
