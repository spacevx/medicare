package com.hospital.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public abstract class Soin implements Serializable {
    private static int compteur = 0;

    private final int id;
    private LocalDateTime date;
    private String description;
    private double cout;
    private Medecin medecin;

    protected Soin(LocalDateTime date, String description, double cout, Medecin medecin) {
        this.id = ++compteur;
        this.date = date;
        this.description = description;
        this.cout = cout;
        this.medecin = medecin;
    }

    public int getId() { return id; }
    public LocalDateTime getDate() { return date; }
    public String getDescription() { return description; }
    public double getCout() { return cout; }
    public Medecin getMedecin() { return medecin; }

    public void setDate(LocalDateTime date) { this.date = date; }
    public void setDescription(String description) { this.description = description; }
    public void setCout(double cout) { this.cout = cout; }
    public void setMedecin(Medecin medecin) { this.medecin = medecin; }

    public abstract String getType();

    @Override
    public String toString() {
        return getType() + " - " + description + " (" + cout + "€)";
    }
}
