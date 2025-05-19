package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.Comparator;
public class RateDescendingStrategy extends AbstractMergeSortStrategy {
    @Override
    protected Comparator<Tutor> getComparator() {
        return Comparator.comparingDouble(Tutor::getHourlyRate).reversed();
    }
    @Override
    public String getStrategyName() {
        return "rate_desc";
    }
    @Override
    public String getStrategyDescription() {
        return "Hourly Rate (High to Low)";
    }
}
