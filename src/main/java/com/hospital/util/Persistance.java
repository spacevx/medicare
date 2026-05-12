package com.hospital.util;

import java.io.*;

public class Persistance {
    public static void sauvegarder(Object objet, String fichier) throws IOException {
        try (var oos = new ObjectOutputStream(new FileOutputStream(fichier))) {
            oos.writeObject(objet);
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> T charger(String fichier) throws IOException, ClassNotFoundException {
        try (var ois = new ObjectInputStream(new FileInputStream(fichier))) {
            return (T) ois.readObject();
        }
    }
}
