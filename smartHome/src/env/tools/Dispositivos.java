// CArtAgO artifact code for project smartHome

package tools;

import cartago.*;

public class Dispositivos extends Artifact {
	private int quantL;
	
	void init(int quantL, int quantC, int quantR, int quantTv) {
		//defineObsProperty("comodo", comodo);
		defineObsProperty("quantidade_luz", quantL);
		this.quantL = quantL;
		defineObsProperty("quantidade_ar", quantC);
		defineObsProperty("quantidade_robo", quantR);
		defineObsProperty("quantidade_tv", quantTv);
	}
	
	@OPERATION
	void apagaluz() {
		ObsProperty prop = getObsProperty("quantidade_luz");
		if(prop.intValue() <= quantL ){
			prop.updateValue(prop.intValue()+1);
			signal("apaga_luz");
		}else{
			signal("luztaapagada");
		}
	}
}

