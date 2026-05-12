package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.model.Infirmier;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/infirmiers")
public class InfirmierServlet extends HttpServlet {

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
                req.setAttribute("infirmier", ctrl.getTousInfirmiers().stream()
                        .filter(i -> i.getId() == Integer.parseInt(id))
                        .findFirst().orElse(null));
            }
            req.setAttribute("activePage", "infirmiers");
            req.getRequestDispatcher("/WEB-INF/jsp/infirmier-form.jsp").forward(req, resp);
        } else {
            String nom = req.getParameter("nom");
            String service = req.getParameter("service");

            var infirmiers = ctrl.getTousInfirmiers().stream()
                    .filter(i -> nom == null || nom.isBlank() || i.getNomComplet().toLowerCase().contains(nom.toLowerCase()))
                    .filter(i -> service == null || service.isBlank() || i.getService().equalsIgnoreCase(service))
                    .toList();

            req.setAttribute("infirmiers", infirmiers);
            req.setAttribute("activePage", "infirmiers");
            req.getRequestDispatcher("/WEB-INF/jsp/infirmiers.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HopitalController ctrl = getController();
        String action = req.getParameter("action");

        switch (action) {
            case "add" -> ctrl.ajouterInfirmier(
                    req.getParameter("nom"),
                    req.getParameter("prenom"),
                    LocalDate.parse(req.getParameter("dateNaissance")),
                    req.getParameter("matricule"),
                    req.getParameter("service")
            );
            case "update" -> {
                Infirmier inf = ctrl.getTousInfirmiers().stream()
                        .filter(i -> i.getId() == Integer.parseInt(req.getParameter("id")))
                        .findFirst().orElseThrow();
                inf.setNom(req.getParameter("nom"));
                inf.setPrenom(req.getParameter("prenom"));
                inf.setMatricule(req.getParameter("matricule"));
                inf.setService(req.getParameter("service"));
            }
            case "delete" -> ctrl.supprimerInfirmier(Integer.parseInt(req.getParameter("id")));
        }

        resp.sendRedirect(req.getContextPath() + "/infirmiers");
    }
}
