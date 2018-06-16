// Agent sample_agent in project smartHome

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */


+!start : true <- .print("hello world.").


//se o dispositivo estiver com o status desligado, vai ligar o dispositivo
+!ligardispositivo(Nome,ArtId,Works) : status(Status) & Status == 0
<- 
	.my_name(NomeAgent);
	operaDispositivo[artifact_id(ArtId)];
	.print("peguei a atividade de ligar ", Nome, " do(a) ", Works);
	.send(lider,tell,terminei(NomeAgent, Nome, Works));
.

////se o dispositivo estiver com o status ligado, vai desligar o dispositivo
+!desligardispositivo(Nome,ArtId,Works) : status(Status) & Status == 1
<- 
	.my_name(NomeAgent);
	.print("peguei a atividade de desligar ", Nome, " do(a) ", Works);
	operaDispositivo[artifact_id(ArtId)];
	//.print("desligou o artefato ", Nome, " do(a) ", Works);
	.send(lider,tell,terminei(NomeAgent, Nome, Works));
.



{ include("$jacamoJar/templates/common-cartago.asl") }
//{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation  
{ include("$jacamoJar/templates/org-obedient.asl") }
