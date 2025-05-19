package com.hsbt.sorting;
import com.hsbt.model.Tutor;
import java.util.Comparator;
public class RatingDescendingStrategy extends AbstractMergeSortStrategy {
    @Override
    protected Comparator<Tutor> getComparator() {
        return Comparator.comparingDouble(Tutor::getRating).reversed();
    }
    @Override
    public String getStrategyName() {
        return "rating_desc";
    }
    @Override
    public String getStrategyDescription() {
        return "Rating (High to Low)";
    }
}
