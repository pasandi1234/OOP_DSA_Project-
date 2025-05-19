package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.Comparator;
public class ExperienceDescendingStrategy extends AbstractMergeSortStrategy {
    @Override
    protected Comparator<Tutor> getComparator() {
        return Comparator.comparingInt(Tutor::getYearsOfExperience).reversed();
    }
    @Override
    public String getStrategyName() {
        return "experience_desc";
    }
    @Override
    public String getStrategyDescription() {
        return "Experience (High to Low)";
    }
}
