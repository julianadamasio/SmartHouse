// Agent sample_agent in project smartHome

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */


+!start : true <- .print("hello world.").

+status(0): true
<- lookupArtifact(luz1, ArtId);
	//focus(ArtId);
	.print("Id artefato", ArtId);
	operaDispositivo[artifact_id(ArtId)];
	.print("ligou luz 2584");
	.
//+!ligarDispositivo : status(Status)[artifact_id(ArtId)]  & Status == 0
+!ligarDispositivo : status(Status) & Status == 0
<- 
	//lookupArtifact(luz1, ArtId);
	//focus(ArtId);
	//.print("Id artefato", ArtId);
	operaDispositivo[artifact_id(ArtId)];
	.print("ligou luz");
.

{ include("$jacamoJar/templates/common-cartago.asl") }
//{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation  
{ include("$jacamoJar/templates/org-obedient.asl") }
