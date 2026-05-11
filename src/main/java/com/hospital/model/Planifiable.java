package com.hospital.model;

import java.time.LocalDateTime;
import java.util.List;

public interface Planifiable {
    void planifier(LocalDateTime dateDebut, LocalDateTime dateFin);
    List<LocalDateTime[]> getPlanning();
    boolean estDisponible(LocalDateTime date);
}
