package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.model.CapaciteDepasseeException;
import com.hospital.model.Salle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/salles")
public class SalleServlet extends HttpServlet {

    private HopitalController getController() {
        return (HopitalController) getServletContext().getAttribute("controller");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HopitalController ctrl = getController();
        String action = req.getParameter("action");

        if ("form".equals(action)) {
            req.setAttribute("activePage", "salles");
            req.getRequestDispatcher("/WEB-INF/jsp/salle-form.jsp").forward(req, resp);
        } else {
            req.setAttribute("salles", ctrl.getToutesSalles());
            req.setAttribute("patientsAdmis", ctrl.filtrerPatients(null, null, true));
            req.setAttribute("activePage", "salles");
            req.getRequestDispatcher("/WEB-INF/jsp/salles.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HopitalController ctrl = getController();
        String action = req.getParameter("action");

        switch (action) {
            case "add" -> ctrl.ajouterSalle(
                    req.getParameter("numero"),
                    req.getParameter("type"),
                    Integer.parseInt(req.getParameter("capacite"))
            );
            case "delete" -> ctrl.supprimerSalle(Integer.parseInt(req.getParameter("id")));
            case "affecter" -> {
                Salle salle = ctrl.getToutesSalles().stream()
                        .filter(s -> s.getId() == Integer.parseInt(req.getParameter("salleId")))
                        .findFirst().orElseThrow();
                try {
                    salle.ajouterPatient(ctrl.getPatient(Integer.parseInt(req.getParameter("patientId"))));
                } catch (CapaciteDepasseeException e) {
                    req.getSession().setAttribute("error", e.getMessage());
                }
            }
            case "liberer" -> {
                Salle salle = ctrl.getToutesSalles().stream()
                        .filter(s -> s.getId() == Integer.parseInt(req.getParameter("salleId")))
                        .findFirst().orElseThrow();
                salle.retirerPatient(ctrl.getPatient(Integer.parseInt(req.getParameter("patientId"))));
            }
        }

        resp.sendRedirect(req.getContextPath() + "/salles");
    }
}
