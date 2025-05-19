package com.hsbt.sorting;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
public class TutorSortingStrategyFactory {
    private static final Map<String, TutorSortingStrategy> strategies = new HashMap<>();
    static {
        registerStrategy(new RateAscendingStrategy());
        registerStrategy(new RateDescendingStrategy());
        registerStrategy(new RatingAscendingStrategy());
        registerStrategy(new RatingDescendingStrategy());
        registerStrategy(new ExperienceAscendingStrategy());
        registerStrategy(new ExperienceDescendingStrategy());
    }
    private static void registerStrategy(TutorSortingStrategy strategy) {
        strategies.put(strategy.getStrategyName(), strategy);
    }
    public static TutorSortingStrategy getStrategy(String strategyName) {
        return strategies.get(strategyName);
    }
    public static TutorSortingStrategy getDefaultStrategy() {
        return getStrategy("rating_desc");
    }
    public static List<TutorSortingStrategy> getAllStrategies() {
        return new ArrayList<>(strategies.values());
    }
}
