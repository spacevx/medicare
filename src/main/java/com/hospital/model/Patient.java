package com.hospital.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Patient extends Personne implements Soignable, Facturable {
    private String numeroSecu;
    private String etatSante;
    private LocalDate dateAdmission;
    private LocalDate dateSortie;
    private final List<Soin> dossierMedical = new ArrayList<>();
    private final List<String> antecedents = new ArrayList<>();

    public Patient(String nom, String prenom, LocalDate dateNaissance, String numeroSecu) {
        super(nom, prenom, dateNaissance);
        this.numeroSecu = numeroSecu;
        this.etatSante = "Stable";
    }

    public String getNumeroSecu() { return numeroSecu; }
    public LocalDate getDateAdmission() { return dateAdmission; }
    public LocalDate getDateSortie() { return dateSortie; }
    public List<Soin> getDossierMedical() { return dossierMedical; }
    public List<String> getAntecedents() { return antecedents; }

    public void setNumeroSecu(String numeroSecu) { this.numeroSecu = numeroSecu; }
    public void setEtatSante(String etatSante) { this.etatSante = etatSante; }

    public void admettre() {
        this.dateAdmission = LocalDate.now();
        this.dateSortie = null;
    }

    public void sortir() {
        this.dateSortie = LocalDate.now();
    }

    public boolean estAdmis() {
        return dateAdmission != null && dateSortie == null;
    }

    public void ajouterAntecedent(String antecedent) {
        antecedents.add(antecedent);
    }

    @Override
    public void soigner(Soin soin) {
        dossierMedical.add(soin);
    }

    @Override
    public String getEtatSante() {
        return etatSante;
    }

    @Override
    public double calculerCout() {
        return dossierMedical.stream()
                .mapToDouble(Soin::getCout)
                .sum();
    }

    @Override
    public String genererFacture() {
        return "Facture patient " + getNomComplet() + " - Total: " + calculerCout() + "€";
    }

    @Override
    public String toString() {
        return getNomComplet() + " [" + numeroSecu + "] - " + etatSante;
    }
}
