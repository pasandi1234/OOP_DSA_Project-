package com.hsbt.service;

import com.hsbt.datastructure.StudentBST;
import com.hsbt.model.Student;
import com.hsbt.config.DatabaseConfig;
import com.hsbt.util.FileIOUtil;

import java.util.ArrayList;
import java.util.List;

public class StudentManagementService {
    private StudentBST studentBST;
    private static StudentManagementService instance;
    private int nextId;
    private String studentsFilePath;

    private StudentManagementService() {
        studentBST = new StudentBST();
        nextId = 1;

        DatabaseConfig.ensureDirectoriesExist();

        studentsFilePath = DatabaseConfig.getStudentsFilePath();
        loadStudents();
    }

    public static synchronized StudentManagementService getInstance() {
        if (instance == null) {
            instance = new StudentManagementService();
        }
        return instance;
    }

    public Student registerStudent(Student student) {
        if (student.getId() <= 0) {
            student.setId(nextId++);
        }
        studentBST.insert(student);
        saveStudents();

        return student;
    }

    public Student getStudentById(int id) {
        return studentBST.search(id);
    }

    public boolean updateStudent(Student student) {
        if (studentBST.search(student.getId()) == null) {
            return false;
        }
        studentBST.insert(student);
        saveStudents();

        return true;
    }

    public boolean deleteStudent(int id) {
        if (studentBST.search(id) == null) {
            return false;
        }

        studentBST.delete(id);
        saveStudents();

        return true;
    }

    public boolean deactivateStudent(int id) {
        Student student = studentBST.search(id);

        if (student == null) {
            return false;
        }

        student.setActive(false);
        studentBST.insert(student);
        saveStudents();

        return true;
    }

    public List<Student> searchStudentsBySubject(String subject) {
        return studentBST.searchBySubject(subject);
    }

    public List<Student> searchStudentsByName(String name) {
        return studentBST.searchByName(name);
    }

    public List<Student> getAllStudents() {
        return studentBST.getAllStudents();
    }

    public List<Student> getActiveStudents() {
        return studentBST.getActiveStudents();
    }

    private void loadStudents() {
        try {
            if (!FileIOUtil.fileExists(studentsFilePath)) {
                createSampleStudents();
                return;
            }
            List<String> lines = FileIOUtil.readLinesFromFile(studentsFilePath);
            studentBST = new StudentBST();
            for (String line : lines) {
                Student student = parseStudentFromLine(line);
                if (student != null) {
                    studentBST.insert(student);
                    if (student.getId() >= nextId) {
                        nextId = student.getId() + 1;
                    }
                }
            }
            if (studentBST.getAllStudents().isEmpty()) {
                createSampleStudents();
            }
        } catch (Exception e) {
            System.err.println("Error loading students: " + e.getMessage());
            createSampleStudents();
        }
    }

    private Student parseStudentFromLine(String line) {
        try {
            return Student.fromFileString(line);
        } catch (Exception e) {
            System.err.println("Error parsing student: " + e.getMessage());
            return null;
        }
    }

    private void saveStudents() {
        try {
            List<String> lines = new ArrayList<>();
            for (Student student : studentBST.getAllStudents()) {
                String line = student.toFileString();
                if (line != null) {
                    lines.add(line);
                }
            }
            FileIOUtil.writeLinesToFile(studentsFilePath, lines);
        } catch (Exception e) {
            System.err.println("Error saving students: " + e.getMessage());
        }
    }

    private void createSampleStudents() {
        String[] preferredSubjects1 = {"Accounting", "Econ", "ICT"};
        String[] mondayWednesday = {"Monday", "Wednesday"};
        Student student1 = new Student(
                nextId++, "Dinuli Ferdinando", "dinuli@email.com", "0712580320",
                "320/A, Madiwela Road, Kotte", preferredSubjects1, "Commerce Stream",
                mondayWednesday, "Afternoon", true
        );

        String[] preferredSubjects2 = {"Physics", "Chemistry", "Combined Maths"};
        String[] tuesdayThursday = {"Tuesday", "Thursday"};
        Student student2 = new Student(
                nextId++, "Upadya Diheli", "diheliupadya@gmail.com", "0752740250",
                "123/B, Pagoda Road, Kelaniya", preferredSubjects2, "Physical Science Stream",
                tuesdayThursday, "Evening", true
        );

        String[] preferredSubjects3 = {"Accounting", "Econ", "ICT"};
        String[] weekendDays = {"Saturday", "Sunday"};
        Student student3 = new Student(
                nextId++, "Dinethmi Perera", "dperera@gmail.com", "0717508302",
                "278/A, Vihara Road, Kottawa", preferredSubjects3, "Commerce Stream",
                weekendDays, "Morning", true
        );

        String[] preferredSubjects4 = {"Geography", "History", "ICT"};
        String[] allDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
        Student student4 = new Student(
                nextId++, "Kamal Fernando", "kamal@gmail.com", "0785420750",
                "258/C,Isurupura,Malabe", preferredSubjects4, "Arts Stream",
                allDays, "Flexible", true
        );

        studentBST.insert(student1);
        studentBST.insert(student2);
        studentBST.insert(student3);
        studentBST.insert(student4);
        saveStudents();
    }
}
