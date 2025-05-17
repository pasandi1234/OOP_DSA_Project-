package com.hsbt.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileIOUtil {
    
 
    public static boolean writeLinesToFile(String filePath, List<String> lines) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error writing to file " + filePath + ": " + e.getMessage());
            return false;
        }
    }
    public static List<String> readLinesFromFile(String filePath) {
        List<String> lines = new ArrayList<>();
        
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
        } catch (IOException e) {
            System.err.println("Error reading from file " + filePath + ": " + e.getMessage());
        }
        
        return lines;
    }
    public static boolean appendLineToFile(String filePath, String line) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(line);
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("Error appending to file " + filePath + ": " + e.getMessage());
            return false;
        }
    }
    public static boolean fileExists(String filePath) {
        File file = new File(filePath);
        return file.exists() && file.isFile();
    }
    public static boolean createFileIfNotExists(String filePath) {
        if (fileExists(filePath)) {
            return true;
        }
        
        try {
            File file = new File(filePath);
            File parent = file.getParentFile();
            
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }
            
            return file.createNewFile();
        } catch (IOException e) {
            System.err.println("Error creating file " + filePath + ": " + e.getMessage());
            return false;
        }
    }
}
