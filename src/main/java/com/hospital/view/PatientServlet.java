package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {

    private HopitalController getController() {
        return (HopitalController) getServletContext().getAttribute("controller");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HopitalController ctrl = getController();
        String action = req.getParameter("action");

        if ("form".equals(action)) {
            String id = req.getParameter("id");
            if (id != null) {
                req.setAttribute("patient", ctrl.getPatient(Integer.parseInt(id)));
            }
            req.setAttribute("activePage", "patients");
            req.getRequestDispatcher("/WEB-INF/jsp/patient-form.jsp").forward(req, resp);
        } else if ("dossier".equals(action)) {
            Patient patient = ctrl.getPatient(Integer.parseInt(req.getParameter("id")));
            req.setAttribute("patient", patient);
            req.setAttribute("activePage", "patients");
            req.getRequestDispatcher("/WEB-INF/jsp/patient-dossier.jsp").forward(req, resp);
        } else {
            String nom = req.getParameter("nom");
            String etat = req.getParameter("etat");
            String admisStr = req.getParameter("admis");
            Boolean admis = (admisStr != null && !admisStr.isEmpty()) ? Boolean.valueOf(admisStr) : null;

            req.setAttribute("patients", ctrl.filtrerPatients(
                    nom != null && !nom.isBlank() ? nom : null,
                    etat != null && !etat.isBlank() ? etat : null,
                    admis
            ));
            req.setAttribute("activePage", "patients");
            req.getRequestDispatcher("/WEB-INF/jsp/patients.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HopitalController ctrl = getController();
        String action = req.getParameter("action");

        switch (action) {
            case "add" -> ctrl.ajouterPatient(
                    req.getParameter("nom"),
                    req.getParameter("prenom"),
                    LocalDate.parse(req.getParameter("dateNaissance")),
                    req.getParameter("numeroSecu")
            );
            case "update" -> {
                Patient p = ctrl.getPatient(Integer.parseInt(req.getParameter("id")));
                p.setNom(req.getParameter("nom"));
                p.setPrenom(req.getParameter("prenom"));
                p.setNumeroSecu(req.getParameter("numeroSecu"));
                p.setEtatSante(req.getParameter("etatSante"));
            }
            case "delete" -> ctrl.supprimerPatient(Integer.parseInt(req.getParameter("id")));
            case "admettre" -> ctrl.getPatient(Integer.parseInt(req.getParameter("id"))).admettre();
            case "sortie" -> ctrl.getPatient(Integer.parseInt(req.getParameter("id"))).sortir();
            case "addAntecedent" -> {
                Patient pa = ctrl.getPatient(Integer.parseInt(req.getParameter("id")));
                String antecedent = req.getParameter("antecedent");
                if (antecedent != null && !antecedent.isBlank()) {
                    pa.ajouterAntecedent(antecedent);
                }
                resp.sendRedirect(req.getContextPath() + "/patients?action=dossier&id=" + pa.getId());
                return;
            }
        }

        resp.sendRedirect(req.getContextPath() + "/patients");
    }
}
