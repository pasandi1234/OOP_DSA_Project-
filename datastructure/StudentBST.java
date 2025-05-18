package com.hsbt.datastructure;
import com.hsbt.model.Student;
import java.util.ArrayList;
import java.util.List;
public class StudentBST {
    private StudentNode root;
    public StudentBST() {
        this.root = null;
    }
    public void insert(Student student) {
        root = insertRec(root, student);
    }
    private StudentNode insertRec(StudentNode root, Student student) {
        if (root == null) {
            root = new StudentNode(student);
            return root;
        }
        if (student.getId() < root.getStudent().getId()) {
            root.setLeft(insertRec(root.getLeft(), student));
        } else if (student.getId() > root.getStudent().getId()) {
            root.setRight(insertRec(root.getRight(), student));
        }
        else {
            root.setStudent(student);
        }

        return root;
    }
    public Student search(int id) {
        StudentNode result = searchRec(root, id);
        return (result != null) ? result.getStudent() : null;
    }
    private StudentNode searchRec(StudentNode root, int id) {
        if (root == null || root.getStudent().getId() == id) {
            return root;
        }
        if (id < root.getStudent().getId()) {
            return searchRec(root.getLeft(), id);
        }
        return searchRec(root.getRight(), id);
    }
    public void delete(int id) {
        root = deleteRec(root, id);
    }
    private StudentNode deleteRec(StudentNode root, int id) {
        if (root == null) {
            return null;
        }
        if (id < root.getStudent().getId()) {
            root.setLeft(deleteRec(root.getLeft(), id));
        } else if (id > root.getStudent().getId()) {
            root.setRight(deleteRec(root.getRight(), id));
        } else {
            if (root.getLeft() == null) {
                return root.getRight();
            } else if (root.getRight() == null) {
                return root.getLeft();
            }
            root.setStudent(minValue(root.getRight()));
            root.setRight(deleteRec(root.getRight(), root.getStudent().getId()));
        }
        return root;
    }
    private Student minValue(StudentNode root) {
        Student minv = root.getStudent();
        while (root.getLeft() != null) {
            minv = root.getLeft().getStudent();
            root = root.getLeft();
        }
        return minv;
    }
    public List<Student> searchBySubject(String subject) {
        List<Student> result = new ArrayList<>();
        searchBySubjectRec(root, subject, result);
        return result;
    }
    private void searchBySubjectRec(StudentNode root, String subject, List<Student> result) {
        if (root != null) {
            searchBySubjectRec(root.getLeft(), subject, result);
            if (root.getStudent().isInterestedInSubject(subject)) {
                result.add(root.getStudent());
            }
            searchBySubjectRec(root.getRight(), subject, result);
        }
    }
    public List<Student> searchByName(String name) {
        List<Student> result = new ArrayList<>();
        searchByNameRec(root, name.toLowerCase(), result);
        return result;
    }
    private void searchByNameRec(StudentNode root, String name, List<Student> result) {
        if (root != null) {
            searchByNameRec(root.getLeft(), name, result);
            if (root.getStudent().getName().toLowerCase().contains(name)) {
                result.add(root.getStudent());
            }

            searchByNameRec(root.getRight(), name, result);
        }
    }
    public List<Student> getAllStudents() {
        List<Student> result = new ArrayList<>();
        inOrderTraversal(root, result);
        return result;
    }
    private void inOrderTraversal(StudentNode root, List<Student> result) {
        if (root != null) {
            inOrderTraversal(root.getLeft(), result);
            result.add(root.getStudent());
            inOrderTraversal(root.getRight(), result);
        }
    }
    public List<Student> getActiveStudents() {
        List<Student> result = new ArrayList<>();
        getActiveStudentsRec(root, result);
        return result;
    }
    private void getActiveStudentsRec(StudentNode root, List<Student> result) {
        if (root != null) {
            getActiveStudentsRec(root.getLeft(), result);
            if (root.getStudent().isActive()) {
                result.add(root.getStudent());
            }

            getActiveStudentsRec(root.getRight(), result);
        }
    }
}

