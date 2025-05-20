package com.hsbt.service;

import com.hsbt.model.Booking;
import com.hsbt.model.OnlineBooking;
import com.hsbt.model.InPersonBooking;
import com.hsbt.model.Student;
import com.hsbt.model.Tutor;
import com.hsbt.config.DatabaseConfig;
import com.hsbt.util.FileIOUtil;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


public class BookingManagementService {
    private List<Booking> bookings;
    private static BookingManagementService instance;
    private int nextId;
    private String bookingsFilePath;
    private TutorManagementService tutorService;
    private StudentManagementService studentService;


    private BookingManagementService() {
        bookings = new ArrayList<>();
        nextId = 1;
        

        DatabaseConfig.ensureDirectoriesExist();
        

        bookingsFilePath = DatabaseConfig.getBookingsFilePath();
        

        tutorService = TutorManagementService.getInstance();
        studentService = StudentManagementService.getInstance();
        

        loadBookings();
    }


    public static synchronized BookingManagementService getInstance() {
        if (instance == null) {
            instance = new BookingManagementService();
        }
        return instance;
    }


    public Booking createBooking(Booking booking) {

        if (booking.getId() <= 0) {
            booking.setId(nextId++);
        }
        

        bookings.add(booking);
        

        saveBookings();
        
        return booking;
    }


    public Booking getBookingById(int id) {
        for (Booking booking : bookings) {
            if (booking.getId() == id) {
                return booking;
            }
        }
        return null;
    }


    public boolean updateBooking(Booking booking) {
        for (int i = 0; i < bookings.size(); i++) {
            if (bookings.get(i).getId() == booking.getId()) {
                bookings.set(i, booking);
                saveBookings();
                return true;
            }
        }
        return false;
    }


    public boolean deleteBooking(int id) {
        for (int i = 0; i < bookings.size(); i++) {
            if (bookings.get(i).getId() == id) {
                bookings.remove(i);
                saveBookings();
                return true;
            }
        }
        return false;
    }
    

    public boolean cancelBooking(int id) {
        Booking booking = getBookingById(id);
        if (booking != null) {
            booking.setStatus("Cancelled");
            saveBookings();
            return true;
        }
        return false;
    }


    public List<Booking> getAllBookings() {
        return new ArrayList<>(bookings);
    }
    

    public List<Booking> getUpcomingBookings() {
        return bookings.stream()
                .filter(Booking::isUpcoming)
                .collect(Collectors.toList());
    }
    

    public List<Booking> getPastBookings() {
        return bookings.stream()
                .filter(Booking::isPast)
                .collect(Collectors.toList());
    }
    

    public List<Booking> getBookingsByStudentId(int studentId) {
        return bookings.stream()
                .filter(b -> b.getStudentId() == studentId)
                .collect(Collectors.toList());
    }
    

    public List<Booking> getBookingsByTutorId(int tutorId) {
        return bookings.stream()
                .filter(b -> b.getTutorId() == tutorId)
                .collect(Collectors.toList());
    }
    

    public List<Booking> getBookingsByDate(String date) {
        return bookings.stream()
                .filter(b -> b.getDate().equals(date))
                .collect(Collectors.toList());
    }
    

    public List<Booking> getBookingsByStatus(String status) {
        return bookings.stream()
                .filter(b -> b.getStatus().equals(status))
                .collect(Collectors.toList());
    }
    

    public double calculateBookingPrice(int tutorId, double hours) {
        Tutor tutor = tutorService.getTutorById(tutorId);
        
        if (tutor == null) {
            return 0.0;
        }
        
        return tutor.getHourlyRate() * hours;
    }
    

    public boolean isTutorAvailable(int tutorId, String date, String startTime, String endTime) {

        Tutor tutor = tutorService.getTutorById(tutorId);
        if (tutor == null || !tutor.isAvailable()) {
            return false;
        }
        

        List<Booking> tutorBookings = getBookingsByTutorId(tutorId);
        
        for (Booking booking : tutorBookings) {

            if ("Cancelled".equals(booking.getStatus())) {
                continue;
            }
            

            if (booking.getDate().equals(date)) {

                if (isTimeConflict(startTime, endTime, booking.getStartTime(), booking.getEndTime())) {
                    return false;
                }
            }
        }
        
        return true;
    }
    

