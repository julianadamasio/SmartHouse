// CArtAgO artifact code for project smartHome

package tools;

import java.util.Random;
import java.util.logging.Logger;

import cartago.*;

public class AlgoritmoSelecao extends Artifact {
	private Logger logger = Logger.getLogger("AlgoritmoSelecao."+AlgoritmoSelecao.class.getName());
	
	void init() {
		//defineObsProperty("count", initialValue);
	}
	
	@OPERATION
	void selecionaAgente(OpFeedbackParam ag) {
		//logger.info("Entrou no selecionaAgente");
		Random r = new Random();
		final int H = 10;
		final int L = 1;
		int selecionado = (int)( r.nextDouble () * ( H-L )) + L;
		String selecionado1 = Integer.toString(selecionado);
		String agente = "operador";
		ag.set(agente.concat(selecionado1));
	}
	
}

