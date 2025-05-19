package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.Comparator;
public class RatingAscendingStrategy extends AbstractMergeSortStrategy {
    @Override
    protected Comparator<Tutor> getComparator() {
        return Comparator.comparingDouble(Tutor::getRating);
    }
    @Override
    public String getStrategyName() {
        return "rating_asc";
    }
    @Override
    public String getStrategyDescription() {
        return "Rating (Low to High)";
    }
}
