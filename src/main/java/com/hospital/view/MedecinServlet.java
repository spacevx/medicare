package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.model.Medecin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/medecins")
public class MedecinServlet extends HttpServlet {

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
                req.setAttribute("medecin", ctrl.getMedecin(Integer.parseInt(id)));
            }
            req.setAttribute("activePage", "medecins");
            req.getRequestDispatcher("/WEB-INF/jsp/medecin-form.jsp").forward(req, resp);
        } else {
            String nom = req.getParameter("nom");
            String specialite = req.getParameter("specialite");
            String service = req.getParameter("service");

            req.setAttribute("medecins", ctrl.filtrerMedecins(
                    nom != null && !nom.isBlank() ? nom : null,
                    specialite != null && !specialite.isBlank() ? specialite : null,
                    service != null && !service.isBlank() ? service : null
            ));
            req.setAttribute("activePage", "medecins");
            req.getRequestDispatcher("/WEB-INF/jsp/medecins.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HopitalController ctrl = getController();
        String action = req.getParameter("action");

        switch (action) {
            case "add" -> ctrl.ajouterMedecin(
                    req.getParameter("nom"),
                    req.getParameter("prenom"),
                    LocalDate.parse(req.getParameter("dateNaissance")),
                    req.getParameter("matricule"),
                    req.getParameter("service"),
                    req.getParameter("specialite")
            );
            case "update" -> {
                Medecin m = ctrl.getMedecin(Integer.parseInt(req.getParameter("id")));
                m.setNom(req.getParameter("nom"));
                m.setPrenom(req.getParameter("prenom"));
                m.setMatricule(req.getParameter("matricule"));
                m.setService(req.getParameter("service"));
                m.setSpecialite(req.getParameter("specialite"));
            }
            case "delete" -> ctrl.supprimerMedecin(Integer.parseInt(req.getParameter("id")));
        }

        resp.sendRedirect(req.getContextPath() + "/medecins");
    }
}
