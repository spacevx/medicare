package com.hospital.util;

import com.hospital.model.Urgence;

import java.util.*;
import java.util.stream.Collectors;

public class FileUrgence<T extends Urgence> {
    private final PriorityQueue<T> file;

    public FileUrgence() {
        this.file = new PriorityQueue<>(
                Comparator.comparingInt(Urgence::getNiveauUrgence).reversed()
        );
    }

    public void ajouter(T element) {
        file.add(element);
    }

    public T suivant() {
        return file.poll();
    }

    public T consulter() {
        return file.peek();
    }

    public List<T> getCritiques() {
        return file.stream()
                .filter(Urgence::estCritique)
                .sorted(Comparator.comparingInt(Urgence::getNiveauUrgence).reversed())
                .collect(Collectors.toList());
    }

    public int taille() {
        return file.size();
    }

    public boolean estVide() {
        return file.isEmpty();
    }
}
