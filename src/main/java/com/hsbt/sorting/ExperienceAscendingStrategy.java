package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.Comparator;
public class ExperienceAscendingStrategy extends AbstractMergeSortStrategy {
    @Override
    protected Comparator<Tutor> getComparator() {
        return Comparator.comparingInt(Tutor::getYearsOfExperience);
    }
    @Override
    public String getStrategyName() {
        return "experience_asc";
    }
    @Override
    public String getStrategyDescription() {
        return "Experience (Low to High)";
    }
}
