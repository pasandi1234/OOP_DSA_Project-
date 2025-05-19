package com.hsbt.service;

import com.hsbt.datastructure.TutorBST;
import com.hsbt.model.Tutor;
import com.hsbt.model.OnlineTutor;
import com.hsbt.model.InPersonTutor;
import com.hsbt.config.DatabaseConfig;
import com.hsbt.util.FileIOUtil;

import java.util.ArrayList;
import java.util.List;

public class TutorManagementService {
    private TutorBST tutorBST;
    private static TutorManagementService instance;
    private int nextId;
    private String tutorsFilePath;

    private TutorManagementService() {
        tutorBST = new TutorBST();
        nextId = 1;

        DatabaseConfig.ensureDirectoriesExist();

        tutorsFilePath = DatabaseConfig.getTutorsFilePath();

        loadTutors();
    }

    public static synchronized TutorManagementService getInstance() {
        if (instance == null) {
            instance = new TutorManagementService();
        }
        return instance;
    }

    public Tutor registerTutor(Tutor tutor) {

        if (tutor.getId() <= 0) {
            tutor.setId(nextId++);
        }

        tutorBST.insert(tutor);

        saveTutors();

        return tutor;
    }

    public Tutor getTutorById(int id) {
        return tutorBST.search(id);
    }

    public boolean updateTutor(Tutor tutor) {

        if (tutorBST.search(tutor.getId()) == null) {
            return false;
        }

        tutorBST.insert(tutor);

        saveTutors();

        return true;
    }

    public boolean deleteTutor(int id) {

        if (tutorBST.search(id) == null) {
            return false;
        }

        tutorBST.delete(id);

        saveTutors();

        return true;
    }

    public List<Tutor> searchTutorsBySubject(String subject) {
        return tutorBST.searchBySubject(subject);
    }

    public List<Tutor> searchTutorsByName(String name) {
        return tutorBST.searchByName(name);
    }

    public List<Tutor> getAllTutors() {
        return tutorBST.getAllTutors();
    }

    private void loadTutors() {
        try {
            if (!FileIOUtil.fileExists(tutorsFilePath)) {

                createSampleTutors();
                return;
            }

            List<String> lines = FileIOUtil.readLinesFromFile(tutorsFilePath);

            tutorBST = new TutorBST();

            for (String line : lines) {
                Tutor tutor = parseTutorFromLine(line);
                if (tutor != null) {
                    tutorBST.insert(tutor);

                    if (tutor.getId() >= nextId) {
                        nextId = tutor.getId() + 1;
                    }
                }
            }

            if (tutorBST.getAllTutors().isEmpty()) {
                createSampleTutors();
            }
        } catch (Exception e) {
            System.err.println("Error loading tutors: " + e.getMessage());
            createSampleTutors();
        }
    }

    private Tutor parseTutorFromLine(String line) {
        try {
            String[] parts = line.split("\\|");
            if (parts.length < 10) {
                return null;
            }

            String type = parts[9];

            if ("ONLINE".equals(type)) {
                return OnlineTutor.fromFileString(line);
            } else if ("INPERSON".equals(type)) {
                return InPersonTutor.fromFileString(line);
            } else {
                return Tutor.fromFileString(line);
            }
        } catch (Exception e) {
            System.err.println("Error parsing tutor: " + e.getMessage());
            return null;
        }
    }

    private void saveTutors() {
        try {

            List<String> lines = new ArrayList<>();

            for (Tutor tutor : tutorBST.getAllTutors()) {
                String line = tutor.toFileString();
                if (line != null) {
                    lines.add(line);
                }
            }

            FileIOUtil.writeLinesToFile(tutorsFilePath, lines);

        } catch (Exception e) {
            System.err.println("Error saving tutors: " + e.getMessage());
        }
    }

    private void createSampleTutors() {

        String[] mathSubjects = {"Biology", "Physics", "Chemistry"};
        OnlineTutor onlineTutor1 = new OnlineTutor(
            nextId++, "Okitha Weerasekara", "OkithaWeerasekara@email.com", "0768690430",
            mathSubjects, 5, 25.0, 4.5, true,
            "Matugama", true, true, "GMT-5"
        );

        String[] historySubjects = {"History", "Geography", "ICT"};
        InPersonTutor inPersonTutor2 = new InPersonTutor(
            nextId++, "Miuni Malkini", "MiuniMalkini@email.com", "0741216911",
            historySubjects, 4, 22.0, 4.0, true,
            "Wadduwa", 10, false, true
        );

        tutorBST.insert(onlineTutor1);
        tutorBST.insert(inPersonTutor2);

        saveTutors();
    }
}
