package com.hospital.model;

public class PatientNonTrouveException extends RuntimeException {
    public PatientNonTrouveException(int id) {
        super("Patient non trouvé avec l'ID: " + id);
    }
}
