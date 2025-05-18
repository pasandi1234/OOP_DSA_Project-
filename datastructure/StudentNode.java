package com.hsbt.datastructure;
import com.hsbt.model.Student;
public class StudentNode {
    private Student student;
    private StudentNode left;
    private StudentNode right;
    public StudentNode(Student student) {
        this.student = student;
        this.left = null;
        this.right = null;
    }
    public Student getStudent() {
        return student;
    }
    public void setStudent(Student student) {
        this.student = student;
    }
    public StudentNode getLeft() {
        return left;
    }
    public void setLeft(StudentNode left) {
        this.left = left;
    }
    public StudentNode getRight() {
        return right;
    }
    public void setRight(StudentNode right) {
        this.right = right;
    }
}
