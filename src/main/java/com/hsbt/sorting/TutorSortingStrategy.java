package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.List;
public interface TutorSortingStrategy {
    List<Tutor> sort(List<Tutor> tutors);
    String getStrategyName();
    String getStrategyDescription();
}
