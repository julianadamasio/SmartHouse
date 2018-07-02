// CArtAgO artifact code for project smartHome

package tools;

import cartago.*;

public class Dispositivos extends Artifact {

	void init(int status, int posx, int posy, int timeOn, int timeOff) {
		defineObsProperty("status", status);
		defineObsProperty("posxy", posx , posy);
		//defineObsProperty("posy", posy);
		defineObsProperty("timeOn", timeOn);
		defineObsProperty("timeOff", timeOff);
	}

	@OPERATION
	void operaDispositivo() {
		ObsProperty statusD = getObsProperty("status");
		
		if(statusD.intValue() == 0){
			statusD.updateValue(1);
			
		}else{
			statusD.updateValue(0);
		
		}

	}

}