package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.model.Medecin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/statistiques")
public class StatistiquesServlet extends HttpServlet {

    private HopitalController getController() {
        return (HopitalController) getServletContext().getAttribute("controller");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HopitalController ctrl = getController();

        req.setAttribute("totalPatients", ctrl.getTousPatients().size());
        req.setAttribute("patientsAdmis", ctrl.filtrerPatients(null, null, true).size());
        req.setAttribute("totalMedecins", ctrl.getTousMedecins().size());
        req.setAttribute("totalSoins", ctrl.getTousSoins().size());
        req.setAttribute("coutMoyen", ctrl.coutMoyenSoins());
        req.setAttribute("tauxOccupation", ctrl.tauxOccupationMoyen());
        req.setAttribute("patientsParEtat", ctrl.patientsParEtat());

        Map<String, Long> soinsParMedecin = ctrl.soinsParMedecin().entrySet().stream()
                .collect(Collectors.toMap(e -> e.getKey().getNomComplet(), Map.Entry::getValue));
        req.setAttribute("soinsParMedecin", soinsParMedecin);
        req.setAttribute("salles", ctrl.getToutesSalles());
        req.setAttribute("activePage", "statistiques");

        req.getRequestDispatcher("/WEB-INF/jsp/statistiques.jsp").forward(req, resp);
    }
}
