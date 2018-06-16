// Agent sample_agent in project smartHome

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("hello world.").

+tick(Horario)
<-  .print("Hora: ", Horario);
	!verificar(Horario);
.

//quando for a hora certa, manda para o agente selecionado.
+!verificar(Horario) : timeOn(Horario)
<- 
	?timeOn(Horario)[artifact_id(ArtId)];
	?focused(Works,Nome[_],ArtId);
	 selecionaAgente(Ag);
	.print("agente selecionado  ", Ag);
	.send(Ag, achieve, ligardispositivo(Nome,ArtId,Works));
.

//quando for a hora certa, manda para o agente selecionado.
+!verificar(Horario) : timeOff(Horario) 
<- 
	?timeOff(Horario)[artifact_id(ArtId)];
	?focused(Works,Nome[_],ArtId);
	 selecionaAgente(Ag);
	.print("agente selecionado  ", Ag);
	.send(Ag, achieve, desligardispositivo(Nome,ArtId,Works));
.

//quando não for a hora certa não faz nada
+!verificar(Horario).

//quando não for a hora certa não faz nada
//+!verificartimeon(Horario).

+terminei(NomeAgent, Nome, Works) 
<- 
	.print("O agente: ", NomeAgent, " terminou a atividade: ", Nome, " do(a) ", Works);
.


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation  
//{ include("$jacamoJar/templates/org-obedient.asl") }
