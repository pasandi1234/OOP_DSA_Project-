package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.Comparator;
public class RateAscendingStrategy extends AbstractMergeSortStrategy {
    @Override
    protected Comparator<Tutor> getComparator() {
        return Comparator.comparingDouble(Tutor::getHourlyRate);
    }
    @Override
    public String getStrategyName() {
        return "rate_asc";
    }
    @Override
    public String getStrategyDescription() {
        return "Hourly Rate (Low to High)";
    }
}
