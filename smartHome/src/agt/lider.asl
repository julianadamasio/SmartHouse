// Agent sample_agent in project smartHome

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("Presente.").


+tick(24): round(N)
<- 		
		if(N == 0){
			!verificarLigar(24);
			!verificarDesligar(24);
			.wait(100);
			!verificarFinal;
			NovoValor = N+1;
			.abolish(round(N));
			+round(NovoValor);
			.wait(100);
		}else{
			if(N == 1){
				!verificarLigar2(24);
				!verificarDesligar2(24);
				.wait(100);
				!verificarFinal;
				.abolish(round(N));
				+round(0);
				.wait(100);
			}
		}

.

//crença do relógio
+tick(Horario)
<-  
	?round(N);
	
	if(N == 0){
		.print("Hora: ", Horario);
		!verificarLigar(Horario);
		!verificarDesligar(Horario);
		.print("Round ", N);	 
	}else{
		if(N == 1){
			.print("Hora: ", Horario);
			!verificarLigar2(Horario);
			!verificarDesligar2(Horario);
			.print("Round ", N);
		}
	}
.

+!verificarFinal
<- 

	for(termineiligar(NomeAgent,Nome,Works,Custo,ArtId)){
			.print("Nome Agente ", NomeAgent, " Atividade " ,  Nome , " Local ", Works , " Custo ", Custo , " ArtId", ArtId);
					
	}
	for(termineidesligar(NomeAgent1,Nome1,Works1,Custo1,ArtId1)){
			.print("Nome Agente1 ", NomeAgent1, " Atividade1 " ,  Nome1 , " Local1 ", Works1 , " Custo1 ", Custo1 , " ArtId1 ", ArtId1);
			
	}	
	.findall(Custo, termineiligar(NomeAgent,Nome,Works,Custo,ArtId), L);
	.findall(Custo1, termineidesligar(NomeAgent1,Nome1,Works1,Custo1,ArtId1), L1);
	!custoSoma(L, L1);
	.wait(100);
	.abolish(termineiligar(NomeAgent,Nome,Works,Custo,ArtId)); //remove todas as crenças
	.abolish(termineidesligar(NomeAgent1,Nome1,Works1,Custo1,ArtId1)); //remove todas as crenças
.

+!custoSoma(L, L1) 
<- 	
	S = math.sum(L) +  math.sum(L1);
	.print("Soma total", S);
.

//quando for a hora certa, manda para o agente selecionado.
+!verificarLigar(Horario) : timeOn(Horario)
<- 
	for(timeOn(Horario)[artifact_id(ArtId)]){
		?focused(Works,Nome[_],ArtId);
		?posxy(Xd, Yd)[artifact_id(ArtId)];
		//.print("posicao X artefato: ", Xd , " posicao y artefato: ", Yd, " ArtefatoId: ", ArtId);
		!findAgent(Xd,Yd,ArtId);
		?minDist(Ag, Dist);
		.print("Agent com menor distância: ", Ag, " com distância: ", Dist);
		.send(Ag, achieve, ligardispositivo(Nome,ArtId,Works, Dist));	
	}
.

//quando não for a hora certa não faz nada
+!verificarLigar(Horario).
		
//quando for a hora certa, manda para o agente selecionado.
+!verificarDesligar(Horario) : timeOff(Horario)
<- 
	for(timeOff(Horario)[artifact_id(ArtId)]){
		?focused(Works,Nome[_],ArtId);
		?posxy(Xd,Yd)[artifact_id(ArtId)];
		//.print("posicao X artefato: ", Xd , " posicao y artefato: ", Yd, " ArtefatoId: ", ArtId);
		!findAgent(Xd,Yd,ArtId);
		?minDist(Ag, Dist);
		.print("Agent com menor distância ", Ag , " com distância ", Dist);
		.send(Ag, achieve, desligardispositivo(Nome,ArtId,Works,Dist));
	}
.

//quando não for a hora certa não faz nada
+!verificarDesligar(Horario).



//quando for a hora certa, manda para o agente selecionado.
+!verificarLigar2(Horario) : timeOn(Horario)
<- 
	for(timeOn(Horario)[artifact_id(ArtId)]){
		?focused(Works,Nome[_],ArtId);
		?posxy(Xd, Yd)[artifact_id(ArtId)];
		//.print("posicao X artefato: ", Xd , " posicao y artefato: ", Yd, " ArtefatoId: ", ArtId);
		selecionaAgente(Ag);
		.print("Agent selecionado: ", Ag);		
		.send(Ag, achieve, ligardispositivo1(Nome,ArtId,Works));	
	}
.

+!verificarLigar2(Horario).

+!verificarDesligar2(Horario) :  timeOff(Horario)
<- 
	for(timeOff(Horario)[artifact_id(ArtId)]){
		?focused(Works,Nome[_],ArtId);
		?posxy(Xd,Yd)[artifact_id(ArtId)];
		//.print("posicao X artefato: ", Xd , " posicao y artefato: ", Yd, " ArtefatoId: ", ArtId);
		selecionaAgente(Ag);
		.print("Agent selecionado: ", Ag);
		.send(Ag, achieve, desligardispositivo1(Nome,ArtId,Works));
	}
.

+!verificarDesligar2(Horario).


//encontra o agente com menor distancia
+!findAgent(Xd, Yd, ArtId)  
	<-	
		for (mypos(Xa,Ya)[source(A)]){
			!calcDistancia(Xa, Ya, Xd, Yd, D);
			+distAgent(A,D,ArtId);
		};
		
		!getMin;
		?minDist(Ag, Dist);
	 	.abolish(distAgent(_,_,_)); //remove todas as crenças
	.

//pega o menor valor de distância entre o agente e o artefato.	
+!getMin : true
<-
	 .findall(dist(D, A), distAgent(A,D,ArtId), L);
	 .sort(L,L2); //ordem crescente, ordena a lista, pega uma lista e põe ordenada em outra
	 .nth(0,L2,dist(D2,A2)); //pega a primeira posição da lista ordenada
	  +minDist(A2, D2);
.

//calcula a distancia entre a posicao do artefato e do agente.	
+!calcDistancia(X1, Y1, X2, Y2, D): true
	<- 
		D = math.abs(X1 - X2) + math.abs(Y1 - Y2);
.	



{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation  
//{ include("$jacamoJar/templates/org-obedient.asl") }
