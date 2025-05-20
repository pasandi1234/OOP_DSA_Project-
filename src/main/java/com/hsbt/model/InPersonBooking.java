package com.hsbt.model;


public class InPersonBooking extends Booking {
    private String location;
    private String address;
    private boolean materialsProvided;
    private boolean travelFeeApplied;
    private double travelFee;


    public InPersonBooking() {
        super();
        setBookingType("INPERSON");
    }


    public InPersonBooking(int id, int studentId, int tutorId, String subject, String date,
                          String startTime, String endTime, double price, String status, String notes,
                          String location, String address, boolean materialsProvided,
                          boolean travelFeeApplied, double travelFee) {
        super(id, studentId, tutorId, subject, date, startTime, endTime, price, status, notes);
        this.location = location;
        this.address = address;
        this.materialsProvided = materialsProvided;
        this.travelFeeApplied = travelFeeApplied;
        this.travelFee = travelFee;
        setBookingType("INPERSON");
    }


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isMaterialsProvided() {
        return materialsProvided;
    }

    public void setMaterialsProvided(boolean materialsProvided) {
        this.materialsProvided = materialsProvided;
    }

    public boolean isTravelFeeApplied() {
        return travelFeeApplied;
    }

    public void setTravelFeeApplied(boolean travelFeeApplied) {
        this.travelFeeApplied = travelFeeApplied;
    }

    public double getTravelFee() {
        return travelFee;
    }

    public void setTravelFee(double travelFee) {
        this.travelFee = travelFee;
    }
    

    public double getTotalPrice() {
        return getPrice() + (travelFeeApplied ? travelFee : 0);
    }


    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.append("|").append(location).append("|");
        sb.append(address).append("|");
        sb.append(materialsProvided ? "1" : "0").append("|");
        sb.append(travelFeeApplied ? "1" : "0").append("|");
        sb.append(travelFee);
        
        return sb.toString();
    }
    

    public static InPersonBooking fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 16) {
            throw new IllegalArgumentException("Invalid file string format for InPersonBooking");
        }
        
        int id = Integer.parseInt(parts[0]);
        int studentId = Integer.parseInt(parts[1]);
        int tutorId = Integer.parseInt(parts[2]);
        String subject = parts[3];
        String date = parts[4];
        String startTime = parts[5];
        String endTime = parts[6];
        double price = Double.parseDouble(parts[7]);
        String status = parts[8];
        String notes = parts[9];
        
        String location = parts[11];
        String address = parts[12];
        boolean materialsProvided = "1".equals(parts[13]);
        boolean travelFeeApplied = "1".equals(parts[14]);
        double travelFee = Double.parseDouble(parts[15]);
        
        return new InPersonBooking(id, studentId, tutorId, subject, date, startTime, endTime, price, status, notes,
                                 location, address, materialsProvided, travelFeeApplied, travelFee);
    }
    

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Location: ").append(location).append("\n");
        sb.append("Address: ").append(address).append("\n");
        sb.append("Materials Provided: ").append(materialsProvided ? "Yes" : "No").append("\n");
        sb.append("Travel Fee Applied: ").append(travelFeeApplied ? "Yes" : "No").append("\n");
        if (travelFeeApplied) {
            sb.append("Travel Fee: Rs.").append(String.format("%.2f", travelFee)).append("\n");
            sb.append("Total Price: Rs.").append(String.format("%.2f", getTotalPrice())).append("\n");
        }
        
        return sb.toString();
    }
}