    private boolean isTimeConflict(String start1, String end1, String start2, String end2) {
        try {

            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
            
            LocalDate.parse(today + " " + start1, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            LocalDate.parse(today + " " + end1, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            LocalDate.parse(today + " " + start2, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            LocalDate.parse(today + " " + end2, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            

            return (start1.compareTo(end2) < 0 && end1.compareTo(start2) > 0);
        } catch (DateTimeParseException e) {

            return true;
        }
    }


    private void loadBookings() {
        try {
            if (!FileIOUtil.fileExists(bookingsFilePath)) {

                createSampleBookings();
                return;
            }


            List<String> lines = FileIOUtil.readLinesFromFile(bookingsFilePath);


            bookings.clear();


            for (String line : lines) {
                try {
                    Booking booking = Booking.fromFileString(line);
                    bookings.add(booking);


                    if (booking.getId() >= nextId) {
                        nextId = booking.getId() + 1;
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing booking: " + e.getMessage());
                }
            }


            if (bookings.isEmpty()) {
                createSampleBookings();
            }
        } catch (Exception e) {
            System.err.println("Error loading bookings: " + e.getMessage());
            createSampleBookings();
        }
    }


    private void saveBookings() {
        try {

            List<String> lines = new ArrayList<>();


            for (Booking booking : bookings) {
                String line = booking.toFileString();
                if (line != null) {
                    lines.add(line);
                }
            }


            FileIOUtil.writeLinesToFile(bookingsFilePath, lines);

        } catch (Exception e) {
            System.err.println("Error saving bookings: " + e.getMessage());
        }
    }


    private void createSampleBookings() {

        List<Tutor> tutors = tutorService.getAllTutors();
        List<Student> students = studentService.getAllStudents();
        
        if (tutors.isEmpty() || students.isEmpty()) {
            return;
        }
        

        LocalDate today = LocalDate.now();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        

        OnlineBooking onlineBooking = new OnlineBooking(
            nextId++,
            students.get(0).getId(),
            tutors.get(0).getId(),
            "Mathematics",
            today.plusDays(3).format(dateFormatter),
            "14:00",
            "16:00",
            1500.0,
            "Confirmed",
            "Please prepare calculus problems",
            "Zoom",
            "https://zoom.us/j/123456789",
            "123456789",
            "password123",
            true
        );
        bookings.add(onlineBooking);
        

        InPersonBooking inPersonBooking = new InPersonBooking(
            nextId++,
            students.get(1).getId(),
            tutors.get(1).getId(),
            "Physics",
            today.plusDays(5).format(dateFormatter),
            "10:00",
            "12:00",
            2000.0,
            "Confirmed",
            "Focus on mechanics",
            "Library",
            "123 Main St, City Library, Room 5",
            true,
            false,
            0.0
        );
        bookings.add(inPersonBooking);
        

        OnlineBooking pastBooking = new OnlineBooking(
            nextId++,
            students.get(0).getId(),
            tutors.get(0).getId(),
            "Mathematics",
            today.minusDays(7).format(dateFormatter),
            "14:00",
            "16:00",
            3000.0,
            "Completed",
            "Covered algebra basics",
            "Google Meet",
            "https://meet.google.com/abc-defg-hij",
            "abc-defg-hij",
            "",
            false
        );
        bookings.add(pastBooking);
        

        InPersonBooking cancelledBooking = new InPersonBooking(
            nextId++,
            students.get(1).getId(),
            tutors.get(1).getId(),
            "Chemistry",
            today.minusDays(2).format(dateFormatter),
            "15:00",
            "17:00",
            2500.0,
            "Cancelled",
            "Student cancelled due to illness",
            "Student's Home",
            "456 Oak Ave, Apt 7B",
            true,
            true,
            1000.0
        );
        bookings.add(cancelledBooking);
        

        saveBookings();
    }
}
