package com.hospital.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Salle implements Serializable {
    private static int compteur = 0;

    private final int id;
    private String numero;
    private String type;
    private int capacite;
    private final Set<Patient> patientsPresents = new HashSet<>();

    public Salle(String numero, String type, int capacite) {
        this.id = ++compteur;
        this.numero = numero;
        this.type = type;
        this.capacite = capacite;
    }

    public int getId() { return id; }
    public String getNumero() { return numero; }
    public String getType() { return type; }
    public int getCapacite() { return capacite; }
    public Set<Patient> getPatientsPresents() { return patientsPresents; }

    public void setNumero(String numero) { this.numero = numero; }
    public void setType(String type) { this.type = type; }
    public void setCapacite(int capacite) { this.capacite = capacite; }

    public void ajouterPatient(Patient patient) {
        if (patientsPresents.size() >= capacite) {
            throw new CapaciteDepasseeException("Salle " + numero + " pleine (" + capacite + " lits)");
        }
        patientsPresents.add(patient);
    }

    public void retirerPatient(Patient patient) {
        patientsPresents.remove(patient);
    }

    public int getLitsDisponibles() {
        return capacite - patientsPresents.size();
    }

    public double getTauxOccupation() {
        return capacite == 0 ? 0 : (double) patientsPresents.size() / capacite * 100;
    }

    @Override
    public String toString() {
        return "Salle " + numero + " (" + type + ") - " + patientsPresents.size() + "/" + capacite;
    }
}
