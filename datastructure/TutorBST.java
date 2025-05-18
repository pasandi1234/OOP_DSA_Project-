package com.hsbt.datastructure;
import com.hsbt.model.Tutor;
import java.util.ArrayList;
import java.util.List;
public class TutorBST {
    private TutorNode root;
    public TutorBST() {
        this.root = null;
    }
    public void insert(Tutor tutor) {
        root = insertRec(root, tutor);
    }
    private TutorNode insertRec(TutorNode root, Tutor tutor) {
        if (root == null) {
            root = new TutorNode(tutor);
            return root;
        }
        if (tutor.getId() < root.getTutor().getId()) {
            root.setLeft(insertRec(root.getLeft(), tutor));
        } else if (tutor.getId() > root.getTutor().getId()) {
            root.setRight(insertRec(root.getRight(), tutor));
        }
        else {
            root.setTutor(tutor);
        }
        return root;
    }
    public Tutor search(int id) {
        TutorNode result = searchRec(root, id);
        return (result != null) ? result.getTutor() : null;
    }
    private TutorNode searchRec(TutorNode root, int id) {
        if (root == null || root.getTutor().getId() == id) {
            return root;
        }
        if (id < root.getTutor().getId()) {
            return searchRec(root.getLeft(), id);
        }
        return searchRec(root.getRight(), id);
    }
    public void delete(int id) {
        root = deleteRec(root, id);
    }
    private TutorNode deleteRec(TutorNode root, int id) {
        if (root == null) {
            return null;
        }
        if (id < root.getTutor().getId()) {
            root.setLeft(deleteRec(root.getLeft(), id));
        } else if (id > root.getTutor().getId()) {
            root.setRight(deleteRec(root.getRight(), id));
        } else {
            if (root.getLeft() == null) {
                return root.getRight();
            } else if (root.getRight() == null) {
                return root.getLeft();
            }
            root.setTutor(minValue(root.getRight()));
            root.setRight(deleteRec(root.getRight(), root.getTutor().getId()));
        }
        return root;
    }
    private Tutor minValue(TutorNode root) {
        Tutor minv = root.getTutor();
        while (root.getLeft() != null) {
            minv = root.getLeft().getTutor();
            root = root.getLeft();
        }
        return minv;
    }
    public List<Tutor> searchBySubject(String subject) {
        List<Tutor> result = new ArrayList<>();
        searchBySubjectRec(root, subject, result);
        return result;
    }
    private void searchBySubjectRec(TutorNode root, String subject, List<Tutor> result) {
        if (root != null) {
            searchBySubjectRec(root.getLeft(), subject, result);
            if (root.getTutor().teachesSubject(subject)) {
                result.add(root.getTutor());
            }
            
            searchBySubjectRec(root.getRight(), subject, result);
        }
    }
    public List<Tutor> searchByName(String name) {
        List<Tutor> result = new ArrayList<>();
        searchByNameRec(root, name.toLowerCase(), result);
        return result;
    }
    private void searchByNameRec(TutorNode root, String name, List<Tutor> result) {
        if (root != null) {
            searchByNameRec(root.getLeft(), name, result);
            if (root.getTutor().getName().toLowerCase().contains(name)) {
                result.add(root.getTutor());
            }
            searchByNameRec(root.getRight(), name, result);
        }
    }
    public List<Tutor> getAllTutors() {
        List<Tutor> result = new ArrayList<>();
        inOrderTraversal(root, result);
        return result;
    }
    private void inOrderTraversal(TutorNode root, List<Tutor> result) {
        if (root != null) {
            inOrderTraversal(root.getLeft(), result);
            result.add(root.getTutor());
            inOrderTraversal(root.getRight(), result);
        }
    }
}
