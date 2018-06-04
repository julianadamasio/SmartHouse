// CArtAgO artifact code for project smartHome

package tools;

import cartago.*;

public class Dispositivos1 extends Artifact {
	
	
	void init(int initialValue) {
		defineObsProperty("count", initialValue);
	}
	
	@OPERATION
	void inc() {
		ObsProperty prop = getObsProperty("count");
		prop.updateValue(prop.intValue()+1);
		signal("tick");
	}
}

