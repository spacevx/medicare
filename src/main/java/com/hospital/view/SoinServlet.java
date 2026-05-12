package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.model.Medecin;
import com.hospital.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/soins")
public class SoinServlet extends HttpServlet {

    private HopitalController getController() {
        return (HopitalController) getServletContext().getAttribute("controller");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HopitalController ctrl = getController();
        String action = req.getParameter("action");

        if ("form".equals(action)) {
            req.setAttribute("patients", ctrl.getTousPatients());
            req.setAttribute("medecins", ctrl.getTousMedecins());
            req.setAttribute("type", req.getParameter("type"));
            req.setAttribute("activePage", "soins");
            req.getRequestDispatcher("/WEB-INF/jsp/soin-form.jsp").forward(req, resp);
        } else {
            req.setAttribute("soins", ctrl.getTousSoins());
            req.setAttribute("activePage", "soins");
            req.getRequestDispatcher("/WEB-INF/jsp/soins.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HopitalController ctrl = getController();
        String type = req.getParameter("type");

        Patient patient = ctrl.getPatient(Integer.parseInt(req.getParameter("patientId")));
        Medecin medecin = ctrl.getMedecin(Integer.parseInt(req.getParameter("medecinId")));
        String description = req.getParameter("description");
        double cout = Double.parseDouble(req.getParameter("cout"));

        if ("consultation".equals(type)) {
            ctrl.ajouterConsultation(patient, medecin, description, cout, req.getParameter("diagnostic"));
        } else {
            int niveauUrgence = Integer.parseInt(req.getParameter("niveauUrgence"));
            ctrl.ajouterActeChirurgical(patient, medecin, description, cout, niveauUrgence, req.getParameter("salle"));
        }

        resp.sendRedirect(req.getContextPath() + "/soins");
    }
}
