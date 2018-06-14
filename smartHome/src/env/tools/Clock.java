// CArtAgO artifact code for project smartHome


package tools;


import java.util.logging.Logger;


import cartago.Artifact;

import cartago.INTERNAL_OPERATION;

import cartago.OPERATION;

import cartago.ObsProperty;


public class Clock extends Artifact {

	private int valorHora = 0;
	private Logger logger = Logger.getLogger("clock."+Clock.class.getName());
	boolean counting;
	final static long TICK_TIME = 5000;

	void init(){
		//valorHora = 0;
		counting = false;
		execInternalOp("start");
		//logger.info("Entrou no init");
	}


	@OPERATION 
	void start(){
	   //logger.info("Entrou no start");
		if (!counting){
			counting = true;
			execInternalOp("count");
		} else {
			failed("already_counting");
		}
	}

	@OPERATION 
	void stop(){
		counting = false;
	}

	@INTERNAL_OPERATION 
	void count(){
		//logger.info("Entrou no count");
		while (counting){
			//hora = valida24h(valorHora);
			await_time(TICK_TIME);
			signal("tick", valorHora);
			valida24h(valorHora);
			//logger.info("count Tick e:"+ valorHora);
		} 
	}


	@OPERATION
	int valida24h(int valorH){
		//logger.info("Entrou no 24h" + valorH);
		if(valorH<23){
			valorHora= valorH + 1;   
		}else{
			valorHora=0;
		}    
		//logger.info("valida24 Tick e atualizado:"+ valorHora);
		return valorHora;
	}


}