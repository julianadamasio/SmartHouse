// CArtAgO artifact code for project smartHome

package tools;

import cartago.*;

public class Dispositivos extends Artifact {

	void init(String tipoDispositivo, int status) {
		defineObsProperty("tipoDispositivo", tipoDispositivo);
		defineObsProperty("status", status);
	}

	@OPERATION
	void operaDispositivo(ArtifactId idArt) {

		//ObsProperty tipoD = getObsProperty("tipoDispositivo");
		ObsProperty statusD = getObsProperty("status");

		if(statusD.intValue() == 0){
			signal("liga");
		}else{
			signal("desliga");
		}

	}

}