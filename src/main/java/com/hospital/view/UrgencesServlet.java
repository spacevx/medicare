package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.model.Patient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Comparator;

@WebServlet("/urgences")
public class UrgencesServlet extends HttpServlet {

    private HopitalController getController() {
        return (HopitalController) getServletContext().getAttribute("controller");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HopitalController ctrl = getController();

        req.setAttribute("fileUrgences", ctrl.getFileUrgences());
        req.setAttribute("actesCritiques", ctrl.getFileUrgences().getCritiques());

        var patientsUrgents = ctrl.filtrerPatients(null, "Critique", true);
        patientsUrgents.sort(Comparator.comparing(Patient::getNomComplet));
        req.setAttribute("patientsUrgents", patientsUrgents);
        req.setAttribute("activePage", "urgences");

        req.getRequestDispatcher("/WEB-INF/jsp/urgences.jsp").forward(req, resp);
    }
}
