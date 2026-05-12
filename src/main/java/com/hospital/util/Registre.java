package com.hospital.util;

import com.hospital.model.Personne;

import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class Registre<T extends Personne> {
    private final List<T> elements = new ArrayList<>();
    private final Map<Integer, T> index = new HashMap<>();

    public void ajouter(T element) {
        elements.add(element);
        index.put(element.getId(), element);
    }

    public void supprimer(T element) {
        elements.remove(element);
        index.remove(element.getId());
    }

    public T getParId(int id) {
        return index.get(id);
    }

    public List<T> getTous() {
        return Collections.unmodifiableList(elements);
    }

    public List<T> filtrer(Predicate<T> critere) {
        return elements.stream()
                .filter(critere)
                .collect(Collectors.toList());
    }

    public List<T> trier(Comparator<? super T> comparateur) {
        return elements.stream()
                .sorted(comparateur)
                .collect(Collectors.toList());
    }

    public <R> List<R> transformer(java.util.function.Function<T, R> fonction) {
        return elements.stream()
                .map(fonction)
                .collect(Collectors.toList());
    }

    public long compter(Predicate<T> critere) {
        return elements.stream().filter(critere).count();
    }

    public int taille() {
        return elements.size();
    }

    public boolean contient(T element) {
        return index.containsKey(element.getId());
    }
}
