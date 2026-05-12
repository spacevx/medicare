package com.hospital.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Medecin extends Personnel implements Soignable, Planifiable {
    private String specialite;
    private final List<Soin> soinsEffectues = new ArrayList<>();
    private final List<LocalDateTime[]> planning = new ArrayList<>();

    public Medecin(String nom, String prenom, LocalDate dateNaissance, String matricule, String service, String specialite) {
        super(nom, prenom, dateNaissance, matricule, service);
        this.specialite = specialite;
    }

    public String getSpecialite() { return specialite; }
    public void setSpecialite(String specialite) { this.specialite = specialite; }
    public List<Soin> getSoinsEffectues() { return soinsEffectues; }

    @Override
    public void soigner(Soin soin) {
        soinsEffectues.add(soin);
    }

    @Override
    public String getEtatSante() {
        return "Actif - " + soinsEffectues.size() + " soins effectués";
    }

    @Override
    public void planifier(LocalDateTime dateDebut, LocalDateTime dateFin) {
        planning.add(new LocalDateTime[]{dateDebut, dateFin});
    }

    @Override
    public List<LocalDateTime[]> getPlanning() {
        return planning;
    }

    @Override
    public boolean estDisponible(LocalDateTime date) {
        return planning.stream()
                .noneMatch(p -> !date.isBefore(p[0]) && !date.isAfter(p[1]));
    }

    @Override
    public String toString() {
        return "Dr. " + getNomComplet() + " (" + specialite + ")";
    }
}
