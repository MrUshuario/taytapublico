package pe.gob.pension65.tayta.model;

import android.os.Parcel;
import android.os.Parcelable;

public class Padron implements Parcelable {
	
	String codigoPadron;
	String dni;
	String paterno;
	String materno;
	String nombres;
	String sexo;
	String fechaNacimiento;
	String ubigeo;
	String departamento;
	String provincia;
	String distrito;
	String sdireccion;
	String centroPoblado;
	String latitud;
	String longitud;
	String perope;
	String edad;
	String ddireccion;
	String direccionP65;
	int codigoTipoCondicion;
	String descripcionCondicion;
	String fechaVisita;
	int usuario;
	double distancia;
	int prioridad;
	String fechaVencimientoCSE;

	String contactoTelefonico;
	String personaContacto;

	public Padron(Parcel in) {
		codigoPadron = in.readString();
		dni = in.readString();
		paterno = in.readString();
		materno = in.readString();
		nombres = in.readString();
		sexo = in.readString();
		fechaNacimiento = in.readString();
		ubigeo = in.readString();
		departamento = in.readString();
		provincia = in.readString();
		distrito = in.readString();
		sdireccion = in.readString();
		centroPoblado = in.readString();
		latitud = in.readString();
		longitud = in.readString();
		perope = in.readString();
		edad = in.readString();
		ddireccion = in.readString();
		direccionP65 = in.readString();
		codigoTipoCondicion = in.readInt();
		descripcionCondicion = in.readString();
		fechaVisita = in.readString();
		usuario = in.readInt();
		distancia = in.readDouble();
		prioridad = in.readInt();
		contactoTelefonico = in.readString();
		personaContacto = in.readString();
		fechaVencimientoCSE = in.readString();
	}

	public static final Creator<Padron> CREATOR = new Creator<Padron>() {
		@Override
		public Padron createFromParcel(Parcel in) {
			return new Padron(in);
		}

		@Override
		public Padron[] newArray(int size) {
			return new Padron[size];
		}
	};

    public Padron() {
		codigoPadron = "";
		dni = "";
		paterno = "";
		materno = "";
		nombres = "";
		sexo = "";
		fechaNacimiento = "";
		ubigeo = "";
		departamento = "";
		provincia = "";
		distrito = "";
		sdireccion = "";
		centroPoblado = "";
		latitud = "";
		longitud = "";
		perope = "";
		edad = "";
		ddireccion = "";
		direccionP65 = "";
		codigoTipoCondicion = 0;
		descripcionCondicion = "";
		fechaVisita = "";
		usuario = 0;
		distancia = 0.0;
		prioridad = 0;

		contactoTelefonico = "";
		personaContacto = "";
		fechaVencimientoCSE = "";
    }

	public String getCodigoPadron() {
		return codigoPadron;
	}

	public void setCodigoPadron(String codigoPadron) {
		this.codigoPadron = codigoPadron;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getPaterno() {
		return paterno;
	}

	public void setPaterno(String paterno) {
		this.paterno = paterno;
	}

	public String getMaterno() {
		return materno;
	}

	public void setMaterno(String materno) {
		this.materno = materno;
	}

	public String getNombres() {
		return nombres;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public String getUbigeo() {
		return ubigeo;
	}

	public void setUbigeo(String ubigeo) {
		this.ubigeo = ubigeo;
	}

	public String getDepartamento() {
		return departamento;
	}

	public void setDepartamento(String departamento) {
		this.departamento = departamento;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getDistrito() {
		return distrito;
	}

	public void setDistrito(String distrito) {
		this.distrito = distrito;
	}

	public String getSdireccion() {
		return sdireccion;
	}

	public void setSdireccion(String sdireccion) {
		this.sdireccion = sdireccion;
	}

	public String getCentroPoblado() {
		return centroPoblado;
	}

	public void setCentroPoblado(String centroPoblado) {
		this.centroPoblado = centroPoblado;
	}

	public String getLatitud() {
		return latitud;
	}

	public void setLatitud(String latitud) {
		this.latitud = latitud;
	}

	public String getLongitud() {
		return longitud;
	}

	public void setLongitud(String longitud) {
		this.longitud = longitud;
	}

	public String getPerope() {
		return perope;
	}

	public void setPerope(String perope) {
		this.perope = perope;
	}

	public String getEdad() {
		return edad;
	}

	public void setEdad(String edad) {
		this.edad = edad;
	}

	public String getDdireccion() {
		return ddireccion;
	}

	public void setDdireccion(String ddireccion) {
		this.ddireccion = ddireccion;
	}

	public String getDireccionP65() {
		return direccionP65;
	}

	public void setDireccionP65(String direccionP65) {
		this.direccionP65 = direccionP65;
	}

	public int getCodigoTipoCondicion() {
		return codigoTipoCondicion;
	}

	public void setCodigoTipoCondicion(int codigoTipoCondicion) {
		this.codigoTipoCondicion = codigoTipoCondicion;
	}

	public String getDescripcionCondicion() {
		return descripcionCondicion;
	}

	public void setDescripcionCondicion(String descripcionCondicion) {
		this.descripcionCondicion = descripcionCondicion;
	}

	public String getFechaVisita() {
		return fechaVisita;
	}

	public void setFechaVisita(String fechaVisita) {
		this.fechaVisita = fechaVisita;
	}

	public int getUsuario() {
		return usuario;
	}

	public void setUsuario(int usuario) {
		this.usuario = usuario;
	}

	public double getDistancia() {
		return distancia;
	}

	public void setDistancia(double distancia) {
		this.distancia = distancia;
	}

	public int getPrioridad() {
		return prioridad;
	}

	public void setPrioridad(int prioridad) {
		this.prioridad = prioridad;
	}

	public String getContactoTelefonico() {
		return contactoTelefonico;
	}

	public void setContactoTelefonico(String contactoTelefonico) {
		this.contactoTelefonico = contactoTelefonico;
	}

	public String getPersonaContacto() {
		return personaContacto;
	}

	public void setPersonaContacto(String personaContacto) {
		this.personaContacto = personaContacto;
	}

	public String getFechaVencimientoCSE() {return fechaVencimientoCSE; }

	public void setFechaVencimientoCSE(String fechaVencimientoCSE) { this.fechaVencimientoCSE = fechaVencimientoCSE; }

	@Override
	public int describeContents() {
		return 0;
	}

	@Override
	public void writeToParcel(Parcel parcel, int i) {

		parcel.writeString(codigoPadron);
		parcel.writeString(dni);
		parcel.writeString(paterno);
		parcel.writeString(materno);
		parcel.writeString(nombres);
		parcel.writeString(sexo);
		parcel.writeString(fechaNacimiento);
		parcel.writeString(ubigeo);
		parcel.writeString(departamento);
		parcel.writeString(provincia);
		parcel.writeString(distrito);
		parcel.writeString(sdireccion);
		parcel.writeString(centroPoblado);
		parcel.writeString(latitud);
		parcel.writeString(longitud);
		parcel.writeString(perope);
		parcel.writeString(edad);
		parcel.writeString(ddireccion);
		parcel.writeString(direccionP65);
		parcel.writeInt(codigoTipoCondicion);
		parcel.writeString(descripcionCondicion);
		parcel.writeString(fechaVisita);
		parcel.writeInt(usuario);
		parcel.writeDouble(distancia);
		parcel.writeInt(prioridad);
		parcel.writeString(contactoTelefonico);
		parcel.writeString(personaContacto);
		parcel.writeString(fechaVencimientoCSE);

	}
}
