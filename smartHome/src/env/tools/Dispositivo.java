package tools;


public class Dispositivo {
	private int		idDispositivo;
	private String 	tipoDispositivo;
	
	public Dispositivo(int idDispositivo, String tipoDispositivo){
		this.idDispositivo		=  idDispositivo;
		this.tipoDispositivo	=  tipoDispositivo;
	}
	
	public int getIdDispos() {
		return idDispositivo;
	}
	public String getTipoDispos() {
		return tipoDispositivo;
	}
}
