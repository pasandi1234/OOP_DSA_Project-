package com.hsbt.datastructure;
import com.hsbt.model.Tutor;
public class TutorNode {
    private Tutor tutor;
    private TutorNode left;
    private TutorNode right;
    public TutorNode(Tutor tutor) {
        this.tutor = tutor;
        this.left = null;
        this.right = null;
    }
    public Tutor getTutor() {
        return tutor;
    }
    public void setTutor(Tutor tutor) {
        this.tutor = tutor;
    }
    public TutorNode getLeft() {
        return left;
    }
    public void setLeft(TutorNode left) {
        this.left = left;
    }
    public TutorNode getRight() {
        return right;
    }
    public void setRight(TutorNode right) {
        this.right = right;
    }
}
