package com.hospital.model;

import java.time.LocalDateTime;

public class Consultation extends Soin {
    private String diagnostic;
    private String prescription;

    public Consultation(LocalDateTime date, String description, double cout, Medecin medecin, String diagnostic) {
        super(date, description, cout, medecin);
        this.diagnostic = diagnostic;
    }

    public String getDiagnostic() { return diagnostic; }
    public String getPrescription() { return prescription; }

    public void setDiagnostic(String diagnostic) { this.diagnostic = diagnostic; }
    public void setPrescription(String prescription) { this.prescription = prescription; }

    @Override
    public String getType() {
        return "Consultation";
    }
}
