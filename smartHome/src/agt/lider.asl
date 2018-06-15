// Agent sample_agent in project smartHome

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("hello world.").

+tick(Horario)
<-  //.print("Hora", Horario);
	!verificar(Horario);
.

+!verificar(Horario) : timeOn(Horario) //& .lookup(Horario, Dispositivo)
<- 
	?timeOn(Horario)[artifact_id(ArtId)];
	.print("hora  ", Horario, "artefatoId  ", ArtId);
	 selecionaAgente(Ag);
	.print("agente selecionado  ", Ag);
	.send(Ag, achieve, ligarDispositivo(ArtId));
.



{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation  
//{ include("$jacamoJar/templates/org-obedient.asl") }
