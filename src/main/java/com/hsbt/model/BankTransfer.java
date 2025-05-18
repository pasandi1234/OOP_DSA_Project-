package com.hsbt.model;


 public class BankTransfer extends Payment {
    private String bankName;
    private String accountName;
    private String referenceNumber;
    private boolean isInternational;
    private String transferMethod; 

   public BankTransfer() {
        super();
        setPaymentType("BANK");
    }


    public BankTransfer(int id, int bookingId, int studentId, int tutorId, 
                       double amount, String date, String status, String transactionId,
                       String bankName, String accountName, String referenceNumber,
                       boolean isInternational, String transferMethod) {
        super(id, bookingId, studentId, tutorId, amount, date, status, transactionId);
        this.bankName = bankName;
        this.accountName = accountName;
        this.referenceNumber = referenceNumber;
        this.isInternational = isInternational;
        this.transferMethod = transferMethod;
        setPaymentType("BANK");
    }


    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getReferenceNumber() {
        return referenceNumber;
    }

    public void setReferenceNumber(String referenceNumber) {
        this.referenceNumber = referenceNumber;
    }

    public boolean isInternational() {
        return isInternational;
    }

    public void setInternational(boolean isInternational) {
        this.isInternational = isInternational;
    }

    public String getTransferMethod() {
        return transferMethod;
    }

    public void setTransferMethod(String transferMethod) {
        this.transferMethod = transferMethod;
    }
    

    @Override
    public String toFileString() {
        StringBuilder sb = new StringBuilder(super.toFileString());
        sb.append("|").append(bankName).append("|");
        sb.append(accountName).append("|");
        sb.append(referenceNumber).append("|");
        sb.append(isInternational ? "1" : "0").append("|");
        sb.append(transferMethod);
        
        return sb.toString();
    }
    

    public static BankTransfer fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 14) {
            throw new IllegalArgumentException("Invalid file string format for BankTransfer");
        }
        
        int id = Integer.parseInt(parts[0]);
        int bookingId = Integer.parseInt(parts[1]);
        int studentId = Integer.parseInt(parts[2]);
        int tutorId = Integer.parseInt(parts[3]);
        double amount = Double.parseDouble(parts[4]);
        String date = parts[5];
        String status = parts[6];
        String transactionId = parts[7];
        String bankName = parts[9];
        String accountName = parts[10];
        String referenceNumber = parts[11];
        boolean isInternational = "1".equals(parts[12]);
        String transferMethod = parts[13];
        
        return new BankTransfer(id, bookingId, studentId, tutorId, amount, date, status, transactionId,
                              bankName, accountName, referenceNumber, isInternational, transferMethod);
    }


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append("Bank Name: ").append(bankName).append("\n");
        sb.append("Account Name: ").append(accountName).append("\n");
        sb.append("Reference Number: ").append(referenceNumber).append("\n");
        sb.append("International: ").append(isInternational ? "Yes" : "No").append("\n");
        sb.append("Transfer Method: ").append(transferMethod).append("\n");
        
        return sb.toString();
    }
}
