// CArtAgO artifact code for project smartHome

package tools;

import cartago.*;

public class Dispositivos extends Artifact {

	void init(String tipoDispositivo, int status, int timeOn, int timeOff) {
		defineObsProperty("tipoDispositivo", tipoDispositivo);
		defineObsProperty("status", status);
		defineObsProperty("timeOn", timeOn);
		defineObsProperty("timeOff", timeOff);
	}

	@OPERATION
	void operaDispositivo() {
		//ObsProperty tipoD = getObsProperty("tipoDispositivo");
		ObsProperty statusD = getObsProperty("status");
		
		//se for desligado, liga
		// se for ligado, desliga
		if(statusD.intValue() == 0){
			statusD.updateValue(1);
			System.out.println("[ArtDispositivos] Ligou");
			//fazer print
			//signal("liga");
		}else{
			statusD.updateValue(0);
			System.out.println("[ArtDispositivos] Desligou");
			//fazer print
			//signal("desliga");
		}

	}

}