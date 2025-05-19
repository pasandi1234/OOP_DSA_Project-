package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
public abstract class AbstractMergeSortStrategy implements TutorSortingStrategy {
    @Override
    public List<Tutor> sort(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return new ArrayList<>();
        }
        List<Tutor> result = new ArrayList<>(tutors);
        mergeSort(result, getComparator());
        return result;
    }
    protected abstract Comparator<Tutor> getComparator();
    private <T> void mergeSort(List<T> list, Comparator<T> comparator) {
        if (list.size() <= 1) {
            return;
        }
        int mid = list.size() / 2;
        List<T> left = new ArrayList<>(list.subList(0, mid));
        List<T> right = new ArrayList<>(list.subList(mid, list.size()));
        mergeSort(left, comparator);
        mergeSort(right, comparator);
        merge(list, left, right, comparator);
    }
    private <T> void merge(List<T> result, List<T> left, List<T> right, Comparator<T> comparator) {
        int i = 0, j = 0, k = 0;
        
        while (i < left.size() && j < right.size()) {
            if (comparator.compare(left.get(i), right.get(j)) <= 0) {
                result.set(k++, left.get(i++));
            } else {
                result.set(k++, right.get(j++));
            }
        }
        while (i < left.size()) {
            result.set(k++, left.get(i++));
        }
        while (j < right.size()) {
            result.set(k++, right.get(j++));
        }
    }
}
