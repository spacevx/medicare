package com.hospital.model;

public interface Soignable {
    void soigner(Soin soin);
    String getEtatSante();
}
