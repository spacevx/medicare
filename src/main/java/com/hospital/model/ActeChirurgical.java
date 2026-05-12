package com.hospital.model;

import java.time.LocalDateTime;

public class ActeChirurgical extends Soin implements Urgence {
    private int niveauUrgence;
    private String salle;

    public ActeChirurgical(LocalDateTime date, String description, double cout, Medecin medecin, int niveauUrgence, String salle) {
        super(date, description, cout, medecin);
        this.niveauUrgence = niveauUrgence;
        this.salle = salle;
    }

    public String getSalle() { return salle; }
    public void setSalle(String salle) { this.salle = salle; }
    public void setNiveauUrgence(int niveauUrgence) { this.niveauUrgence = niveauUrgence; }

    @Override
    public int getNiveauUrgence() {
        return niveauUrgence;
    }

    @Override
    public boolean estCritique() {
        return niveauUrgence >= 4;
    }

    @Override
    public String getType() {
        return "Acte Chirurgical";
    }
}
