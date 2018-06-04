// CArtAgO artifact code for project smartHome

package tools;

import java.util.ArrayList;
import cartago.*;
import jason.environment.grid.Location;

public class Local extends Artifact {
	private ArrayList<Dispositivo> listDispositivos;
	private int idDispositivo;
	private String tipoDispos;
	
	void init(int idDispositivo, String tipoDispos) {
		listDispositivos = new ArrayList<Dispositivo>();
		this.idDispositivo = idDispositivo;
		this.tipoDispos = tipoDispos;
		//defineObsProperty("count", initialValue);
	}
	
	@OPERATION
	void put(){
		listDispositivos.add(new Dispositivo(idDispositivo, tipoDispos));
	}
	
	
	@OPERATION
	void inc() {
		ObsProperty prop = getObsProperty("count");
		prop.updateValue(prop.intValue()+1);
		signal("tick");
	}
}

