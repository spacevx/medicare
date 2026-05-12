package com.hospital.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Infirmier extends Personnel implements Planifiable {
    private final List<LocalDateTime[]> planning = new ArrayList<>();

    public Infirmier(String nom, String prenom, LocalDate dateNaissance, String matricule, String service) {
        super(nom, prenom, dateNaissance, matricule, service);
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
        return "Inf. " + getNomComplet() + " - " + getService();
    }
}
