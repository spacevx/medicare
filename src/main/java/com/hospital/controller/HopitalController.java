package com.hospital.controller;

import com.hospital.model.*;
import com.hospital.util.FileUrgence;
import com.hospital.util.Persistance;
import com.hospital.util.Registre;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

public class HopitalController implements Serializable {
    private static final String FICHIER_SAUVEGARDE = "resources/hopital.ser";

    private final Registre<Patient> patients = new Registre<>();
    private final Registre<Medecin> medecins = new Registre<>();
    private final Registre<Infirmier> infirmiers = new Registre<>();
    private final List<Soin> soins = new ArrayList<>();
    private final List<Salle> salles = new ArrayList<>();
    private final Map<String, Medecin> medecinParMatricule = new HashMap<>();
    private final TreeMap<LocalDate, List<Soin>> planningJournalier = new TreeMap<>();
    private final FileUrgence<ActeChirurgical> fileUrgences = new FileUrgence<>();

    public Patient ajouterPatient(String nom, String prenom, LocalDate dateNaissance, String numeroSecu) {
        Patient p = new Patient(nom, prenom, dateNaissance, numeroSecu);
        patients.ajouter(p);
        return p;
    }

    public void supprimerPatient(int id) {
        Patient p = patients.getParId(id);
        if (p == null) throw new PatientNonTrouveException(id);
        patients.supprimer(p);
    }

    public Patient getPatient(int id) {
        Patient p = patients.getParId(id);
        if (p == null) throw new PatientNonTrouveException(id);
        return p;
    }

    public List<Patient> getTousPatients() {
        return patients.getTous();
    }

    public Medecin ajouterMedecin(String nom, String prenom, LocalDate dateNaissance, String matricule, String service, String specialite) {
        Medecin m = new Medecin(nom, prenom, dateNaissance, matricule, service, specialite);
        medecins.ajouter(m);
        medecinParMatricule.put(matricule, m);
        return m;
    }

    public void supprimerMedecin(int id) {
        Medecin m = medecins.getParId(id);
        if (m != null) {
            medecinParMatricule.remove(m.getMatricule());
            medecins.supprimer(m);
        }
    }

    public Medecin getMedecin(int id) {
        return medecins.getParId(id);
    }

    public Medecin getMedecinParMatricule(String matricule) {
        return medecinParMatricule.get(matricule);
    }

    public List<Medecin> getTousMedecins() {
        return medecins.getTous();
    }

    public Infirmier ajouterInfirmier(String nom, String prenom, LocalDate dateNaissance, String matricule, String service) {
        Infirmier inf = new Infirmier(nom, prenom, dateNaissance, matricule, service);
        infirmiers.ajouter(inf);
        return inf;
    }

    public void supprimerInfirmier(int id) {
        Infirmier inf = infirmiers.getParId(id);
        if (inf != null) infirmiers.supprimer(inf);
    }

    public List<Infirmier> getTousInfirmiers() {
        return infirmiers.getTous();
    }

    public Consultation ajouterConsultation(Patient patient, Medecin medecin, String description, double cout, String diagnostic) {
        Consultation c = new Consultation(LocalDateTime.now(), description, cout, medecin, diagnostic);
        soins.add(c);
        patient.soigner(c);
        medecin.soigner(c);
        planningJournalier.computeIfAbsent(c.getDate().toLocalDate(), k -> new ArrayList<>()).add(c);
        return c;
    }

    public ActeChirurgical ajouterActeChirurgical(Patient patient, Medecin medecin, String description, double cout, int niveauUrgence, String salle) {
        ActeChirurgical acte = new ActeChirurgical(LocalDateTime.now(), description, cout, medecin, niveauUrgence, salle);
        soins.add(acte);
        patient.soigner(acte);
        medecin.soigner(acte);
        fileUrgences.ajouter(acte);
        planningJournalier.computeIfAbsent(acte.getDate().toLocalDate(), k -> new ArrayList<>()).add(acte);
        return acte;
    }

    public List<Soin> getTousSoins() {
        return Collections.unmodifiableList(soins);
    }

    public Salle ajouterSalle(String numero, String type, int capacite) {
        Salle s = new Salle(numero, type, capacite);
        salles.add(s);
        return s;
    }

    public void supprimerSalle(int id) {
        salles.removeIf(s -> s.getId() == id);
    }

    public List<Salle> getToutesSalles() {
        return Collections.unmodifiableList(salles);
    }

    public List<Patient> filtrerPatients(String nom, String etat, Boolean admis) {
        return patients.getTous().stream()
                .filter(p -> nom == null || p.getNomComplet().toLowerCase().contains(nom.toLowerCase()))
                .filter(p -> etat == null || p.getEtatSante().equalsIgnoreCase(etat))
                .filter(p -> admis == null || p.estAdmis() == admis)
                .collect(Collectors.toList());
    }

    public List<Medecin> filtrerMedecins(String nom, String specialite, String service) {
        return medecins.getTous().stream()
                .filter(m -> nom == null || m.getNomComplet().toLowerCase().contains(nom.toLowerCase()))
                .filter(m -> specialite == null || m.getSpecialite().equalsIgnoreCase(specialite))
                .filter(m -> service == null || m.getService().equalsIgnoreCase(service))
                .collect(Collectors.toList());
    }

    public List<Soin> filtrerSoins(String type, Medecin medecin, LocalDate date) {
        return soins.stream()
                .filter(s -> type == null || s.getType().equalsIgnoreCase(type))
                .filter(s -> medecin == null || s.getMedecin().equals(medecin))
                .filter(s -> date == null || s.getDate().toLocalDate().equals(date))
                .collect(Collectors.toList());
    }

    public List<Patient> trierPatients(Comparator<Patient> comparateur) {
        return patients.trier(comparateur);
    }

    public List<Medecin> trierMedecins(Comparator<Medecin> comparateur) {
        return medecins.trier(comparateur);
    }

    public FileUrgence<ActeChirurgical> getFileUrgences() {
        return fileUrgences;
    }

    public TreeMap<LocalDate, List<Soin>> getPlanningJournalier() {
        return planningJournalier;
    }

    public List<Soin> getSoinsParDate(LocalDate date) {
        return planningJournalier.getOrDefault(date, Collections.emptyList());
    }

    public double tauxOccupationMoyen() {
        return salles.stream()
                .mapToDouble(Salle::getTauxOccupation)
                .average()
                .orElse(0);
    }

    public Map<String, Long> patientsParEtat() {
        return patients.getTous().stream()
                .collect(Collectors.groupingBy(Patient::getEtatSante, Collectors.counting()));
    }

    public double coutMoyenSoins() {
        return soins.stream()
                .mapToDouble(Soin::getCout)
                .average()
                .orElse(0);
    }

    public Map<Medecin, Long> soinsParMedecin() {
        return soins.stream()
                .collect(Collectors.groupingBy(Soin::getMedecin, Collectors.counting()));
    }

    public void sauvegarder() throws IOException {
        new File("resources").mkdirs();
        Persistance.sauvegarder(this, FICHIER_SAUVEGARDE);
    }

    public static HopitalController charger() {
        try {
            return Persistance.charger(FICHIER_SAUVEGARDE);
        } catch (Exception e) {
            return new HopitalController();
        }
    }
}
