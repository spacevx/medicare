package com.hospital.model;

import java.io.Serializable;
import java.time.LocalDate;

public abstract class Personne implements Serializable {
    private static int compteur = 0;

    private final int id;
    private String nom;
    private String prenom;
    private LocalDate dateNaissance;

    protected Personne(String nom, String prenom, LocalDate dateNaissance) {
        this.id = ++compteur;
        this.nom = nom;
        this.prenom = prenom;
        this.dateNaissance = dateNaissance;
    }

    public int getId() { return id; }
    public String getNom() { return nom; }
    public String getPrenom() { return prenom; }
    public LocalDate getDateNaissance() { return dateNaissance; }

    public void setNom(String nom) { this.nom = nom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }

    public String getNomComplet() {
        return prenom + " " + nom;
    }

    @Override
    public String toString() {
        return getNomComplet() + " (ID: " + id + ")";
    }
}
