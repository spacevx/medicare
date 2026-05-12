package com.hospital.util;

import com.hospital.controller.HopitalController;
import com.hospital.model.*;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

public class CsvLoader {

    public static void charger(HopitalController ctrl, String basePath, Function<String, InputStream> resolver) {
        List<Medecin> medecins = chargerMedecins(ctrl, resolver.apply(basePath + "medecins.csv"));
        chargerInfirmiers(ctrl, resolver.apply(basePath + "infirmiers.csv"));
        List<Patient> patients = chargerPatients(ctrl, resolver.apply(basePath + "patients.csv"));
        chargerSalles(ctrl, resolver.apply(basePath + "salles.csv"));
        chargerSoins(ctrl, patients, medecins, resolver.apply(basePath + "soins.csv"));
    }

    private static List<Medecin> chargerMedecins(HopitalController ctrl, InputStream is) {
        List<Medecin> list = new ArrayList<>();
        for (String[] cols : lireCsv(is)) {
            list.add(ctrl.ajouterMedecin(cols[0], cols[1], LocalDate.parse(cols[2]), cols[3], cols[4], cols[5]));
        }
        return list;
    }

    private static void chargerInfirmiers(HopitalController ctrl, InputStream is) {
        for (String[] cols : lireCsv(is)) {
            ctrl.ajouterInfirmier(cols[0], cols[1], LocalDate.parse(cols[2]), cols[3], cols[4]);
        }
    }

    private static List<Patient> chargerPatients(HopitalController ctrl, InputStream is) {
        List<Patient> list = new ArrayList<>();
        for (String[] cols : lireCsv(is)) {
            Patient p = ctrl.ajouterPatient(cols[0], cols[1], LocalDate.parse(cols[2]), cols[3]);
            if (cols.length > 4 && !cols[4].isBlank()) p.setEtatSante(cols[4]);
            if (cols.length > 5 && "true".equals(cols[5])) p.admettre();
            if (cols.length > 6 && !cols[6].isBlank()) {
                for (String ant : cols[6].split(";")) {
                    p.ajouterAntecedent(ant.trim());
                }
            }
            list.add(p);
        }
        return list;
    }

    private static void chargerSalles(HopitalController ctrl, InputStream is) {
        for (String[] cols : lireCsv(is)) {
            ctrl.ajouterSalle(cols[0], cols[1], Integer.parseInt(cols[2]));
        }
    }

    private static void chargerSoins(HopitalController ctrl, List<Patient> patients, List<Medecin> medecins, InputStream is) {
        for (String[] cols : lireCsv(is)) {
            Patient patient = patients.get(Integer.parseInt(cols[1]));
            Medecin medecin = medecins.get(Integer.parseInt(cols[2]));
            double cout = Double.parseDouble(cols[4]);

            if ("consultation".equals(cols[0])) {
                ctrl.ajouterConsultation(patient, medecin, cols[3], cout, cols[5]);
            } else {
                int urgence = Integer.parseInt(cols[6]);
                ctrl.ajouterActeChirurgical(patient, medecin, cols[3], cout, urgence, cols[7]);
            }
        }
    }

    private static List<String[]> lireCsv(InputStream is) {
        List<String[]> rows = new ArrayList<>();
        if (is == null) return rows;
        try (var reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            reader.readLine(); // skip header
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.isBlank()) rows.add(line.split(",", -1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows;
    }
}
