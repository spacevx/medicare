package com.hospital.model;

import java.time.LocalDate;

public abstract class Personnel extends Personne {
    private String matricule;
    private String service;

    protected Personnel(String nom, String prenom, LocalDate dateNaissance, String matricule, String service) {
        super(nom, prenom, dateNaissance);
        this.matricule = matricule;
        this.service = service;
    }

    public String getMatricule() { return matricule; }
    public String getService() { return service; }

    public void setMatricule(String matricule) { this.matricule = matricule; }
    public void setService(String service) { this.service = service; }

    @Override
    public String toString() {
        return super.toString() + " - " + service + " [" + matricule + "]";
    }
}
