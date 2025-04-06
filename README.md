🛠️ Backend Overview – Barber Shop Booking System

The backend is the core engine behind the booking system, handling business logic, data persistence, validation, and communication services like OTP verification.

---

⚙️ Key Responsibilities

    User Booking Flow
    Handles service selection, date/time slot validation, and personal detail submissions.

    OTP Verification via Viber
    Integrates with a third-party service to send one-time passwords via Viber for phone number verification.

        Stores and tracks verification attempts

        Marks reservations as validated or unvalidated based on OTP outcome

    Reservation Management

        Stores bookings in a database with associated metadata (status, timestamps, etc.)

        Handles logic for availability based on services, barbers, and time slots

        Prevents double-booking via locking or time slot reservations

    Business Owner Setup Flow

        Manages onboarding process through a dynamic questionnaire

        Persists business configurations: shops, services, barbers, and schedules

        Supports CRUD operations for all core entities

---

🗃️ Technologies

    Java Spring Boot for server related tasks

    MySQL for database

    Viber API / Messaging Service for OTP delivery

    JWT / OAuth for secure authentication
