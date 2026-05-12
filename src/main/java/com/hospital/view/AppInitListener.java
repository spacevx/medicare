package com.hospital.view;

import com.hospital.controller.HopitalController;
import com.hospital.util.CsvLoader;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.IOException;

@WebListener
public class AppInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        HopitalController controller = HopitalController.charger();

        if (controller.getTousPatients().isEmpty()) {
            CsvLoader.charger(controller, "/WEB-INF/data/", sce.getServletContext()::getResourceAsStream);
        }

        sce.getServletContext().setAttribute("controller", controller);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        HopitalController controller = (HopitalController) sce.getServletContext().getAttribute("controller");
        try {
            controller.sauvegarder();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
