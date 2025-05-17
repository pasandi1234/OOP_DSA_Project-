package com.hsbt.model;


public class CardPayment extends Payment {
    private String cardType; // e.g., "Visa", "Mastercard", "American Express"
    private String lastFourDigits;
    private String cardholderName;
    private String expiryDate;


    public CardPayment() {
        super();
        setPaymentType("CARD");
    }


    public CardPayment(int id, int bookingId, int studentId, int tutorId, 
                      double amount, String date, String status, String transactionId,
                      String cardType, String lastFourDigits, String cardholderName, String expiryDate) {
        super(id, bookingId, studentId, tutorId, amount, date, status, transactionId);
        this.cardType = cardType;
        this.lastFourDigits = lastFourDigits;
        this.cardholderName = cardholderName;
        this.expiryDate = expiryDate;
        setPaymentType("CARD");
    }


    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }
    public String getLastFourDigits() {
        return lastFourDigits;
    }
    public void setLastFourDigits(String lastFourDigits) {
        this.lastFourDigits = lastFourDigits;
    }
    public String getCardholderName() {
        return cardholderName;
    }
    public void setCardholderName(String cardholderName) {
        this.cardholderName = cardholderName;
    }
    public String getExpiryDate() {
        return expiryDate;
    }
    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }
    

    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.append("|").append(cardType).append("|");
        sb.append(lastFourDigits).append("|");
        sb.append(cardholderName).append("|");
        sb.append(expiryDate);
        
        return sb.toString();
    }
    

    public static CardPayment fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 13) {
            throw new IllegalArgumentException("Invalid file string format for CardPayment");
        }
        
        int id = Integer.parseInt(parts[0]);
        int bookingId = Integer.parseInt(parts[1]);
        int studentId = Integer.parseInt(parts[2]);
        int tutorId = Integer.parseInt(parts[3]);
        double amount = Double.parseDouble(parts[4]);
        String date = parts[5];
        String status = parts[6];
        String transactionId = parts[7];
        
        String cardType = parts[9];
        String lastFourDigits = parts[10];
        String cardholderName = parts[11];
        String expiryDate = parts[12];
        
        return new CardPayment(id, bookingId, studentId, tutorId, amount, date, status, transactionId,
                             cardType, lastFourDigits, cardholderName, expiryDate);
    }


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Card Type: ").append(cardType).append("\n");
        sb.append("Card Number: **** **** **** ").append(lastFourDigits).append("\n");
        sb.append("Cardholder: ").append(cardholderName).append("\n");
        sb.append("Expiry Date: ").append(expiryDate).append("\n");
        
        return sb.toString();
    }
}
